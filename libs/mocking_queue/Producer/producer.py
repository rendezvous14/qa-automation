
from kombu import Connection, Exchange

"""#####################################################################################################################
    Name: publish_to_rabbitmq
    Argument:
        - rabbit_mq_url
        - exchange
        - message
        - routing_key
        - priority
    Purpose:
        - To publish message to rabbit MQ
#####################################################################################################################"""
def publish_message_to_rabbitmq(rabbit_mq_url, exchange, exchage_type, message, routing_key,priority):

    media_exchange = Exchange(exchange, exchage_type, durable=True)
    # connection
    with Connection(rabbit_mq_url) as conn:
        #producer = conn.Producer(serializer='json',routing_key=routing_key, exchange=media_exchange)

        #WORK
        producer = conn.Producer(routing_key=routing_key, exchange=media_exchange)
        producer.publish(message,priority=priority)


def publish_message_to_q_rabbitmq(rabbit_mq_url, exchange, exchage_type, message, routing_key,priority):

    media_exchange = Exchange(exchange, exchage_type, durable=True)
    # connection
    with Connection(rabbit_mq_url) as conn:
        simple_queue = conn.SimpleQueue('ha.ims-backorder-resolve')
        print('type message =', type(message))
        simple_queue.put(message)
        simple_queue.close()
