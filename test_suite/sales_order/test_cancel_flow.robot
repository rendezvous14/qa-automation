*** Settings ***
Documentation     Create Sales Order for simple so flow
Resource          ../resource/group_vars/${env}/global_resource.robot
Resource          ../resource/resource_sale_order_method.robot
Resource          ../resource/resource_item_master_method.robot
Resource          ../resource/resource_purchase_order_method.robot
Resource          ../resource/resource_portal.robot
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
${cancel_template}          ${SO_TEST_DATA}/json/cancel_reason.json

*** Test Cases ***
SO_CANCEL_001
    [Documentation]  Cancel Sales Order when fulfillment status is "RESERVED"
    ...      - multiple items 
    ...      - multiple qty
    [Tags]   Sales Order
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     RESERVED_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

    Prepare inventory and check sale order in public queue  ${externalSalesOrderId}

    Sleep  10s

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Sales Order Create on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Fulfillment Order Create on Order Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for Fulfillment Order Create on Order Exchange
    ...   ${foKey}
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${shippingOrderId}
    ...   ${warehouseCode}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   RESERVED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_General}    1    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_CoolRoom}   2    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_HighValue}  3    1   100.0

    comment  -------- Cancel Sale Order via API --------
    Cancel Sales Order  ${cancel_template}  ${soKey}  ${REASON}  ${REASON_CODE}  ${STATUS_200}

    Sleep  10s

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      CANCELLED
    Verify Sales Order on DB    ${soKey}   shipmentStatus   CANCELLED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false

    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     3
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     4
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     5
    Verify History of Sales Order on DB    ${soKey}       orderStatus     CANCELLED       6
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       backorder       false           6
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        true            4
    Verify History of Sales Order on DB    ${soKey}       onCancel        true            5
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           6
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    CANCELLED
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_General}    1   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_CoolRoom}   2   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_HighValue}  3   1   100.0
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED               1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED               2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    CANCELLED              3
    
    comment  -------- Sales Order Cancel on Order Exchange  --------
    Verify the Messages for Sales Order Cancel on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${REASON}
    ...   ${REASON_CODE}

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   CANCELLED             
    @{detailedStatus}=  Set Variable    NEW   CANCELLED   
    @{visibility}=      Set Variable    15    15            
    Verify the Messages for Sales Order status v2 on Status Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS   CANCELLED
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS   CANCELLED
    ${visibility}=      Set Variable    15    15            15
    Verify the Messages for Sales Order status v3 on bh-order-status Exchange
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    ${idType}=          Set Variable    FULFILLMENT_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    RESERVED   CANCELLED
    @{detailedStatus}=  Set Variable    RESERVED   CANCELLED
    @{visibility}=      Set Variable    15         15                 
    Verify the Messages for Fulfillment Order status v3 on bh-order-status Exchange 
    ...   ${foKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Verify Inventory available and onhand --------
    Verify Inventory Items on IMS   ${partnerItemId_General}    10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  10    10    0    0   10   0   0

SO_CANCEL_002
    [Documentation]  Cancel Sales Order when fulfillment status is "WAREHOUSE_SUMMITED"
    ...      - multiple items 
    ...      - multiple qty
    [Tags]   Sales Order
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     WAREHOUSE_SUBMITTED_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

    Prepare inventory and check sale order in public queue  ${externalSalesOrderId}

    Sleep  10s

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Sales Order Create on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Fulfillment Order Create on Order Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for Fulfillment Order Create on Order Exchange
    ...   ${foKey}
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${shippingOrderId}
    ...   ${warehouseCode}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   WAREHOUSE_SUBMITTED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_General}    1    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_CoolRoom}   2    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_HighValue}  3    1   100.0

    comment  -------- Cancel Sale Order via API --------
    Cancel Sales Order  ${cancel_template}  ${soKey}  ${REASON}  ${REASON_CODE}  ${STATUS_200}

    Sleep  10s

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      CANCELLED
    Verify Sales Order on DB    ${soKey}   shipmentStatus   CANCELLED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false

    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     3
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     4
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     5
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     6
    Verify History of Sales Order on DB    ${soKey}       orderStatus     CANCELLED       7
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       backorder       false           6
    Verify History of Sales Order on DB    ${soKey}       backorder       false           7
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           4
    Verify History of Sales Order on DB    ${soKey}       onCancel        true            5
    Verify History of Sales Order on DB    ${soKey}       onCancel        true            6
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           7
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    CANCELLED
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_General}    1   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_CoolRoom}   2   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_HighValue}  3   1   100.0
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED                1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED     2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED     3
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    CANCELLED               4
    
    comment  -------- Sales Order Cancel on Order Exchange  --------
    Verify the Messages for Sales Order Cancel on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${REASON}
    ...   ${REASON_CODE}

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   CANCELLED             
    @{detailedStatus}=  Set Variable    NEW   CANCELLED   
    @{visibility}=      Set Variable    15    15            
    Verify the Messages for Sales Order status v2 on Status Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS   CANCELLED
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS   CANCELLED
    ${visibility}=      Set Variable    15    15            15
    Verify the Messages for Sales Order status v3 on bh-order-status Exchange
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    ${idType}=          Set Variable    FULFILLMENT_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  CANCELLED
    @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  CANCELLED
    @{visibility}=      Set Variable    15         15                   15
    Verify the Messages for Fulfillment Order status v3 on bh-order-status Exchange 
    ...   ${foKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Verify Inventory available and onhand --------
    Verify Inventory Items on IMS   ${partnerItemId_General}    10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  10    10    0    0   10   0   0

SO_CANCEL_003
    [Documentation]  Cancel Sales Order when fulfillment status is "READY_TO_PICK"
    ...      - multiple items 
    ...      - multiple qty
    [Tags]   Sales Order
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     READY_TO_PICK_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

    Prepare inventory and check sale order in public queue  ${externalSalesOrderId}

    Sleep  10s

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Sales Order Create on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Fulfillment Order Create on Order Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for Fulfillment Order Create on Order Exchange
    ...   ${foKey}
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${shippingOrderId}
    ...   ${warehouseCode}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   READY_TO_PICK
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_General}    1    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_CoolRoom}   2    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_HighValue}  3    1   100.0

    comment  -------- Cancel Sale Order via API --------
    Cancel Sales Order  ${cancel_template}  ${soKey}  ${REASON}  ${REASON_CODE}  ${STATUS_200}

    Sleep  10s

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      CANCELLED
    Verify Sales Order on DB    ${soKey}   shipmentStatus   CANCELLED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false

    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     3
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     4
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     5
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     6
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     7
    Verify History of Sales Order on DB    ${soKey}       orderStatus     CANCELLED       8
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       backorder       false           6
    Verify History of Sales Order on DB    ${soKey}       backorder       false           7
    Verify History of Sales Order on DB    ${soKey}       backorder       false           8
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           4
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           5
    Verify History of Sales Order on DB    ${soKey}       onCancel        true            6
    Verify History of Sales Order on DB    ${soKey}       onCancel        true            7
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           8
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    CANCELLED
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_General}    1   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_CoolRoom}   2   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_HighValue}  3   1   100.0
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED                1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED     2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    READY_TO_PICK           3
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    READY_TO_PICK           4
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    CANCELLED               5
    
    comment  -------- Sales Order Cancel on Order Exchange  --------
    Verify the Messages for Sales Order Cancel on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${REASON}
    ...   ${REASON_CODE}

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   NEW            CANCELLED             
    @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK  CANCELLED   
    @{visibility}=      Set Variable    15    15             15     
    Verify the Messages for Sales Order status v2 on Status Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS   CANCELLED
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS   CANCELLED
    ${visibility}=      Set Variable    15    15            15
    Verify the Messages for Sales Order status v3 on bh-order-status Exchange
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    ${idType}=          Set Variable    FULFILLMENT_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  CANCELLED
    @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  CANCELLED
    @{visibility}=      Set Variable    15         15                   15             15
    Verify the Messages for Fulfillment Order status v3 on bh-order-status Exchange 
    ...   ${foKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Verify Inventory available and onhand --------
    Verify Inventory Items on IMS   ${partnerItemId_General}    10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  10    10    0    0   10   0   0

SO_CANCEL_004
    [Documentation]  Cancel Sales Order when fulfillment status is "PACKED"
    ...      - multiple items 
    ...      - multiple qty
    [Tags]   Sales Order
    comment   -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

    Prepare inventory and check sale order in public queue  ${externalSalesOrderId}

    Sleep  10s

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Sales Order Create on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Fulfillment Order Create on Order Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for Fulfillment Order Create on Order Exchange
    ...   ${foKey}
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${shippingOrderId}
    ...   ${warehouseCode}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   PACKED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_General}    1    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_CoolRoom}   2    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_HighValue}  3    1   100.0

    comment  -------- Cancel Sale Order via API --------
    Cancel Sales Order  ${cancel_template}  ${soKey}  ${REASON}  ${REASON_CODE}  ${STATUS_200}

    Sleep  10s

    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      CANCELLED
    Verify Sales Order on DB    ${soKey}   shipmentStatus   PACKED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false

    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     3
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     4
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     5
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     6
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     7
    Verify History of Sales Order on DB    ${soKey}       orderStatus     CANCELLED       8
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       backorder       false           6
    Verify History of Sales Order on DB    ${soKey}       backorder       false           7
    Verify History of Sales Order on DB    ${soKey}       backorder       false           8
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           4
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           5
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           6
    Verify History of Sales Order on DB    ${soKey}       onCancel        true            7
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           8
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    PACKED
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_General}    1   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_CoolRoom}   2   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_HighValue}  3   1   100.0
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED                1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED     2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    READY_TO_PICK           3
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    PACKED                  4
    
    comment  -------- Sales Order Cancel on Order Exchange  --------
    Verify the Messages for Sales Order Cancel on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${REASON}
    ...   ${REASON_CODE}

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   NEW            NEW     CANCELLED             
    @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK  PACKED  CANCELLED   
    @{visibility}=      Set Variable    15    15             7       15   
    Verify the Messages for Sales Order status v2 on Status Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS   CANCELLED
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS   CANCELLED
    ${visibility}=      Set Variable    15    15            15
    Verify the Messages for Sales Order status v3 on bh-order-status Exchange
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Sales Status v3 on Status Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    ${idType}=          Set Variable    FULFILLMENT_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED  CANCELLED
    @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED  CANCELLED
    @{visibility}=      Set Variable    15         15                   15             15      15
    Verify the Messages for Fulfillment Order status v3 on bh-order-status Exchange 
    ...   ${foKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${idType}
    ...   ${msgType}
    ...   ${orderStatus}
    ...   ${detailedStatus}
    ...   ${visibility}

    comment  -------- Verify Inventory available and onhand --------
    Verify Inventory Items on IMS   ${partnerItemId_General}    9    9    0    0   9   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   9    9    0    0   9   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  9    9    0    0   9   0   0

*** Keywords ***
Prepare inventory and check sale order in public queue
    [Arguments]  ${externalSalesOrderId}
    comment  -------- Prepare Inventory Items --------
    ### General
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   General     FIFO  false   false
    ${partnerItemId_General}=  Set Variable   ${partnerItemId}
    ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10
    ### Cool Room
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   Cool Room   FIFO  false   false
    ${partnerItemId_CoolRoom}=  Set Variable   ${partnerItemId}
    ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10
    ### High Value
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   High Value  FIFO  false   false
    ${partnerItemId_HighValue}=  Set Variable   ${partnerItemId}
    ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10

    comment   -------- Verify Inventory available and onhand  --------
    comment   [Arguments]   partner_item_id    expected_qty_ats    expected_qty_onhand
    comment               expected_qty_coolroom    expected_qty_highvalue
    comment               expected_qty_general    expected_qty_quanrantine
    comment               expected_qty_return
    Verify Inventory Items on IMS   ${partnerItemId_General}    10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   10    10    0    0   10   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  10    10    0    0   10   0   0

    comment  -------- Prepare Line Product item --------
    ${productLineItems_General}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_General}   1   1  1  100.0
    ${productLineItems_CoolRoom}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_CoolRoom}   2  1  1  100.0
    ${productLineItems_HighValue}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_HighValue}  3  1  1  100.0
    ${productLineItemsList}=  Catenate  ${productLineItems_General}  ${COMMA}  ${productLineItems_CoolRoom}   ${COMMA}  ${productLineItems_HighValue}

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order    
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    Log To Console  "soKey = ${soKey}"
    Set Global Variable  ${soKey}  ${soKey}   
    Set Global Variable  ${partnerItemId_General}     ${partnerItemId_General}   
    Set Global Variable  ${partnerItemId_CoolRoom}    ${partnerItemId_CoolRoom}
    Set Global Variable  ${partnerItemId_HighValue}   ${partnerItemId_HighValue}