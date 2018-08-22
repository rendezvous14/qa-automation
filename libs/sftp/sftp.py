__author__ = 'Aphisada Inthasara'
# coding=utf-8
from robot.api import logger
import pysftp
import traceback

"""#####################################################################################################################
    Name:info
    Argument:
        arg = Message into logger
#####################################################################################################################"""
def info(arg):
    logger.info(arg)


"""#####################################################################################################################
    Name: put_file_from_local_to_sftp_server
    Argument:
        ftp_host = Host name
        file_name = File name
        username = username to login sftp server
        password = password to login sftp server
        ftp_path = destination sftp path
(host="sftp.platform.acommercedev.com", port=22, timeout=30*5)
#####################################################################################################################"""
def put_file_from_local_to_sftp_server(ftp_host, file_name, username, password, ftp_path):
    try:
        info("Connect to sftp server ....")
        svr = pysftp.Connection(ftp_host, username=username, password=password)
        sftp_path = ftp_path

        if svr.isdir(sftp_path):
            info("put " + file_name + " in to " + sftp_path)
            with svr.cd():
                svr.chdir(sftp_path)
                info(svr.pwd)
                svr.put(file_name, preserve_mtime=True)
            info(svr.pwd)
        else:
            info("Directory does not exist")
    except:
        info(traceback.print_exc())


"""#####################################################################################################################
    Name: create_folder_on_sftp_server
    Argument:
        ftp_host = Host name
        file_name = File name
        username = username to login sftp server
        password = password to login sftp server
        folder_path = destination sftp folder
#####################################################################################################################"""
def create_folder_on_sftp_server(ftp_host, username, password, folder_path):
    try:
        info("Connect to sftp server ....")
        svr = pysftp.Connection(ftp_host, username=username, password=password)

        if not svr.isdir(folder_path):
            info('mkdir: %s' % folder_path)
            svr.mkdir(folder_path)
            svr.chmod(folder_path, 777)
        else:
            info('dir %s already exist.' % folder_path)
    except:
        info(traceback.print_exc())
