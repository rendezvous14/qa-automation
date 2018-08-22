__author__ = 'Patatip'

import requests
import json
import Producer.producer
from flask import Flask
from flask import request, Response

##### EXCHANGE_NAME #####
G_RABBIT_ECHANGE_DOWNLOAD_QA = "download.SCALE_QA"
G_RABBIT_ECHANGE_UPLOAD_QA = "upload.SCALE_QA"
G_RABBIT_ECHANGE_DOWNLOAD_STAGING = "download.SCALE_STAGING"
G_RABBIT_ECHANGE_UPLOAD_STAGING = "upload.SCALE_STAGING"
G_RABBIT_ECHANGE_COMMON_RS = "ims-order-processing-engine"

##### ROUTING_KEY_NAME #####
G_ROUTING_KEY_COMPANY_DOWNLOAD = "ws.company-Downloaded"
G_ROUTING_KEY_ITEM_DOWNLOAD = "ws.items-Downloaded"
G_ROUTING_KEY_PO_DOWNLOAD = "ws.purchaseOrder-Downloaded"
G_ROUTING_KEY_RECEIPTS_DOWNLOAD = "ws.receipts-Downloaded"
G_ROUTING_KEY_ORDER_DOWNLOAD = "ws.order-Downloaded"

G_ROUTING_KEY_GRN_UPLOAD = "upload.goodsReceipt"
G_ROUTING_KEY_PUTAWAY_COMPLETE_UPLOAD = "upload.putawayComplete"
G_ROUTING_KEY_FULFILLMENT_CONFIRM_UPLOAD = "upload.fulfillmentConfirm"
G_ROUTING_KEY_ONHAND_ADJ_UPLOAD = "upload.onHandAdjust"
G_ROUTING_KEY_AVAI_ADJ_UPLOAD = "upload.availableAdjust"
G_ROUTING_KEY_EXPIRY_CHANGE_UPLOAD = "upload.expiryChange"
G_ROUTING_KEY_FULFILLMENT_ALO_UPLOAD = "upload.fulfillmentAllocated"

G_ROUTING_KEY_BACK_ORDER_RESOLVE = "#"

##### EXCHANGE_TYPE #####
G_EXCHANGE_TYPE ="topic"

##### URL #####
#G_URL_MANH_QA = "amqp://ScaleBridge:h92SBj210u90Xl@rabbitcluster.acommercedev.platform:5672/ScaleBridge-qa"
G_URL_MANH_QA = "amqp://admin:aCom1234@dev-rabbit-cluster-1a-1.acommercedev.platform:5672/ScaleBridge-qa"
G_URL_COMMON_QA = "amqp://qaautomation:kEzcpLpAWhxA4ZaS@dev-rabbit-cluster-1a-1.acommercedev.platform:5672/beehive-qa"

class MyFlask(Flask):
    def __init__(self,*args,**kwargs):
        self.retry = 0
        super(MyFlask,self).__init__(*args,**kwargs)

app = MyFlask(__name__)

###################### list of downloading document (App act as Beehive) ################################
def company_download(data,URL_MANH=None,rabbit_exchange_download=None,routing_key=None):
    print("Company download")
    
    if routing_key is None:
        routing_key = G_ROUTING_KEY_COMPANY_DOWNLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_download is None:
        rabbit_exchange_download = G_RABBIT_ECHANGE_DOWNLOAD

    priority = 1
    company = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_download,G_EXCHANGE_TYPE, company, routing_key,priority)
    return company

def item_download(data,URL_MANH=None,rabbit_exchange_download=None,routing_key=None):
    print("Item download")
    
    if routing_key is None:
        routing_key = G_ROUTING_KEY_ITEM_DOWNLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_download is None:
        rabbit_exchange_download = G_RABBIT_ECHANGE_DOWNLOAD

    priority = 1
    item = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_download,G_EXCHANGE_TYPE, item, routing_key,priority)
    return item

def po_download(data,URL_MANH=None,rabbit_exchange_download=None,routing_key=None):
    print("Po download")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_PO_DOWNLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_download is None:
        rabbit_exchange_download = G_RABBIT_ECHANGE_DOWNLOAD

    priority = 1
    po = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_download,G_EXCHANGE_TYPE, po, routing_key,priority)
    return po

def receipt_download(data,URL_MANH=None,rabbit_exchange_download=None,routing_key=None):
    print("Receipt download")
    
    if routing_key is None:
        routing_key = G_ROUTING_KEY_RECEIPTS_DOWNLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_download is None:
        rabbit_exchange_download = G_RABBIT_ECHANGE_DOWNLOAD

    priority = 1
    receipt = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_download,G_EXCHANGE_TYPE, receipt, routing_key,priority)
    return receipt

def order_download(data,URL_MANH=None,rabbit_exchange_download=None,routing_key=None):
    print("Order download")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_ORDER_DOWNLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_download is None:
        rabbit_exchange_download = G_RABBIT_ECHANGE_DOWNLOAD

    priority = 1
    order = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_download,G_EXCHANGE_TYPE, order, routing_key,priority)
    return order

###################### list of uploading document (App act as Scale) ################################
def grn_upload(data,URL_MANH=None,rabbit_exchange_upload=None,routing_key=None):
    print("goodsReceipt upload")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_GRN_UPLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_upload is None:
        rabbit_exchange_upload = G_RABBIT_ECHANGE_UPLOAD

    priority = 1
    grn = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_upload,G_EXCHANGE_TYPE, grn, routing_key,priority)
    return grn

def putaway_complete_upload(data,URL_MANH=None,rabbit_exchange_upload=None,routing_key=None):
    print("putaway upload")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_PUTAWAY_COMPLETE_UPLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_upload is None:
        rabbit_exchange_upload = G_RABBIT_ECHANGE_UPLOAD

    priority = 1
    putaway = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_upload,G_EXCHANGE_TYPE, putaway, routing_key,priority)
    return putaway

def order_confirm_upload(data,URL_MANH=None,rabbit_exchange_upload=None,routing_key=None):
    print("order confirm upload")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_FULFILLMENT_CONFIRM_UPLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_upload is None:
        rabbit_exchange_upload = G_RABBIT_ECHANGE_UPLOAD

    priority = 1
    order = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_upload,G_EXCHANGE_TYPE, order, routing_key,priority)
    return order

def inventory_onhand_upload(data,URL_MANH=None,rabbit_exchange_upload=None,routing_key=None):
    print("inventory onhand upload")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_ONHAND_ADJ_UPLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_upload is None:
        rabbit_exchange_upload = G_RABBIT_ECHANGE_UPLOAD

    priority = 1
    onhand = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_upload,G_EXCHANGE_TYPE, onhand, routing_key,priority)
    return onhand

def inventory_avai_upload(data,URL_MANH=None,rabbit_exchange_upload=None,routing_key=None):
    print("inventory available upload")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_AVAI_ADJ_UPLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_upload is None:
        rabbit_exchange_upload = G_RABBIT_ECHANGE_UPLOAD

    priority = 1
    avai = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_upload,G_EXCHANGE_TYPE, avai, routing_key,priority)
    return avai

def expiry_change_upload(data,URL_MANH=None,rabbit_exchange_upload=None,routing_key=None):
    print("Expiry change upload")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_EXPIRY_CHANGE_UPLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_upload is None:
        rabbit_exchange_upload = G_RABBIT_ECHANGE_UPLOAD

    priority = 1
    expiry = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_upload,G_EXCHANGE_TYPE, expiry, routing_key,priority)
    return expiry

def ff_allocate_upload(data,URL_MANH=None,rabbit_exchange_upload=None,routing_key=None):
    print("Fulfillment allocate upload")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_FULFILLMENT_ALO_UPLOAD
    if URL_MANH is None:
        URL_MANH = G_URL_MANH
    if rabbit_exchange_upload is None:
        rabbit_exchange_upload = G_RABBIT_ECHANGE_UPLOAD

    priority = 1
    allocate = data

    Producer.producer.publish_message_to_rabbitmq(URL_MANH,rabbit_exchange_upload,G_EXCHANGE_TYPE, allocate, routing_key,priority)
    return allocate

def so_back_order_resolve(data,URL_COMMON_QA=None,rabbit_exchange_common=None,routing_key=None):
    print("Back order resolve")

    if routing_key is None:
        routing_key = G_ROUTING_KEY_BACK_ORDER_RESOLVE
    if URL_COMMON_QA is None:
        URL_COMMON_QA = G_URL_COMMON_QA
    if rabbit_exchange_common is None:
        rabbit_exchange_common = G_RABBIT_ECHANGE_COMMON_RS

    priority = 1
    back_order_resolve = data

    back_order_resolve_json = json.loads(back_order_resolve)
    Producer.producer.publish_message_to_q_rabbitmq(URL_COMMON_QA,rabbit_exchange_common,G_EXCHANGE_TYPE, back_order_resolve_json, routing_key,priority)
    return back_order_resolve

#####################################################################################
if __name__ == '__main__':
        print("Start MockingQ App")
        app.debug = True
        app.run(host='0.0.0.0')


