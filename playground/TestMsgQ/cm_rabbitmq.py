# https://github.com/ctradu/robotframework-amqp/blob/develop/AMQPLib/AMQPMsg.py

import time
import pika
from robot.api import logger


class cm_rabbitmq:

    """
    Connect to an AMQP server and receive messages or send messages in Robotframework
    """

    def __init__(self, timeout=10):
        self.amqp_addr = ""
        self.amqp_connection = None
        self.amqp_channel = None
        self.exchange = ""
        self.routing_key = ""
        self.queue = ""

        self.amqp_timeout = timeout

    def init_rabbitmq_connection(self, amqp_host, amqp_port,
                                 amqp_user, amqp_pass, amqp_vhost):
        """
        Init the connection to the amqp server
        Example:
        *** Keywords ***
        Before tests
            Init AMQP connection    ${amqp_host}  ${amqp_port}   ${amqp_user}  ${amqp_pass}   ${amqp_vhost}
        """
        self.amqp_addr = "amqp://{user}:{passwd}@{host}:{port}/{vhost}".format(user=amqp_user,
                                                                               passwd=amqp_pass,
                                                                               host=amqp_host,
                                                                               port=amqp_port,
                                                                               vhost=amqp_vhost)

        logger.info("AMQP connect to: {}".format(self.amqp_addr))
        params = pika.URLParameters(self.amqp_addr)
        self.amqp_connection = pika.BlockingConnection(parameters=params)
        self.amqp_channel = self.amqp_connection.channel()

    def close_rabbitmq_connection(self):
        """
        Close the amqp connection
        Usage:
        *** Keywords ***
        After tests
            close amqp connection
        """
        self.amqp_connection.close()

    def set_rabbitmq_exchage_routing_key(self, exchange, routing_key):
        """
        Set exchage and routing_key for subsequent send_amqp_msg calls
        :param exchange:    amqp exchange name
        :param routing_key: amqp routing_key
        """
        self.exchange = exchange
        self.routing_key = routing_key

    def set_rabbitmq_queue(self, amqp_queue):
        """
        Set queue to listen to and declare it on AMQP server for
        the subsequent get_amqp_msg calls
        :param amqp_queue string:
        """
        self.queue = amqp_queue
        self.amqp_channel.queue_declare(queue=self.queue, exclusive=True)

    def bind_rabbitmq_exchage_routing_key_to_queue(self, exchange=None, routing_key=None):
        """
        Set queue to bind with exchange and routing key
        :param exchange:    amqp exchange name
        :param routing_key: amqp routing_key
        """
        amqp_exchange = exchange if exchange is not None else self.exchange
        amqp_routing_key = routing_key if routing_key is not None else self.routing_key
        self.amqp_channel.queue_bind(exchange=amqp_exchange,
                                     queue=self.queue,
                                     routing_key=amqp_routing_key)

    def send_rabbitmq_msg(self, msg, exchange=None, routing_key=None):
        """
        Send one message via AMQP
        :param msg:
        :param exchange: name of the exchange to send the message to; default: self.exchange
        :param routing_key: the routing key to use; default is self.routing_key
        """
        amqp_exchange = exchange if exchange is not None else self.exchange
        amqp_routing_key = routing_key if routing_key is not None else self.routing_key

        logger.info(
            "AMQP send ---> ({} / {})".format(amqp_exchange, amqp_routing_key))
        logger.info("AMQP msg to send: {}".format(msg))

        self.amqp_channel.basic_publish(exchange=amqp_exchange,
                                        routing_key=amqp_routing_key,
                                        body=msg,
                                        properties=pika.spec.BasicProperties(
                                            content_type='application/json'
                                        ))

    def get_rabbitmq_msg(self, msg_number=1, queue=None):
        """
        Get at least 1 message from the configured queue
        :param msg_number:  number of messages to consume form the queue
        :param queue:   queue_name to listen to; if missing listen to the queue configured via set_amqp_queue
        :return:
        """

        queue_name = queue if queue is not None else self.queue
        received_messages = []
        reach_msg_count = False
        max_retry = 10
        num_retry = 0

        while not reach_msg_count:

            ev_method, ev_prop, ev_body = self.amqp_channel.basic_get(queue_name)
            if ev_method:
                logger.info("AMQP received <-- {}".format(ev_body))
                self.amqp_channel.basic_ack(ev_method.delivery_tag)
                received_messages.append(ev_body)
                if ev_method.delivery_tag == msg_number and msg_number>0:
                    reach_msg_count = True
            else:
                num_retry = num_retry + 1
                reach_msg_count = True

        requeued_messages = self.amqp_channel.cancel()
        logger.info("AMQP requeued after {} received: {}".format(
            msg_number, requeued_messages))

        return received_messages
