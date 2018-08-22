*** Settings ***
Documentation     BEEH-4963 Publish event ID for sales order 
...               and fulfillment order status
Resource          ../resource/group_vars/${env}/global_resource.robot
Resource          ../resource/resource_sale_order_method.robot
Resource          ../resource/resource_item_master_method.robot
Resource          ../resource/resource_purchase_order_method.robot
# Resource          ../resource/resource_portal.robot
Resource          ../resource/resource_mongoDB_method.robot
Resource          ../resource/resource_rabbitmq_method.robot
Test Setup        Initial Queue

*** Variables ***
${partner_id}           ${PARTNER_ID_SC_TH}
${partner_name}         ${PARTNER_NAME_SC_TH}
${partner_slug}         ${PARTNER_SLUG_SC_TH}
${partner_prefix}       ${PARTNER_PREFIX_SC_TH}
${item_master_template}       ${SO_TEST_DATA}/json/item_master_template.json
${purchase_order_template}    ${SO_TEST_DATA}/json/purchase_order_template.json
${productLineItem_template}   ${SO_TEST_DATA}/json/productLineItems_template.json
${sales_order_template}       ${SO_TEST_DATA}/json/sales_order_template.json
${bundle_productLineItems_template}   ${SO_TEST_DATA}/json/bundle_productLineItems_template.json
${lineItems_template}       ${SO_TEST_DATA}/json/LineItems_template.json

*** Test Cases ***
EVENTID_001
    [Documentation]  aaa
    [Tags]   eventId
    # comment  -------- Defined Variables --------
    # ${current_date}  Get Current Date
    # ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    # Set Global Variable    ${g_current_date}    ${current_date}
    # Set Global Variable    ${g_random_id}    ${random_id}
    
    # comment  -------- Test Data --------
    # ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    # Log to console   "Partner Id = ${partner_id}"
    # Log to console   "Sales Order Id = ${externalSalesOrderId}"

    # comment  -------- Prepare Inventory Items --------
    # ### General
    # ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   General     FIFO  false   false
    # ${partnerItemId_General}=  Set Variable   ${partnerItemId}
    # ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10
    # ### Cool Room
    # ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   Cool Room   FIFO  false   false
    # ${partnerItemId_CoolRoom}=  Set Variable   ${partnerItemId}
    # ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10
    # ### High Value
    # ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   High Value  FIFO  false   false
    # ${partnerItemId_HighValue}=  Set Variable   ${partnerItemId}
    # ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10

    # comment  -------- Prepare Line Product item --------
    # ${productLineItems_General}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_General}   1   1  1  100.0
    # ${productLineItems_CoolRoom}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_CoolRoom}   2  1  1  100.0
    # ${productLineItems_HighValue}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_HighValue}  3  1  1  100.0
    # ${productLineItemsList}=  Catenate  ${productLineItems_General}  ${COMMA}  ${productLineItems_CoolRoom}   ${COMMA}  ${productLineItems_HighValue}
    # comment  -------- Create Sales Order --------
    # ${soKey}=  Prepare Sales Order    
    # ...           ${sales_order_template}
    # ...           ${externalSalesOrderId}
    # ...           ${partner_id}
    # ...           ${STATUS_201}
    # ...           ${productLineItemsList}
    # ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    # ...           ${PAYMENT_TYPE_COD}
    # Log To Console  "soKey = ${soKey}"
    # Wait until Fulfillment Order Status is PACKED
    ${soKey}=  Set Variable  JGKOJMPU5N3GSPI2ZOTVWMZJ8

    # ${query}=   Set Variable   {"history.state.orderStatus.eventId" : LUUID("0e07c247-cbef-436e-8d21-3ad313c4ad97")}
    # ${connection_name}=  Set Variable   ${SALES_ORDER_COLLECTION}
    # ${mongoDBProjection}=  Set Variable   {"history.state.orderStatus":1}
    # ${query_results}=   get one from collection  ${connection_name}  ${query}   ${mongoDBProjection}
    # Log   ${query_results}

    comment  -------- Get Order Store eventId from DB --------
    @{salesOrder_eventId}=    Get Order Store eventId from DB    ${soKey}   sales_order
    # Log   ${salesOrder_eventId}
    # @{fulfillmentOrder_eventId}=    Get Order Store eventId from DB    ${soKey}   fulfillment_order
    # Log   ${fulfillmentOrder_eventId}

    # comment  -------- Sales Status v2 on Status Exchange --------
    # ${idType}=          Set Variable    ITEM_SALES_ORDER
    # ${msgType}=         Set Variable    ORDER_STATUS
    # @{orderStatus}=     Set Variable    NEW   NEW             NEW 
    # @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK   PACKED
    # @{visibility}=      Set Variable    15    15              7
    # @{eventId}=         Set Variable    ${salesOrder_eventId}
    # Verify the Messages for Sales Order status v2 on Status Exchange 
    # ...   ${soKey}
    # ...   ${headerPublisherId}
    # ...   ${partnerId}
    # ...   ${idType}
    # ...   ${msgType}
    # ...   ${orderStatus}
    # ...   ${detailedStatus}
    # ...   ${visibility}

    # : FOR    ${INDEX}   IN RANGE   0   2
    # \   ${get_eventId}=   Set Variable    @{salesOrder_eventId}[${INDEX}]

    # comment  -------- Sales Status v3 on Status Exchange --------
    # ${idType}=          Set Variable    ITEM_SALES_ORDER
    # ${msgType}=         Set Variable    ORDER_STATUS
    # @{orderStatus}=     Set Variable    NEW   IN_PROGRESS
    # @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS
    # ${visibility}=      Set Variable    15    15
    # @{eventId}=         Set Variable    ${salesOrder_eventId}
    # Verify the Messages for Sales Order status v3 on bh-order-status Exchange
    # ...   ${soKey}
    # ...   ${headerPublisherId}
    # ...   ${partnerId}
    # ...   ${idType}
    # ...   ${msgType}
    # ...   ${orderStatus}
    # ...   ${detailedStatus}
    # ...   ${visibility}
    # ...   ${eventId}

    # comment  -------- Sales Status v3 on Status Exchange --------
    # ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    # ${shippingOrderId}=  Set Variable   ${foKey}
    # ${idType}=          Set Variable    FULFILLMENT_ORDER
    # ${msgType}=         Set Variable    ORDER_STATUS
    # @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
    # @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
    # @{visibility}=      Set Variable    15         15                   15             15
    # @{visibility}=      Set Variable    15         15                   15             15
    # Verify the Messages for Fulfillment Order status v3 on bh-order-status Exchange 
    # ...   ${foKey}
    # ...   ${headerPublisherId}
    # ...   ${partnerId}
    # ...   ${idType}
    # ...   ${msgType}
    # ...   ${orderStatus}
    # ...   ${detailedStatus}
    # ...   ${visibility}
    # ...   ${eventId}

    # comment  -------- Verify Inventory available and onhand --------
    # Verify Inventory Items on IMS   ${partnerItemId_General}    9    9    0    0   9   0   0
    # Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   9    9    0    0   9   0   0
    # Verify Inventory Items on IMS   ${partnerItemId_HighValue}  9    9    0    0   9   0   0
    
