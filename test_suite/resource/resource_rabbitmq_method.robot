*** Settings ***
Library           ../../libs/rabbit/bh_rabbitmq.py
Library           XML

*** Variables ***

*** Keywords ***
Init Rabbit MQ
    [Arguments]    ${vhost}
    Init Rabbitmq Connection    ${AMQP_HOST}   ${AMQP_PORT}   ${AMQP_USERNAME}  ${AMQP_PASSWORD}   ${vhost}

Close Rabbit MQ
    Close Rabbitmq Connection

Queue Purge MQ
    [Arguments]    ${queue_name}
    Queue Purge    ${queue_name} 

Clear Scale Bridge Queue
    Init Rabbit MQ   ${VHOST_SCALEBRIDGE}
    Queue Purge      ${QUEUE_SCALEBRIDGE_DOWNLOAD}

Initial Queue
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    Queue Purge     ${QUEUE_ORDER_ITEM_SALES_ORDER}
    Queue Purge     ${QUEUE_ORDER_FULFILLMENT_ORDER} 
    Queue Purge     ${QUEUE_STATUSV2_ORDER_ITEMSALESORDER}
    Queue Purge     ${QUEUE_STATUSV2_ORDER_FULFILLMENT_ORDER}
    Queue Purge     ${QUEUE_STATUSV3_ORDER_ITEMSALESORDER}
    Queue Purge     ${QUEUE_STATUSV3_ORDER_FULFILLMENT_ORDER}
    Sleep   5s
    # Close Rabbit MQ

Verify the Messages for Sales Order Create on Order Exchange
    [Arguments]   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}
    ...   ${partnerItemId_Service}=${EMPTY}
    ...   ${partnerItemId_Discount}=${EMPTY}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${0}  ${QUEUE_ORDER_ITEM_SALES_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0

    ${get_Key}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${soKey}"  ${get_Key}

    ${get_orderAction}=   Get JSON Value    ${queue_msgs}   /orderAction
    Should Be Equal   "CREATE"  ${get_orderAction}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_externalSalesOrderId}=   Get JSON Value    ${queue_msgs}   /externalSalesOrderId
    Should Be Equal   "${externalSalesOrderId}"  ${get_externalSalesOrderId}

    ${get_salesChannelId}=   Get JSON Value    ${queue_msgs}   /salesChannelId
    Should Be Equal   "${salesChannelId}"  ${get_salesChannelId}

    ${get_paymentType}=   Get JSON Value    ${queue_msgs}   /paymentType
    Should Be Equal   "${paymentType}"  ${get_paymentType}

    ${get_shippingType}=   Get JSON Value    ${queue_msgs}   /shippingType
    Should Be Equal   "${shippingType}"  ${get_shippingType}

    ${get_partnerItemId_General}=   Get JSON Value    ${queue_msgs}   /products/0/productId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General}

    ${get_partnerItemId_CoolRoom}=   Get JSON Value    ${queue_msgs}   /products/1/productId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom}

    ${get_partnerItemId_HighValue}=   Get JSON Value    ${queue_msgs}   /products/2/productId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue}

    ${get_partnerItemId_Service}=   Run Keyword Unless  '${partnerItemId_Service}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/3/productId
    Run Keyword Unless   '${partnerItemId_Service}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Service}"  ${get_partnerItemId_Service}

    ${get_partnerItemId_Discount}=  Run Keyword Unless  '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/4/productId
    Run Keyword Unless   '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Discount}"  ${get_partnerItemId_Discount}

Verify the Messages for Fulfillment Order Create on Order Exchange
    [Arguments]   ${foKey}
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${shippingOrderId}
    ...   ${warehouseCode}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}
    ...   ${partnerItemId_Service}=${EMPTY}
    ...   ${partnerItemId_Discount}=${EMPTY}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${1}  ${QUEUE_ORDER_FULFILLMENT_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0

    ${get_foKey}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${foKey}"  ${get_foKey}

    ${get_orderAction}=   Get JSON Value    ${queue_msgs}   /orderAction
    Should Be Equal   "CREATE"  ${get_orderAction}

    ${get_salesOrderKey}=   Get JSON Value    ${queue_msgs}   /salesOrderKey
    Should Be Equal   "${soKey}"  ${get_salesOrderKey}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_externalSalesOrderId}=   Get JSON Value    ${queue_msgs}   /externalSalesOrderId
    Should Be Equal   "${externalSalesOrderId}"  ${get_externalSalesOrderId}

    ${get_shippingOrderId}=   Get JSON Value    ${queue_msgs}   /shippingOrderId
    Should Be Equal   "${shippingOrderId}"  ${get_shippingOrderId}

    ${get_partnerItemId_General}=   Get JSON Value    ${queue_msgs}   /products/0/productId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General}

    ${get_partnerItemId_CoolRoom}=   Get JSON Value    ${queue_msgs}   /products/1/productId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom}

    ${get_partnerItemId_HighValue}=   Get JSON Value    ${queue_msgs}   /products/2/productId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue}

    ${get_partnerItemId_Service}=   Run Keyword Unless  '${partnerItemId_Service}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/3/productId
    Run Keyword Unless   '${partnerItemId_Service}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Service}"  ${get_partnerItemId_Service}

    ${get_partnerItemId_Discount}=  Run Keyword Unless  '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/4/productId
    Run Keyword Unless   '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Discount}"  ${get_partnerItemId_Discount}

Verify the Messages for Sales Order status v2 on Status Exchange     
    [Arguments]   ${key}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}
    ...   ${eventId}=${None}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Status Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${0}  ${QUEUE_STATUSV2_ORDER_FULFILLMENT_ORDER}
    Log     ${getMessage}
    ########### Verify Results for detailedStatus = NEW ##################################
    ${count_queue}=  Evaluate  len(${getMessage})
    : FOR    ${INDEX}   IN RANGE   0   ${count_queue}
    \   ${queue_msgs}=   Get From List     ${getMessage}    ${INDEX}
    \   ${get_orderId}=   Get JSON Value    ${queue_msgs}   /orderId
    \   Should Be Equal   "${key}"  ${get_orderId}
    \   ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    \   Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}
    \   ${get_idType}=   Get JSON Value    ${queue_msgs}   /idType
    \   Should Be Equal   "${idType}"  ${get_idType}
    \   ${get_msgType}=   Get JSON Value    ${queue_msgs}   /msgType
    \   Should Be Equal   "${msgType}"  ${get_msgType}
    \   ${get_orderStatus}=   Get JSON Value    ${queue_msgs}   /orderStatus
    \   Should Be Equal   "@{orderStatus}[${INDEX}]"  ${get_orderStatus}
    \   ${get_detailedStatus}=   Get JSON Value    ${queue_msgs}   /detailedStatus
    \   Should Be Equal   "@{detailedStatus}[${INDEX}]"  ${get_detailedStatus}
    \   ${get_visibility}=   Get JSON Value    ${queue_msgs}   /visibility
    \   Should Be Equal   @{visibility}[${INDEX}]  ${get_visibility}
    # \   ${get_eventId}=   Get JSON Value    ${queue_msgs}   /eventId
    # \   Should Be Equal   @{eventId}[${INDEX}]  ${get_eventId}

Verify the Messages for Sales Order status v3 on bh-order-status Exchange     
    [Arguments]   ${key}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}
    ...   ${eventId}=${None}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from bh-order-status Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${0}  ${QUEUE_STATUSV3_ORDER_ITEMSALESORDER}
    Log     ${getMessage}
    ########### Verify Results for detailedStatus = NEW ##################################
    ${count_queue}=  Evaluate  len(${getMessage})
    : FOR    ${INDEX}   IN RANGE   0   ${count_queue}
    \   ${queue_msgs}=   Get From List     ${getMessage}    ${INDEX}
    \   ${get_orderId}=   Get JSON Value    ${queue_msgs}   /orderId
    \   Should Be Equal   "${key}"  ${get_orderId}
    \   ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    \   Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}
    \   ${get_idType}=   Get JSON Value    ${queue_msgs}   /idType
    \   Should Be Equal   "${idType}"  ${get_idType}
    \   ${get_msgType}=   Get JSON Value    ${queue_msgs}   /msgType
    \   Should Be Equal   "${msgType}"  ${get_msgType}
    \   ${get_orderStatus}=   Get JSON Value    ${queue_msgs}   /orderStatus
    \   Should Be Equal   "@{orderStatus}[${INDEX}]"  ${get_orderStatus}
    \   ${get_detailedStatus}=   Get JSON Value    ${queue_msgs}   /detailedStatus
    \   Should Be Equal   "@{detailedStatus}[${INDEX}]"  ${get_detailedStatus}
    \   ${get_visibility}=   Get JSON Value    ${queue_msgs}   /visibility
    \   Should Be Equal   @{visibility}[${INDEX}]  ${get_visibility}
    # \   ${get_eventId}=   Get JSON Value    ${queue_msgs}   /eventId
    # \   Should Be Equal   @{eventId}[${INDEX}]  ${get_eventId}

Verify the Messages for Fulfillment Order status v3 on bh-order-status Exchange     
    [Arguments]   ${key}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}
    ...   ${eventId}=${None}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from bh-order-status Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${0}  ${QUEUE_STATUSV3_ORDER_FULFILLMENT_ORDER}
    Log     ${getMessage}
    ######################################################################################
    ${count_queue}=  Evaluate  len(${getMessage})
    : FOR    ${INDEX}   IN RANGE   0   ${count_queue}
    \   ${queue_msgs}=   Get From List     ${getMessage}    ${INDEX}
    \   ${get_orderId}=   Get JSON Value    ${queue_msgs}   /orderId
    \   Should Be Equal   "${key}"  ${get_orderId}
    \   ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    \   Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}
    \   ${get_idType}=   Get JSON Value    ${queue_msgs}   /idType
    \   Should Be Equal   "${idType}"  ${get_idType}
    \   ${get_msgType}=   Get JSON Value    ${queue_msgs}   /msgType
    \   Should Be Equal   "${msgType}"  ${get_msgType}
    \   ${get_orderStatus}=   Get JSON Value    ${queue_msgs}   /orderStatus
    \   Should Be Equal   "@{orderStatus}[${INDEX}]"  ${get_orderStatus}
    \   ${get_detailedStatus}=   Get JSON Value    ${queue_msgs}   /detailedStatus
    \   Should Be Equal   "@{detailedStatus}[${INDEX}]"  ${get_detailedStatus}
    \   ${get_visibility}=   Get JSON Value    ${queue_msgs}   /visibility
    \   Should Be Equal   @{visibility}[${INDEX}]  ${get_visibility}

Verify the Messages for Sales Order Create on Order Exchange - Bundle
    [Arguments]   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${bundle_product_title}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}
    ...   ${partnerItemId_Service}=${EMPTY}
    ...   ${partnerItemId_Discount}=${EMPTY}

    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${1}  ${QUEUE_ORDER_ITEM_SALES_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0
    ${get_Key}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${soKey}"  ${get_Key}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_externalSalesOrderId}=   Get JSON Value    ${queue_msgs}   /externalSalesOrderId
    Should Be Equal   "${externalSalesOrderId}"  ${get_externalSalesOrderId}

    ${get_salesChannelId}=   Get JSON Value    ${queue_msgs}   /salesChannelId
    Should Be Equal   "${salesChannelId}"  ${get_salesChannelId}

    ${get_paymentType}=   Get JSON Value    ${queue_msgs}   /paymentType
    Should Be Equal   "${paymentType}"  ${get_paymentType}

    ${get_shippingType}=   Get JSON Value    ${queue_msgs}   /shippingType
    Should Be Equal   "${shippingType}"  ${get_shippingType}

    ${get_bundle_product_title}=   Get JSON Value    ${queue_msgs}   /products/0/productId
    Should Be Equal   "${bundle_product_title}"  ${get_bundle_product_title}

    ${get_partnerItemId_General}=   Get JSON Value    ${queue_msgs}   /products/0/items/0/partnerItemId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General}

    ${get_partnerItemId_CoolRoom}=   Get JSON Value    ${queue_msgs}   /products/0/items/1/partnerItemId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom}

    ${get_partnerItemId_HighValue}=   Get JSON Value    ${queue_msgs}   /products/0/items/2/partnerItemId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue}

    ${get_partnerItemId_Service}=   Run Keyword Unless  '${partnerItemId_Service}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/1/productId
    Run Keyword Unless   '${partnerItemId_Service}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Service}"  ${get_partnerItemId_Service}

    ${get_partnerItemId_Discount}=  Run Keyword Unless  '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/2/productId
    Run Keyword Unless   '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Discount}"  ${get_partnerItemId_Discount}

Verify the Messages for Fulfillment Order Create on Order Exchange - Bundle
    [Arguments]   ${foKey}
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${shippingOrderId}
    ...   ${warehouseCode}
    ...   ${bundle_product_title}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}
    ...   ${partnerItemId_Service}=${EMPTY}
    ...   ${partnerItemId_Discount}=${EMPTY}
    
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${1}  ${QUEUE_ORDER_FULFILLMENT_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0
    ${get_foKey}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${foKey}"  ${get_foKey}

    ${get_salesOrderKey}=   Get JSON Value    ${queue_msgs}   /salesOrderKey
    Should Be Equal   "${soKey}"  ${get_salesOrderKey}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_externalSalesOrderId}=   Get JSON Value    ${queue_msgs}   /externalSalesOrderId
    Should Be Equal   "${externalSalesOrderId}"  ${get_externalSalesOrderId}

    ${get_shippingOrderId}=   Get JSON Value    ${queue_msgs}   /shippingOrderId
    Should Be Equal   "${shippingOrderId}"  ${get_shippingOrderId}

    ${get_bundle_product_title}=   Get JSON Value    ${queue_msgs}   /products/0/productId
    Should Be Equal   "${bundle_product_title}"  ${get_bundle_product_title}

    ${get_partnerItemId_General}=   Get JSON Value    ${queue_msgs}   /products/0/items/0/partnerItemId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General}

    ${get_partnerItemId_CoolRoom}=   Get JSON Value    ${queue_msgs}   /products/0/items/1/partnerItemId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom}

    ${get_partnerItemId_HighValue}=   Get JSON Value    ${queue_msgs}   /products/0/items/2/partnerItemId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue}

    ${get_partnerItemId_Service}=   Run Keyword Unless  '${partnerItemId_Service}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/1/productId
    Run Keyword Unless   '${partnerItemId_Service}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Service}"  ${get_partnerItemId_Service}

    ${get_partnerItemId_Discount}=  Run Keyword Unless  '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Get JSON Value    ${queue_msgs}   /products/2/productId
    Run Keyword Unless   '${partnerItemId_Discount}'=='${EMPTY}'
    ...      Should Be Equal   "${partnerItemId_Discount}"  ${get_partnerItemId_Discount}

Verify the Messages for Sales Order Create on Order Exchange - All
    [Arguments]   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${bundle_product_title}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}
    ...   ${partnerItemId_Service}
    ...   ${partnerItemId_Discount}

    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${1}  ${QUEUE_ORDER_ITEM_SALES_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0
    ${get_Key}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${soKey}"  ${get_Key}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_externalSalesOrderId}=   Get JSON Value    ${queue_msgs}   /externalSalesOrderId
    Should Be Equal   "${externalSalesOrderId}"  ${get_externalSalesOrderId}

    ${get_salesChannelId}=   Get JSON Value    ${queue_msgs}   /salesChannelId
    Should Be Equal   "${salesChannelId}"  ${get_salesChannelId}

    ${get_paymentType}=   Get JSON Value    ${queue_msgs}   /paymentType
    Should Be Equal   "${paymentType}"  ${get_paymentType}

    ${get_shippingType}=   Get JSON Value    ${queue_msgs}   /shippingType
    Should Be Equal   "${shippingType}"  ${get_shippingType}

    ${get_bundle_product_title}=   Get JSON Value    ${queue_msgs}   /products/0/productId
    Should Be Equal   "${bundle_product_title}"  ${get_bundle_product_title}

    ${get_partnerItemId_General1}=   Get JSON Value    ${queue_msgs}   /products/0/items/0/partnerItemId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General1}

    ${get_partnerItemId_CoolRoom1}=   Get JSON Value    ${queue_msgs}   /products/0/items/1/partnerItemId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom1}

    ${get_partnerItemId_HighValue1}=   Get JSON Value    ${queue_msgs}   /products/0/items/2/partnerItemId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue1}

    ${get_partnerItemId_General2}=   Get JSON Value    ${queue_msgs}   /products/1/productId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General2}

    ${get_partnerItemId_CoolRoom2}=   Get JSON Value    ${queue_msgs}   /products/2/productId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom2}

    ${get_partnerItemId_HighValue2}=   Get JSON Value    ${queue_msgs}   /products/3/productId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue2}

    ${get_partnerItemId_Service}=   Get JSON Value    ${queue_msgs}   /products/4/productId
    Should Be Equal   "${partnerItemId_Service}"  ${get_partnerItemId_Service}

    ${get_partnerItemId_Discount}=   Get JSON Value    ${queue_msgs}   /products/5/productId
    Should Be Equal   "${partnerItemId_Discount}"  ${get_partnerItemId_Discount}

Verify the Messages for Fulfillment Order Create on Order Exchange - All
    [Arguments]   ${foKey}
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${shippingOrderId}
    ...   ${warehouseCode}
    ...   ${bundle_product_title}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}
    ...   ${partnerItemId_Service}
    ...   ${partnerItemId_Discount}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${1}  ${QUEUE_ORDER_FULFILLMENT_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0
    ${get_foKey}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${foKey}"  ${get_foKey}

    ${get_salesOrderKey}=   Get JSON Value    ${queue_msgs}   /salesOrderKey
    Should Be Equal   "${soKey}"  ${get_salesOrderKey}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_externalSalesOrderId}=   Get JSON Value    ${queue_msgs}   /externalSalesOrderId
    Should Be Equal   "${externalSalesOrderId}"  ${get_externalSalesOrderId}

    ${get_shippingOrderId}=   Get JSON Value    ${queue_msgs}   /shippingOrderId
    Should Be Equal   "${shippingOrderId}"  ${get_shippingOrderId}

    ${get_bundle_product_title}=   Get JSON Value    ${queue_msgs}   /products/0/productId
    Should Be Equal   "${bundle_product_title}"  ${get_bundle_product_title}

    ${get_partnerItemId_General1}=   Get JSON Value    ${queue_msgs}   /products/0/items/0/partnerItemId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General1}

    ${get_partnerItemId_CoolRoom1}=   Get JSON Value    ${queue_msgs}   /products/0/items/1/partnerItemId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom1}

    ${get_partnerItemId_HighValue1}=   Get JSON Value    ${queue_msgs}   /products/0/items/2/partnerItemId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue1}

    ${get_partnerItemId_General2}=   Get JSON Value    ${queue_msgs}   /products/1/productId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General2}

    ${get_partnerItemId_CoolRoom2}=   Get JSON Value    ${queue_msgs}   /products/2/productId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom2}

    ${get_partnerItemId_HighValue2}=   Get JSON Value    ${queue_msgs}   /products/3/productId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue2}

    ${get_partnerItemId_Service}=   Get JSON Value    ${queue_msgs}   /products/4/productId
    Should Be Equal   "${partnerItemId_Service}"  ${get_partnerItemId_Service}

    ${get_partnerItemId_Discount}=   Get JSON Value    ${queue_msgs}   /products/5/productId
    Should Be Equal   "${partnerItemId_Discount}"  ${get_partnerItemId_Discount}



Verify the Messages for Sales Order Updated on Order Exchange
    [Arguments]   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${1}  ${QUEUE_ORDER_ITEM_SALES_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0
    ${get_Key}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${soKey}"  ${get_Key}

    ${get_orderAction}=   Get JSON Value    ${queue_msgs}   /orderAction
    Should Be Equal   "UPDATE"  ${get_orderAction}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_externalSalesOrderId}=   Get JSON Value    ${queue_msgs}   /externalSalesOrderId
    Should Be Equal   "${externalSalesOrderId}"  ${get_externalSalesOrderId}

    ${get_salesChannelId}=   Get JSON Value    ${queue_msgs}   /salesChannelId
    Should Be Equal   "${salesChannelId}"  ${get_salesChannelId}

    ${get_paymentType}=   Get JSON Value    ${queue_msgs}   /paymentType
    Should Be Equal   "${paymentType}"  ${get_paymentType}

    ${get_shippingType}=   Get JSON Value    ${queue_msgs}   /shippingType
    Should Be Equal   "${shippingType}"  ${get_shippingType}

    ${get_partnerItemId_General}=   Get JSON Value    ${queue_msgs}   /products/0/productId
    Should Be Equal   "${partnerItemId_General}"  ${get_partnerItemId_General}

    ${get_partnerItemId_CoolRoom}=   Get JSON Value    ${queue_msgs}   /products/1/productId
    Should Be Equal   "${partnerItemId_CoolRoom}"  ${get_partnerItemId_CoolRoom}

    ${get_partnerItemId_HighValue}=   Get JSON Value    ${queue_msgs}   /products/2/productId
    Should Be Equal   "${partnerItemId_HighValue}"  ${get_partnerItemId_HighValue}

Verify the Messages for sale order on Scale Download Exchange
    [Arguments]
    ...   ${shippingType}
    ...   ${partnerId}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${foKey}
    ...   ${externalSalesOrderId}
    ...   ${getItemKey_General}
    ...   ${getItemKey_CoolRoom}
    ...   ${getItemKey_HighValue}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Download Exchange
    Init Rabbit MQ   ${VHOST_SCALEBRIDGE}
    Sleep    10s
    ${getMessage}    Get Rabbitmq Msg  ${0}  ${QUEUE_SCALEBRIDGE_DOWNLOAD}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0
    ${xml_msgs}=  Parse XML   ${queue_msgs}

    ${get_action}=   Get Element  ${xml_msgs}  body/Shipments/Shipment/Action
    Should Be Equal         NEW                      ${get_action.text}

    ${get_shippingType}=   Get Element  ${xml_msgs}  body/Shipments/Shipment/Carrier/Carrier
    Should Be Equal         ${shippingType}          ${get_shippingType.text}

    ${get_partnerId}=   Get Element  ${xml_msgs}  body/Shipments/Shipment/Customer/Customer
    Should Contain       ${get_partnerId.text}       ${partnerId}

    ${get_addressee}=  Get Element   ${xml_msgs}  body/Shipments/Shipment/Customer/ShipTo
    ${addressee_length}=    Get Length    ${addressee}
    ${expected_addressee}=      Run Keyword If   '${addressee_length}'>'25'    Trim shipping address to 25 character   ${addressee}
    ...   ELSE IF         '${addressee_length}'=='25'  Set Variable    ${addressee}
    ...   ELSE IF         '${addressee_length}'<'25'   Set variable    ${addressee}
    Should Be Equal       ${expected_addressee}     ${get_addressee.text}

    ${get_address1}=  Get Element   ${xml_msgs}  body/Shipments/Shipment/Customer/ShipToAddress/Address1
    ${address1_length}=    Get Length    ${address1}
    ${expected_address1}=      Run Keyword If   '${address1_length}'>'50'    Trim shipping address to 50 character   ${address1}
    ...   ELSE IF         '${addressee_length}'=='50'  Set Variable    ${address1}
    ...   ELSE IF         '${addressee_length}'<'50'   Set variable    ${address1}
    Should Be Equal       ${expected_address1}     ${get_address1.text}
    
    ${get_city}=  Get Element   ${xml_msgs}  body/Shipments/Shipment/Customer/ShipToAddress/City
    ${city_length}=    Get Length    ${city}
    ${expected_city}=      Run Keyword If   '${city_length}'>'25'    Trim shipping address to 25 character   ${city}
    ...   ELSE IF         '${city_length}'=='25'  Set Variable    ${city}
    ...   ELSE IF         '${city_length}'<'25'   Set variable    ${city}
    Should Be Equal       ${expected_city}     ${get_city.text}

    ${get_postalCode}=  Get Element   ${xml_msgs}  body/Shipments/Shipment/Customer/ShipToAddress/PostalCode
    ${postalCode_length}=    Get Length    ${postalCode}
    ${expected_postalCode}=      Run Keyword If   '${postalCode_length}'>'25'    Trim shipping address to 25 character   ${postalCode}
    ...   ELSE IF         '${postalCode_length}'=='25'  Set Variable    ${postalCode}
    ...   ELSE IF         '${postalCode_length}'<'25'   Set variable    ${postalCode}
    Should Be Equal       ${expected_postalCode}     ${get_postalCode.text}

    ${get_orderType}=   Get Element  ${xml_msgs}  body/Shipments/Shipment/OrderType
    Should Be Equal         Fulfillment          ${get_orderType.text}

    ${get_country}=   Get Element  ${xml_msgs}   body/Shipments/Shipment/Customer/ShipToAddress/Country
    Should Be Equal         N/A          ${get_country.text}

    ${get_foKey}=   Get Element  ${xml_msgs}  body/Shipments/Shipment/ShipmentId
    Should Be Equal   ${foKey}          ${get_foKey.text}

    ${get_externalSalesOrderId}=   Get Element  ${xml_msgs}  body/Shipments/Shipment/UserDef11
    Should Be Equal   ${externalSalesOrderId}          ${get_externalSalesOrderId.text}

    ${itemKey_General}=    Set Variable   ${getItemKey_General}
    ${results}=   Set Variable    NOT FOUND
    @{ShipmentDetail}    Get Elements    ${xml_msgs}    body/Shipments/Shipment/Details/ShipmentDetail
    :FOR    ${adjacency}    IN    @{ShipmentDetail}
    \       ${getErpOrder}=    Get Element Text    ${adjacency}    ErpOrder
    \       ${results}=   Set Variable If   '${getErpOrder}'=='${itemKey_General}'   ${getErpOrder}   ${results}
    \       Exit For Loop If    '${getErpOrder}'=='${itemKey_General}'

    ${itemKey_CoolRoom}=    Set Variable   ${getItemKey_CoolRoom}
    ${results}=   Set Variable    NOT FOUND
    @{ShipmentDetail}    Get Elements    ${xml_msgs}    body/Shipments/Shipment/Details/ShipmentDetail
    :FOR    ${adjacency}    IN    @{ShipmentDetail}
    \       ${getErpOrder}=    Get Element Text    ${adjacency}    ErpOrder
    \       ${results}=   Set Variable If   '${getErpOrder}'=='${itemKey_CoolRoom}'   ${getErpOrder}   ${results}
    \       Exit For Loop If    '${getErpOrder}'=='${itemKey_CoolRoom}'

    ${itemKey_HighValue}=    Set Variable   ${getItemKey_HighValue}
    ${results}=   Set Variable    NOT FOUND
    @{ShipmentDetail}    Get Elements    ${xml_msgs}    body/Shipments/Shipment/Details/ShipmentDetail
    :FOR    ${adjacency}    IN    @{ShipmentDetail}
    \       ${getErpOrder}=    Get Element Text    ${adjacency}    ErpOrder
    \       ${results}=   Set Variable If   '${getErpOrder}'=='${itemKey_HighValue}'   ${getErpOrder}   ${results}
    \       Exit For Loop If    '${getErpOrder}'=='${itemKey_HighValue}'

Trim shipping address to 25 character 
    [Arguments]      ${input_shipping}
    ${sub_input_shipping}=    Get Substring    ${input_shipping}     0     22
    ${cat_input_shipping}=    Catenate   ${sub_input_shipping}...
    [Return]   ${cat_input_shipping}

Trim shipping address to 50 character 
    [Arguments]      ${input_shipping}
    ${sub_input_shipping}=    Get Substring    ${input_shipping}     0     47
    ${cat_input_shipping}=    Catenate   ${sub_input_shipping}...
    [Return]   ${cat_input_shipping}

Verify the Messages for Shipping address on Order Exchange
    [Arguments]   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    Sleep   5s
    ${getMessage}    Get Rabbitmq Msg  ${0}  ${QUEUE_ORDER_ITEM_SALES_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0

    ${get_Key}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${soKey}"  ${get_Key}

    ${get_addressee}=   Get JSON Value    ${queue_msgs}   /orderShipmentInfo/addressee
    Should Be Equal   "${addressee}"  ${get_addressee}

    ${get_address1}=   Get JSON Value    ${queue_msgs}   /orderShipmentInfo/address1
    Should Be Equal   "${address1}"  ${get_address1}

    ${get_city}=   Get JSON Value    ${queue_msgs}   /orderShipmentInfo/city
    Should Be Equal   "${city}"  ${get_city}

    ${get_postalCode}=   Get JSON Value    ${queue_msgs}   /orderShipmentInfo/postalCode
    Should Be Equal   "${postalCode}"  ${get_postalCode}

    ${get_country}=   Get JSON Value    ${queue_msgs}   /orderShipmentInfo/country
    Should Be Equal   "${country}"  ${get_country}

Verify the Messages for Sales Order Cancel on Order Exchange
    [Arguments]   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${reason}
    ...   ${reasonCode}
    ${getMessage}   Set Variable  ""
    ######################################################################################
    Comment   Get Sales Order Message from Order Exchange
    Init Rabbit MQ   ${VHOST_SALES_ORDER}
    ${getMessage}    Get Rabbitmq Msg  ${0}  ${QUEUE_ORDER_ITEM_SALES_ORDER}
    Log     ${getMessage}
    ######################################################################################
    Comment   Verify Results
    ${queue_msgs}=   Get From List     ${getMessage}   0

    ${get_Key}=   Get JSON Value    ${queue_msgs}   /key
    Should Be Equal   "${soKey}"  ${get_Key}

    ${get_orderAction}=   Get JSON Value    ${queue_msgs}   /orderAction
    Should Be Equal   "CANCEL"  ${get_orderAction}

    ${get_headerPublisherId}=   Get JSON Value    ${queue_msgs}   /headerPublisherId
    Should Be Equal   "${headerPublisherId}"  ${get_headerPublisherId}

    ${get_partnerId}=   Get JSON Value    ${queue_msgs}   /partnerId
    Should Be Equal   "${partnerId}"  ${get_partnerId}

    ${get_reason}=   Get JSON Value    ${queue_msgs}   /reason
    Should Be Equal   "${reason}"  ${get_reason}

    ${get_reasonCode}=   Get JSON Value    ${queue_msgs}   /reasonCode
    Should Be Equal   "${reasonCode}"  ${get_reasonCode}

# #OLD wait for review
# Consume Sales Order - Update queue
#     [Arguments]   ${partner_id}
#     Init Rabbit MQ    common-qa
#     Set Rabbitmq Queue                  test_automation_update.${partner_id}
#     Set Rabbitmq Exchage Routing Key    order   order.item_sales_order.update.th.${partner_id}
#     Bind Rabbitmq Exchage Routing Key To Queue

# Consume Sales Order - Create queue
#     [Arguments]   ${partner_id}
#     Init Rabbit MQ    common-qa
#     Set Rabbitmq Queue                  test_automation_create.${partner_id}
#     Set Rabbitmq Exchage Routing Key    order   order.item_sales_order.create.th.${partner_id}
#     Bind Rabbitmq Exchage Routing Key To Queue

# Consume Sales Order - Item mapper queue
#     [Arguments]   ${partner_id}
#     Init Rabbit MQ    common-qa
#     Set Rabbitmq Queue                  test_automation_mapper.${partner_id}
#     Set Rabbitmq Exchage Routing Key    status   mapper
#     Bind Rabbitmq Exchage Routing Key To Queue

# Consume Sales Order - Order status queue
#     [Arguments]   ${partner_id}
#     Init Rabbit MQ    common-qa
#     Set Rabbitmq Queue                  test_automation_order_status.${partner_id}
#     Set Rabbitmq Exchage Routing Key    status   status.order.fulfillment.${partner_id}.th.new
#     Bind Rabbitmq Exchage Routing Key To Queue

# Confirm Sales Order updated has been published to order exchange correctly
#     [Arguments]     ${sales_order_key}  ${queue_name}
#     ${msgs}=         Get Rabbitmq Msg  ${queue_name}
#     ${queue_msgs}=   Get From List     ${msgs}         0
#     ${key_result}=   Get JSON Value    ${queue_msgs}   /key
#     ${orderAction_result}=      Get JSON Value    ${queue_msgs}   /orderAction
#     ${key_result}=   Remove String     ${key_result}   "
#     ${orderAction_result}=      Remove String     ${orderAction_result}      "
#     Should Be Equal    ${key_result}   ${salesOrderKey}
#     Should Be Equal    ${orderAction_result}   UPDATE
#     Close Rabbit MQ

# Confirm Sales Order created has been published to order exchange correctly
#     [Arguments]     ${sales_order_key}  ${queue_name}
#     ${msgs}=         Get Rabbitmq Msg  ${queue_name}
#     ${queue_msgs}=   Get From List     ${msgs}         0
#     ${key_result}=   Get JSON Value    ${queue_msgs}   /key
#     ${orderAction_result}=      Get JSON Value    ${queue_msgs}   /orderAction
#     ${key_result}=   Remove String     ${key_result}   "
#     ${orderAction_result}=      Remove String     ${orderAction_result}      "
#     Should Be Equal    ${key_result}   ${salesOrderKey}
#     Should Be Equal    ${orderAction_result}   CREATE
#     Close Rabbit MQ

# Consume Message from RabbitMQ
#     [Arguments]    ${vhost}  ${queue_name}  ${count}  ${is_ack}
#     ##### Variables #####
#     ${request_body}=  Set Variable  { "count": ${count}, "requeue": ${is_ack}, "encoding": "auto", "truncate": 50000 }
#     ${path}=   Set Variable   /api/queues/${vhost}/${queue_name}/get
#     ##### HTTP Request
#     Create Http Context     ${R_HOST_RQ}    http
#     Set Request Header      Content-Type    ${R_CONTENT_TYPE}
#     Set Request Header      Authorization   ${R_AUTHURIZATION_RQ}
#     Set Request Body        ${request_body}
#     POST                    ${path}
#     Response Status Code Should Equal    200
#     ${resultJSONBody}=    Get Response Body
#     Log Response Body
#     [Return]   ${resultJSONBody}




#     # ${msgs}=         consume_msg_from_queue   automation_sales_order_3904
#     # ${queue_msgs}=   Get From List     ${msgs}         0
#     # ${key_result}=   Get JSON Value    ${queue_msgs}   /key
#     # ${orderAction_result}=      Get JSON Value    ${queue_msgs}   /orderAction
#     # ${key_result}=   Remove String     ${key_result}   "
#     # ${orderAction_result}=      Remove String     ${orderAction_result}      "
#     # Should Be Equal    ${key_result}   ${salesOrderKey}
#     # Should Be Equal    ${orderAction_result}   CREATE
#     # Sleep   10s
#     # Close Rabbit MQ

# SCALE upload GRN to IMS
#     [Arguments]    ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}
#     Init Rabbit MQ   ScaleBridge-qa
#     Set Rabbitmq Queue                          test_automation_grn.upload.wms_scale
#     Set Rabbitmq Exchage Routing Key            upload.WMS_SCALE   upload.goodsReceipt
#     Bind Rabbitmq Exchage Routing Key To Queue
#     ${publishMsg}=   Prepare SCALE GRN for one item    ${template_file}  ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}
#     Send Rabbitmq Msg    ${publishMsg}
#     ${msgs}=  Get Rabbitmq Msg  ${1}
#     Log     ${msgs}
#     Sleep   10s
#     Close Rabbit MQ

# SCALE upload PUT AWAY to IMS
#     [Arguments]    ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}   ${location_zone}
#     Init Rabbit MQ    ScaleBridge-qa
#     Set Rabbitmq Queue                          test_automation_put_away.upload.wms_scale
#     Set Rabbitmq Exchage Routing Key            upload.WMS_SCALE   upload.putawayComplete
#     Bind Rabbitmq Exchage Routing Key To Queue
#     ${publishMsg}=   Prepare SCALE PUT AWAY for one item   ${template_file}  ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}  ${location_zone}
#     Send Rabbitmq Msg    ${publishMsg}
#     ${msgs}=  Get Rabbitmq Msg  ${1}
#     Log     ${msgs}
#     Sleep   10s
#     Close Rabbit MQ

# SCALE upload Picking pending to IMS
#     [Arguments]    ${template_file}   ${fulfillment_order_key}
#     Init Rabbit MQ   ScaleBridge-qa
#     Set Rabbitmq Queue                          test_automation_pick_pending.upload.wms_scale
#     Set Rabbitmq Exchage Routing Key            upload.WMS_SCALE   upload.fulfillmentAllocated
#     Bind Rabbitmq Exchage Routing Key To Queue
#     ${publishMsg}=   Prepare SCALE Pick Pending for one item    ${template_file}   ${fulfillment_order_key}
#     Send Rabbitmq Msg    ${publishMsg}
#     ${msgs}=  Get Rabbitmq Msg  ${1}
#     Log     ${msgs}
#     Sleep   10s
#     Close Rabbit MQ

# Prepare SCALE GRN for one item
#     [Arguments]   ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}
#     ${exp_date}=   Add Time To Date    ${g_current_date}    30 days
#     ${publish_body}=   Get File   ${template_file}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_DATE_TIME_STAMP      ${g_current_date}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_ID           ${partner_purchase_order_id}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_COMPANY              ${g_partner_slug}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_WAREHOUSE            TH-ACOM-RM3
#     ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_DATE         ${g_current_date}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_ERP_ORDER_LINE_NUM   1.00000
#     ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_LINE_NUM  1.00000
#     ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_ID    ${partner_purchase_order_key}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_ITEM                 ${partner_item_key}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_OPEN_QTY             ${qty}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_EXP_DATE             ${exp_date}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_LOT                  ${partner_purchase_order_id}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_QTY                  ${qty}
#     Log   ${publish_body}
#     [Return]   ${publish_body}

# Prepare SCALE PUT AWAY for one item
#     [Arguments]   ${template_file}   ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${qty}  ${location_zone}
#     ${exp_date}=   Add Time To Date    ${g_current_date}    30 days
#     ${publish_body}=   Get File   ${template_file}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_DATE_TIME_STAMP      ${g_current_date}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_ID           ${partner_purchase_order_id}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_COMPANY              ${g_partner_slug}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_WAREHOUSE            TH-ACOM-RM3
#     ${publish_body}=   Replace String   ${publish_body}  VAR_RECEIPT_DATE         ${g_current_date}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_ERP_ORDER_LINE_NUM   1.00000
#     ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_LINE_NUM  1.00000
#     ${publish_body}=   Replace String   ${publish_body}  VAR_PURCHASE_ORDER_ID    ${partner_purchase_order_key}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_ITEM                 ${partner_item_key}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_OPEN_QTY             ${qty}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_EXP_DATE             ${exp_date}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_LOT                  ${partner_purchase_order_id}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_QTY                  ${qty}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_TO_LOCATION_WORK_ZONE    ${location_zone}
#     Log   ${publish_body}
#     [Return]   ${publish_body}

# Prepare SCALE Pick Pending for one item
#     [Arguments]   ${template_file}   ${fulfillment_order_id}
#     ${publish_body}=   Get File   ${template_file}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_WAREHOUSE            TH-ACOM-BNG
#     ${publish_body}=   Replace String   ${publish_body}  VAR_SHIPMENT_ID          ${fulfillment_order_id}
#     ${publish_body}=   Replace String   ${publish_body}  VAR_DATETIME             ${g_current_date}
#     Log   ${publish_body}
#     [Return]   ${publish_body}
