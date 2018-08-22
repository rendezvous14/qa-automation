__author__ = 'Nattapol Wilarat'
import psycopg2
import pprint

"""#####################################################################################################################
    Name: Get connection string
    Argument:
        - username
        - password
        - hostname
        - database_name
    Purpose:
        - create connection string for querying database
#####################################################################################################################"""
def get_connection_string(db_host, database_name, username, password):

    conn_string = "host='%s' dbname='%s' user='%s' password='%s'" % (db_host, database_name, username, password)
    print "Connecting to database\n	->%s" % (conn_string)

    return  conn_string

"""#####################################################################################################################
    Keyword Name: query_inventory_item
    Argument:
        - connection string
        - partner_id
        - partner_item_id
        - expected qty_ats
        - expected qty_sum_onhand
        - expected qty_coolroom
        - expected qty_highvalue
        - expected qty_general
        - expected qty_quarantine
        - expected qty_return
    Purpose:
        - For query qty after receipt
#####################################################################################################################"""
def query_inventory_item( conn_string, partner_id, partner_item_id,
                            qty_ats, qty_sum_onhand,
                            qty_coolroom, qty_highvalue,
                            qty_general, qty_quarantine,
                            qty_return):

    ##### get a connection, if a connect cannot be made an exception will be raised here
    print "Connecting to database\n	->%s" % (conn_string)
    conn = psycopg2.connect(conn_string)

    ##### conn.cursor will return a cursor object, you can use this cursor to perform queries
    cursor = conn.cursor()

    try:
        sql = "SELECT   ii.qty_ats," \
                        "wi.qty_onhand," \
                        "wi.qty_coolroom," \
                        "wi.qty_highvalue," \
                        "wi.qty_general," \
                        "wi.qty_quarantine," \
                        "wi.qty_return," \
                        "ii.key," \
                        "ii.partner_item_id" \
                " FROM inventory_warehouseitem wi" \
                " LEFT JOIN inventory_item ii  ON wi.item_id = ii.key" \
                " WHERE ii.partner_id = '%s'" \
                " AND ii.partner_item_id = '%s'" % (partner_id, partner_item_id)
        print("SQL : " + sql)
    except Exception as e :
        raise e

    ##### execute our Query
    cursor.execute(sql)
    records = cursor.fetchone()
    pprint.pprint(records)

    ##### verify qty_ats
    print "qty_ats on inventory_item = %s" % (records[0])
    print "expected qty_ats = %s" % (qty_ats)
    if records[0] == int(qty_ats) :
        print "qty_ats is correct"
    else:
        raise  Exception("qty_ats is incorrect")

    #### verify qty_sum_onhand
    print "qty_sum_onhand on inventory_item = %s" % (records[1])
    print "expected qty_sum_onhand = %s" % (qty_sum_onhand)
    if records[1] == int(qty_sum_onhand) :
        print "qty_sum_onhand is correct"
    else:
        raise  Exception("qty_sum_onhand is incorrect")

    #### verify qty_coolroom
    print "qty_coolroom on inventory_item = %s" % (records[2])
    print "expected qty_coolroom = %s" % (qty_coolroom)
    if records[2] == int(qty_coolroom) :
        print "qty_coolroom is correct"
    else:
        raise  Exception("qty_coolroom is incorrect")

    #### verify qty_highvalue
    print "qty_highvalue on inventory_item = %s" % (records[3])
    print "expected qty_highvalue = %s" % (qty_highvalue)
    if records[3] == int(qty_highvalue) :
        print "qty_highvalue is correct"
    else:
        raise  Exception("qty_highvalue is incorrect")

    #### verify qty_general
    print "qty_general on inventory_item = %s" % (records[4])
    print "expected qty_general = %s" % (qty_general)
    if records[4] == int(qty_general) :
        print "qty_general is correct"
    else:
        raise  Exception("qty_general is incorrect")

    #### verify qty_quarantine
    print "qty_quarantine on inventory_item = %s" % (records[5])
    print "expected qty_quarantine = %s" % (qty_quarantine)
    if records[5] == int(qty_quarantine) :
        print "qty_quarantine is correct"
    else:
        raise  Exception("qty_quarantine is incorrect")

    #### verify qty_return
    print "qty_return on inventory_item = %s" % (records[6])
    print "expected qty_return = %s" % (qty_return)
    if records[6] == int(qty_return) :
        print "qty_return is correct"
    else:
        raise  Exception("qty_return is incorrect")

    cursor.close()
    return  0

"""#####################################################################################################################
    Name: query_inventory_demand
    Argument:
        - so_key
        - item_key
    Purpose:
        - For query qty after fulfillmented
#####################################################################################################################"""
def query_inventory_demand(so_key, item_key, line_number):
    so_key = so_key[1:-1]
    item_key = item_key[1:-1]
    conn_string = get_connection_string()
    print "Connecting to database\n	->%s" % (conn_string)

    conn = psycopg2.connect(conn_string)
    cursor = conn.cursor()

    sql = "SELECT QTY_PRODUCT,QTY_ITEM_PER_PRODUCT, " \
          "QTY_AFTER_RESERVED,QTY_AFTER_FULFILLED " \
          "FROM INVENTORY_DEMAND " \
          "WHERE SO_KEY = '%s' AND ITEM_ID = '%s' AND LINE_NUMBER = '%s'" % (so_key, item_key, line_number)

    print("SQL : " + sql)

    cursor.execute(sql)
    records = cursor.fetchone()
    return records



# """#####################################################################################################################
#     Name: query_inventory_warehouseitem
#     Argument:
#         - so_key
#         - item_key
#     Purpose:
#         - For query qty after receipt
# #####################################################################################################################"""
# def query_inventory_warehouseitem(field_list, item_key):
#     item_key = item_key[1:-1]
#     conn_string = get_connection_string()
#     print "Connecting to database\n	->%s" % (conn_string)
#
#     conn = psycopg2.connect(conn_string)
#     cursor = conn.cursor()
#
#     sql = "SELECT QTY_ONHAND, %s " \
#           "FROM INVENTORY_WAREHOUSEITEM " \
#           "WHERE ITEM_ID = '%s'" % (field_list, item_key)
#
#     print("SQL : " + sql)
#
#     cursor.execute(sql)
#     records = cursor.fetchone()
#     return records
#
#
# """#####################################################################################################################
#     Name: update_inventory_item
#     Argument:
#         - item_key
#     Purpose:
#         - update data on table update_inventory_item
# #####################################################################################################################"""
# def update_inventory_item(item_key):
#     conn_string = get_connection_string()
#     print "Connecting to database\n	->%s" % (conn_string)
#
#     conn = psycopg2.connect(conn_string)
#     cursor = conn.cursor()
#
#     sql = "UPDATE INVENTORY_ITEM " \
#           "SET QTY_ATS = 0 , QTY_SUM_ONHAND = 0 " \
#           "WHERE KEY IN (%s)" % (item_key)
#
#     print("SQL : " + sql)
#
#     cursor.execute(sql)
#     conn.commit()
#     cursor.close()
#     conn.close()
#
#
# """#####################################################################################################################
#     Name: delete data on table inventory_demand
#     Argument:
#         - so_key
#     Purpose:
#         - Clear data so on table inventory_demand
# #####################################################################################################################"""
# def delete_data_inventory_demand(so_key):
#     conn_string = get_connection_string()
#     print "Connecting to database\n	->%s" % (conn_string)
#
#     conn = psycopg2.connect(conn_string)
#     cursor = conn.cursor()
#     cursor.execute("delete from inventory_demand where so_key in (%s)" %(so_key))
#
#     conn.commit()
#     cursor.close()
#     conn.close()
#
#
# """#####################################################################################################################
#     Name: delete data on table inventory_demand
#     Argument:
#         - item_list
#     Purpose:
#         -
# #####################################################################################################################"""
# def delete_data_inventory_warehouseitem(partner_id, item_list):
#     print("ITEM list : " + item_list)
#     conn_string = get_connection_string()
#     print "Connecting to database\n	->%s" % (conn_string)
#
#     conn = psycopg2.connect(conn_string)
#     cursor = conn.cursor()
#     cursor.execute("delete from inventory_warehouseitem where partner_id = '%s' and item_id in (%s)" %(partner_id, item_list))
#
#     conn.commit()
#     cursor.close()
#     conn.close()
