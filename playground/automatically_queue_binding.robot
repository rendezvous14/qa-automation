*** Settings ***
Force Tags        Parallel
Library           ../libs/rabbit/bh_rabbitmq.py
Resource          ../test_suite/resource/group_vars/${env}/global_resource.robot
Resource          ../test_suite/resource/resource_rabbitmq_method.robot
Test Setup        Initial Queue


*** Variable ***

*** Test Cases ***
MQ_01
    ${prefixName}=   Set Variable   ${TEST NAME}  
    Bind Queue to Exchange   status   ${prefixName}.robot.item_sales_order  robot.abc.#
    sleep   30s

MQ_02
    ${prefixName}=   Set Variable   ${TEST NAME}  
    Bind Queue to Exchange   status   ${prefixName}.robot.item_sales_order  robot.abc.#
    sleep   30s

MQ_03
    ${prefixName}=   Set Variable   ${TEST NAME}  
    Bind Queue to Exchange   status   ${prefixName}.robot.item_sales_order  robot.abc.#
    sleep   30s

*** Keywords ***
Bind Queue to Exchange
    [Arguments]   ${exchange}   ${queueName}  ${routingKey}
    set_rabbitmq_queue     ${queueName}
    bind_rabbitmq_exchage_routing_key_to_queue   ${exchange}   ${routingKey}