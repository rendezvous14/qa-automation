*** Settings ***
# Library           ExtendedSelenium2Library
Library           SeleniumLibrary
Library           HttpLibrary.HTTP
Library           String
Library           OperatingSystem
Library           Dialogs
Library           DateTime
Library           Collections
Library           ../../libs/sftp/sftp.py
Library           ../../libs/rabbit/rabbit.py
Library           ../../custom_keyword/sale_order/so_library.py
Library           ../../libs/mocking_queue/MockingQ.py
Library           ../../libs/rabbit/bh_rabbitmq.py
