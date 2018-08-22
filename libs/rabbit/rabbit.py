__author__ = 'Patatip'

from kombu import Connection, Exchange
import ast
import copy
import json

"""#####################################################################################################################
    Name: get_queue_message
    Argument:
        - rabbit MQ username, rabbit MQ password,rabbit MQ host, rabbit MQ virtual host, Queue name
    Purpose:
        - To read a data from rabbit MQ and return as json message
#####################################################################################################################"""

def consume_queue_from_rabbitmq(QUEUE_USERNAME,QUEUE_PASSWORD,QUEUE_HOST,QUEUE_VIRTUAL_HOST,QUEUE, type, expect_routing_key=None):

    msg_queue = connect_queue(QUEUE_USERNAME,QUEUE_PASSWORD,QUEUE_HOST,QUEUE_VIRTUAL_HOST,QUEUE)
    msg, payload =  get_queue_message(msg_queue, type)
    #get_routing_key(msg, expect_routing_key)
    partner_id = get_routing_key(msg, expect_routing_key)
    payload=json.dumps(payload)
    print payload
    return payload

def connect_queue(QUEUE_USERNAME,QUEUE_PASSWORD,QUEUE_HOST,QUEUE_VIRTUAL_HOST,QUEUE):
    #example of parameter
    #QUEUE_USERNAME='admin'
    #QUEUE_PASSWORD='admin'
    #QUEUE_HOST='queue.platform.acommercedev.com'
    #QUEUE_VIRTUAL_HOST='myvhost'
    #QUEUE='partner_master'

    url = "amqp://{0}:{1}@{2}:5672/{3}".format(
       QUEUE_USERNAME,
       QUEUE_PASSWORD,
       QUEUE_HOST,
       QUEUE_VIRTUAL_HOST)
    print("url :")+url
    #### open connection to QUEUE####
    con = Connection(url)
    msg_queue = con.SimpleQueue(QUEUE)
    return msg_queue

def get_routing_key(messages, expect_routing_key):

    for message in messages:
        #print(message.delivery_info)
        # routing_key = message.delivery_info.get("routing_key")
        routing_key = message.get("routing_key")
        if expect_routing_key is not None:
            if routing_key != expect_routing_key:
                raise Exception("Actual routing key is '"+ routing_key+"', but expect routing key is '" + expect_routing_key+"'")
	return routing_key

def get_queue_message(msg_queue, type):
    result_list = []
    payload_list = []

    ################# return lastest data in queue ##############
    if type == "SINGLE":
        message = msg_queue.get()
        #### transform to json ######
        result = message.payload
        result_list.append(message.delivery_info.copy())
        #payload_list.append(result)
        message.ack()
        return (result_list, result)
    ################# return all data in queue ##############
    elif type == "MULTIPLE":
        while(True):
            try:
                message = msg_queue.get(block=False)
            except Exception:
                return (result_list, payload_list)
            else:
                result_list.append(message.delivery_info.copy())
                payload_list.append(message.payload)
                message.ack()
            #if result is not None and len(result_list) < 5:
            # if message is not None:
            #     print(message.payload)
            #     result_list.append(message)
            #     message.ack()
            # else:
            #     return result_list
    else:
        raise Exception("Type could be SINGLE or MULTIPLE")

    msg_queue.close()

"""#####################################################################################################################
    Name: publish_to_rabbitmq
    Argument:
        - rabbit_mq_url
        - exchange
        - message
        - routing_key
    Purpose:
        - To publish message to rabbit MQ
#####################################################################################################################"""
def publish_message_to_rabbitmq(rabbit_mq_url, exchange, exchage_type, message, routing_key):
    message_list = []

    print("Exchange : " + exchange)
    #print("message : "+ message.text())
    #print("Exchange : " + exchange)
    #print("message : "+ message)
    media_exchange = Exchange(exchange, exchage_type, durable=True)
    # connection
    with Connection(rabbit_mq_url) as conn:
        # produce
        producer = conn.Producer(serializer='json',routing_key=routing_key, exchange=media_exchange)
        message_list.append(message)
        producer.publish(message)
    return message_list

def validate_message_from_quque(message_list, result_list):
    if(set(message_list) < set(result_list)):
        raise Exception("Not found message in status_exchange queue.")
