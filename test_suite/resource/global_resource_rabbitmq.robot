*** Settings ***
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Variables ***
${R_AUTHURIZATION_RQ}   ${CONFIG_AUTHURIZATION_RQ}
${R_USERNAME_RQ}    ${CONFIG_USERNAME_RQ}
${R_PASSWORD_RQ}    ${CONFIG_PASSWORD_RQ}
${R_HOST_RQ}      ${CONFIG_HOST_RQ}
${R_VHOST_BEEHIVE_RQ}    ${CONFIG_VHOST_BEEHIVE_RQ}
${R_VHOST_COMMON_RQ}    ${CONFIG_VHOST_COMMON_RQ}
${R_VHOST_SCALE_BRIDGE_RQ}    ${CONFIG_VHOST_SCALE_BRIDGE_RQ}
${R_Q_SO_STATUS_RQ}    ${CONFIG_Q_SO_STATUS_RQ}
${R_Q_ORDER_STATUS_RQ}    ${CONFIG_Q_ORDER_STATUS_RQ}

*** Keywords ***
# Call request
#     ${queue_mesgs}=    consume_msg_from_queue   common-qa   automation_sales_order_3904  10

Init Rabbit MQ
    [Arguments]    ${vhost}
    Init Rabbitmq Connection    queue-common.acommercedev.service   5672   admin  aCom1234   ${vhost}

Close Rabbit MQ
    Close Rabbitmq Connection

Consume Sales Order - Update queue
    [Arguments]   ${partner_id}
    Init Rabbit MQ    common-qa
    Set Rabbitmq Queue                  test_automation_update.${partner_id}
    Set Rabbitmq Exchage Routing Key    order   order.item_sales_order.update.th.${partner_id}
    Bind Rabbitmq Exchage Routing Key To Queue

Consume Sales Order - Create queue
    [Arguments]   ${partner_id}
    Init Rabbit MQ    common-qa
    Set Rabbitmq Queue                  test_automation_create.${partner_id}
    Set Rabbitmq Exchage Routing Key    order   order.item_sales_order.create.th.${partner_id}
    Bind Rabbitmq Exchage Routing Key To Queue

Consume Sales Order - Item mapper queue
    [Arguments]   ${partner_id}
    Init Rabbit MQ    common-qa
    Set Rabbitmq Queue                  test_automation_mapper.${partner_id}
    Set Rabbitmq Exchage Routing Key    status   mapper
    Bind Rabbitmq Exchage Routing Key To Queue

Consume Sales Order - Order status queue
    [Arguments]   ${partner_id}
    Init Rabbit MQ    common-qa
    Set Rabbitmq Queue                  test_automation_order_status.${partner_id}
    Set Rabbitmq Exchage Routing Key    status   status.order.fulfillment.${partner_id}.th.new
    Bind Rabbitmq Exchage Routing Key To Queue

Confirm Sales Order updated has been published to order exchange correctly
    [Arguments]     ${sales_order_key}
    ${msgs}=         Get Rabbitmq Msg  ${1}
    ${queue_msgs}=   Get From List     ${msgs}         0
    ${key_result}=   Get JSON Value    ${queue_msgs}   /key
    ${orderAction_result}=      Get JSON Value    ${queue_msgs}   /orderAction
    ${key_result}=   Remove String     ${key_result}   "
    ${orderAction_result}=      Remove String     ${orderAction_result}      "
    Should Be Equal    ${key_result}   ${salesOrderKey}
    Should Be Equal    ${orderAction_result}   UPDATE
    Close Rabbit MQ

Confirm Sales Order created has been published to order exchange correctly
    [Arguments]     ${sales_order_key}
    ${msgs}=         Get Rabbitmq Msg  ${1}
    ${queue_msgs}=   Get From List     ${msgs}         0
    ${key_result}=   Get JSON Value    ${queue_msgs}   /key
    ${orderAction_result}=      Get JSON Value    ${queue_msgs}   /orderAction
    ${key_result}=   Remove String     ${key_result}   "
    ${orderAction_result}=      Remove String     ${orderAction_result}      "
    Should Be Equal    ${key_result}   ${salesOrderKey}
    Should Be Equal    ${orderAction_result}   CREATE
    Close Rabbit MQ

Consume Message from RabbitMQ
    [Arguments]    ${vhost}  ${queue_name}  ${count}  ${is_ack}
    ##### Variables #####
    ${request_body}=  Set Variable  { "count": ${count}, "requeue": ${is_ack}, "encoding": "auto", "truncate": 50000 }
    ${path}=   Set Variable   /api/queues/${vhost}/${queue_name}/get
    ##### HTTP Request
    Create Http Context     ${R_HOST_RQ}    http
    Set Request Header      Content-Type    ${R_CONTENT_TYPE}
    Set Request Header      Authorization   ${R_AUTHURIZATION_RQ}
    Set Request Body        ${request_body}
    POST                    ${path}
    Response Status Code Should Equal    200
    ${resultJSONBody}=    Get Response Body
    Log Response Body
    [Return]   ${resultJSONBody}




    # ${msgs}=         consume_msg_from_queue   automation_sales_order_3904
    # ${queue_msgs}=   Get From List     ${msgs}         0
    # ${key_result}=   Get JSON Value    ${queue_msgs}   /key
    # ${orderAction_result}=      Get JSON Value    ${queue_msgs}   /orderAction
    # ${key_result}=   Remove String     ${key_result}   "
    # ${orderAction_result}=      Remove String     ${orderAction_result}      "
    # Should Be Equal    ${key_result}   ${salesOrderKey}
    # Should Be Equal    ${orderAction_result}   CREATE
    # Sleep   10s
    # Close Rabbit MQ

SCALE upload GRN to IMS
    [Arguments]    ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}
    Init Rabbit MQ   ScaleBridge-qa
    Set Rabbitmq Queue                          test_automation_grn.upload.wms_scale
    Set Rabbitmq Exchage Routing Key            upload.WMS_SCALE   upload.goodsReceipt
    Bind Rabbitmq Exchage Routing Key To Queue
    ${publishMsg}=   Prepare SCALE GRN for one item    ${template_file}  ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}
    Send Rabbitmq Msg    ${publishMsg}
    ${msgs}=  Get Rabbitmq Msg  ${1}
    Log     ${msgs}
    Sleep   10s
    Close Rabbit MQ

SCALE upload PUT AWAY to IMS
    [Arguments]    ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}   ${location_zone}
    Init Rabbit MQ    ScaleBridge-qa
    Set Rabbitmq Queue                          test_automation_put_away.upload.wms_scale
    Set Rabbitmq Exchage Routing Key            upload.WMS_SCALE   upload.putawayComplete
    Bind Rabbitmq Exchage Routing Key To Queue
    ${publishMsg}=   Prepare SCALE PUT AWAY for one item   ${template_file}  ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}  ${location_zone}
    Send Rabbitmq Msg    ${publishMsg}
    ${msgs}=  Get Rabbitmq Msg  ${1}
    Log     ${msgs}
    Sleep   10s
    Close Rabbit MQ

SCALE upload Picking pending to IMS
    [Arguments]    ${template_file}   ${fulfillment_order_key}
    Init Rabbit MQ   ScaleBridge-qa
    Set Rabbitmq Queue                          test_automation_pick_pending.upload.wms_scale
    Set Rabbitmq Exchage Routing Key            upload.WMS_SCALE   upload.fulfillmentAllocated
    Bind Rabbitmq Exchage Routing Key To Queue
    ${publishMsg}=   Prepare SCALE Pick Pending for one item    ${template_file}   ${fulfillment_order_key}
    Send Rabbitmq Msg    ${publishMsg}
    ${msgs}=  Get Rabbitmq Msg  ${1}
    Log     ${msgs}
    Sleep   10s
    Close Rabbit MQ

Prepare SCALE GRN for one item
    [Arguments]   ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}
    ${exp_date}=   Add Time To Date    ${g_current_date}    30 days
    ${publish_body}=   Get File   ${template_file}
    ${publish_body}=   Replace String   ${publish_body}  VAR_DATE_TIME_STAMP      ${g_current_date}
    ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_ID           ${partner_purchase_order_id}
    ${publish_body}=   Replace String   ${publish_body}  VAR_COMPANY              ${g_partner_slug}
    ${publish_body}=   Replace String   ${publish_body}  VAR_WAREHOUSE            TH-ACOM-RM3
    ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_DATE         ${g_current_date}
    ${publish_body}=   Replace String   ${publish_body}  VAR_ERP_ORDER_LINE_NUM   1.00000
    ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_LINE_NUM  1.00000
    ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_ID    ${partner_purchase_order_key}
    ${publish_body}=   Replace String   ${publish_body}  VAR_ITEM                 ${partner_item_key}
    ${publish_body}=   Replace String   ${publish_body}  VAR_OPEN_QTY             ${qty}
    ${publish_body}=   Replace String   ${publish_body}  VAR_EXP_DATE             ${exp_date}
    ${publish_body}=   Replace String   ${publish_body}  VAR_LOT                  ${partner_purchase_order_id}
    ${publish_body}=   Replace String   ${publish_body}  VAR_QTY                  ${qty}
    Log   ${publish_body}
    [Return]   ${publish_body}

Prepare SCALE PUT AWAY for one item
    [Arguments]   ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}  ${location_zone}
    ${exp_date}=   Add Time To Date    ${g_current_date}    30 days
    ${publish_body}=   Get File   ${template_file}
    ${publish_body}=   Replace String   ${publish_body}  VAR_DATE_TIME_STAMP      ${g_current_date}
    ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_ID           ${partner_purchase_order_id}
    ${publish_body}=   Replace String   ${publish_body}  VAR_COMPANY              ${g_partner_slug}
    ${publish_body}=   Replace String   ${publish_body}  VAR_WAREHOUSE            TH-ACOM-RM3
    ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_DATE         ${g_current_date}
    ${publish_body}=   Replace String   ${publish_body}  VAR_ERP_ORDER_LINE_NUM   1.00000
    ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_LINE_NUM  1.00000
    ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_ID    ${partner_purchase_order_key}
    ${publish_body}=   Replace String   ${publish_body}  VAR_ITEM                 ${partner_item_key}
    ${publish_body}=   Replace String   ${publish_body}  VAR_OPEN_QTY             ${qty}
    ${publish_body}=   Replace String   ${publish_body}  VAR_EXP_DATE             ${exp_date}
    ${publish_body}=   Replace String   ${publish_body}  VAR_LOT                  ${partner_purchase_order_id}
    ${publish_body}=   Replace String   ${publish_body}  VAR_QTY                  ${qty}
    ${publish_body}=   Replace String   ${publish_body}  VAR_TO_LOCATION_WORK_ZONE    ${location_zone}
    Log   ${publish_body}
    [Return]   ${publish_body}

Prepare SCALE Pick Pending for one item
    [Arguments]   ${template_file}   ${fulfillment_order_id}
    ${publish_body}=   Get File   ${template_file}
    ${publish_body}=   Replace String   ${publish_body}  VAR_WAREHOUSE            TH-ACOM-BNG
    ${publish_body}=   Replace String   ${publish_body}  VAR_SHIPMENT_ID          ${fulfillment_order_id}
    ${publish_body}=   Replace String   ${publish_body}  VAR_DATETIME             ${g_current_date}
    Log   ${publish_body}
    [Return]   ${publish_body}
