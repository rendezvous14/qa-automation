__author__ = 'Nattapol Wilarat'
from pymongo import MongoClient
from bson.json_util import dumps
import json

class mongodb:

    def __init__(self, timeout=10):
        self.db = None

    def connect_to_DB(self, username, password, host, database_name):
        global connection
        global db
        uri = "mongodb://%s:%s@%s" % (username, password, host)
        connection = MongoClient(uri)
        db = connection[database_name]
        print  db

    def get_one_from_collection(self, collection_name, search_field, projection):
        collection = db[collection_name]
        search_field = json.loads(search_field)
        if projection == "n/a":  # query with input key and filter only fields to display
            search_results = collection.find(search_field)
        else:
            projection = json.loads(projection)
            search_results = collection.find(search_field,projection)
        connection.close()
        result_list = list(search_results) # convert cursor to list
        result_convert_value = dumps(result_list)  # convert to json
        print (result_convert_value)
        return result_convert_value
