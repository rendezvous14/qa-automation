*** Settings ***
Library        cm_rabbitmq.py
Test Setup     Init Rabbitmq Connection  ${QUEUE_HOST}  ${QUEUE_PORT}  ${QUEUE_USERNAME}  ${QUEUE_PASSWORD}  ${VIRTUALHOST}
Test Teardown  Close Rabbitmq Connection

*** Test Cases ***
Consume Message from rabbitMq
  Set Rabbitmq Queue  ${QUEUE_NAME}
  Set Rabbitmq Exchage Routing Key  ${EXCHANGE}  ${ROUTING_KEY}
  Bind Rabbitmq Exchage Routing Key To Queue
  ${msgs}    Get Rabbitmq Msg  ${0}  #Get All Message
  ${msgs}    Get Rabbitmq Msg  ${1}  #Get Message INDEX[1]

Publish Message to rabbitMq
  Set Rabbitmq Exchage Routing Key  ${EXCHANGE}  ${ROUTING_KEY}
  Send Rabbitmq Msg  ${MESSAGE}
