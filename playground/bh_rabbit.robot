*** Settings ***
# Test Setup        Init Rabbitmq Connection    queue-channelsquid.acommercedev.service  5672   channelsquid  MnuSER7H920kfK   channelsquid
Library           libs/rabbit/bh_rabbitmq.py
Test Setup        Init Rabbitmq Connection    queue-common.acommercedev.service   5672   admin  aCom1234   ScaleBridge-qa
Test Teardown     Close Rabbitmq Connection

*** Test Cases ***
Test 1
  Test_Publish_and_Consume_MSG

*** Keywords ***
Test_Publish_and_Consume_MSG
    Set Rabbitmq Queue                          automation.upload.wms_scale
    Set Rabbitmq Exchage Routing Key            upload.WMS_SCALE   upload.goodsReceipt
    Bind Rabbitmq Exchage Routing Key To Queue
    Send Rabbitmq Msg                           Test
    ${msgs}=  Get Rabbitmq Msg  ${1}
    log     ${msgs}
