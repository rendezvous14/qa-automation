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

*** Test Cases ***
SO_SIMPLE_001
    [Documentation]  Create Sales Order with normal product items
    ...      - multiple items 
    ...      - multiple qty
    [Tags]   Sales Order
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

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

    Wait until Fulfillment Order Status is PACKED
    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   PACKED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_General}    1    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_CoolRoom}   2    1   100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products    ${partnerItemId_HighValue}  3    1   100.0
    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           4
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           5
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    PACKED
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_General}    1   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_CoolRoom}   2   1   100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_HighValue}  3   1   100.0
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED               1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED    2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    READY_TO_PICK          3
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    PACKED                 4
    
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

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   NEW             NEW 
    @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK   PACKED
    @{visibility}=      Set Variable    15    15              7
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
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS
    ${visibility}=      Set Variable    15    15
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
    @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
    @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
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
    Verify Inventory Items on IMS   ${partnerItemId_General}    9    9    0    0   9   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   9    9    0    0   9   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  9    9    0    0   9   0   0
    
SO_SIMPLE_002
    [Documentation]  Create Sales Order with Bundle product items
    ...      - Bundle product items
    ...      - Multiple items qty
    [Tags]   Sales Order
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}

    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

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
    ${bundle_product_title}=    Set Variable     BUNDLE_${partner_id}_${g_random_id}
    Log to console   "Sales Order Id = ${externalSalesOrderId}"
    ${productLineItems_General}=  Create Line Items for Bundle   ${LineItems_template}  ${partner_id}  ${partnerItemId_General}   2
    ${productLineItems_CoolRoom}=  Create Line Items for Bundle   ${LineItems_template}  ${partner_id}  ${partnerItemId_CoolRoom}   2
    ${productLineItems_HighValue}=  Create Line Items for Bundle   ${LineItems_template}  ${partner_id}  ${partnerItemId_HighValue}   2
    ${productLineItemsList}=  Catenate  ${productLineItems_General}  ${COMMA}  ${productLineItems_CoolRoom}   ${COMMA}  ${productLineItems_HighValue}
    ${bundle_productLineItemsList}=  Create Bundle Product Items  ${bundle_productLineItems_template}  ${partner_id}  ${bundle_product_title}   ${productLineItemsList}  1   1  3000.99
    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order    
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${bundle_productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    Log To Console  "soKey = ${soKey}"
    Wait until Fulfillment Order Status is PACKED
    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   PACKED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_products    ${bundle_product_title}     1    1   1  3000.99
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_items       ${partnerItemId_General}    1    1   2  1000.33
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_items       ${partnerItemId_CoolRoom}   1    2   2  1000.33
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_items       ${partnerItemId_HighValue}  1    3   2  1000.33
    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           4
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           5
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    PACKED
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_products    ${bundle_product_title}     1    1   1  3000.99
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_items       ${partnerItemId_General}    1    1   2  1000.33
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_items       ${partnerItemId_CoolRoom}   1    2   2  1000.33
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_items       ${partnerItemId_HighValue}  1    3   2  1000.33
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED               1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED    2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    READY_TO_PICK          3
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    PACKED                 4
    
    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Sales Order Create on Order Exchange - Bundle
    ...   ${soKey}
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

    comment  -------- Fulfillment Order Create on Order Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for Fulfillment Order Create on Order Exchange - Bundle
    ...   ${foKey}
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

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   NEW             NEW
    @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK   PACKED
    @{visibility}=      Set Variable    15    15              7
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
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS
    ${visibility}=      Set Variable    15    15
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
    @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
    @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
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

    comment   -------- Verify Inventory available and onhand  --------
    Verify Inventory Items on IMS   ${partnerItemId_General}    8    8    0    0   8   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   8    8    0    0   8   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  8    8    0    0   8   0   0

SO_SIMPLE_003
    [Documentation]  Create Sales Order with multiple items, Item Service and Item Discount
    ...      - Multiple Items
    ...      - Multiple qty
    ...      - Item Service
    ...      - Item Discount
    [Tags]   Sales Order
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}

    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

    comment  -------- Item Service - Discount ------
    ${partnerItemId_Service}=   Set Variable    All Shipping Charges
    ${partnerItemId_Discount}=   Set Variable    Discount

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
    ${productLineItems_General}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_General}      1  1  1  100.0
    ${productLineItems_CoolRoom}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_CoolRoom}    2  1  1  100.0
    ${productLineItems_HighValue}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_HighValue}  3  1  1  100.0
    ${productLineItem_Service}=   Create Product Line Items   ${productLineItem_template}  ${partner_id}  ${partnerItemId_Service}   4  1  1  100.0
    ${productLineItem_Discount}=   Create Product Line Items   ${productLineItem_template}  ${partner_id}  ${partnerItemId_Discount}  5  1  1  -100.0
    ${productLineItemsList}=  Catenate  
    ...      ${productLineItems_General}  ${COMMA}  
    ...      ${productLineItems_CoolRoom}   ${COMMA}  
    ...      ${productLineItems_HighValue}  ${COMMA}
    ...      ${productLineItem_Service}  ${COMMA}
    ...      ${productLineItem_Discount} 

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
    Wait until Fulfillment Order Status is PACKED
    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   PACKED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_General}    1   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_CoolRoom}   2   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_HighValue}  3   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_Service}    4   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_Discount}   5   1  -100.0
    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           4
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           5
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    PACKED
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_General}    1   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_CoolRoom}   2   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_HighValue}  3   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_Service}    4   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_Discount}   5   1  -100.0
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED               1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED    2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    READY_TO_PICK          3
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    PACKED                 4
    
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

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   NEW             NEW
    @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK   PACKED
    @{visibility}=      Set Variable    15    15              7
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
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS
    ${visibility}=      Set Variable    15    15
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
    @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
    @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
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
    Verify Inventory Items on IMS   ${partnerItemId_General}    9    9    0    0   9   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   9    9    0    0   9   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  9    9    0    0   9   0   0

SO_SIMPLE_004
    [Documentation]  Create Sales Order with Bundle product, Multiple items, Item services and Item discount
    ...      - Bundle product items
    ...      - Multiple items qty
    ...      - Item service
    ...      - Item discount
    [Tags]   Sales Order
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}

    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    Log to console   "Partner Id = ${partner_id}"
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

    comment  -------- Item Service - Discount ------
    ${partnerItemId_Service}=   Set Variable    All Shipping Charges
    ${partnerItemId_Discount}=   Set Variable    Discount
    
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
    ${bundle_product_title}=    Set Variable     BUNDLE_${partner_id}_${g_random_id}
    ## Product Bundle
    ${productLineItems_General}=  Create Line Items for Bundle   ${LineItems_template}  ${partner_id}  ${partnerItemId_General}   2
    ${productLineItems_CoolRoom}=  Create Line Items for Bundle   ${LineItems_template}  ${partner_id}  ${partnerItemId_CoolRoom}   2
    ${productLineItems_HighValue}=  Create Line Items for Bundle   ${LineItems_template}  ${partner_id}  ${partnerItemId_HighValue}   2
    ${productLineItemsList}=  Catenate  ${productLineItems_General}  ${COMMA}  ${productLineItems_CoolRoom}   ${COMMA}  ${productLineItems_HighValue}
    ${bundle_productLineItemsList}=  Create Bundle Product Items  ${bundle_productLineItems_template}  ${partner_id}  ${bundle_product_title}   ${productLineItemsList}  1   1  3000.99
    ## Product items
    ${productLineItems_General}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_General}      2  1  1  100.0
    ${productLineItems_CoolRoom}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_CoolRoom}    3  1  1  100.0
    ${productLineItems_HighValue}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_HighValue}  4  1  1  100.0
    ## Service Discount
    ${productLineItem_Service}=   Create Product Line Items   ${productLineItem_template}  ${partner_id}  ${partnerItemId_Service}   5  1  1  100.0
    ${productLineItem_Discount}=   Create Product Line Items   ${productLineItem_template}  ${partner_id}  ${partnerItemId_Discount}  6  1  1  -100.0
    ${productsAll}=   Catenate   ${bundle_productLineItemsList}   ${COMMA}
    ...        ${productLineItems_General}  ${COMMA}
    ...        ${productLineItems_CoolRoom}  ${COMMA}
    ...        ${productLineItems_HighValue}  ${COMMA}
    ...        ${productLineItem_Service}   ${COMMA}
    ...        ${productLineItem_Discount}
    Log    ${productsAll}

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order    
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productsAll}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    Log To Console  "soKey = ${soKey}"
    Wait until Fulfillment Order Status is PACKED
    comment  -------- Verify data on Order Store DB --------
    Verify Sales Order on DB    ${soKey}   orderStatus      IN_PROGRESS
    Verify Sales Order on DB    ${soKey}   shipmentStatus   PACKED
    Verify Sales Order on DB    ${soKey}   backorder        false
    Verify Sales Order on DB    ${soKey}   onCancel         false
    Verify Sales Order on DB    ${soKey}   deleted          false
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_products    ${bundle_product_title}     1    1   1  3000.99
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_items       ${partnerItemId_General}    1    1   2  1000.33
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_items       ${partnerItemId_CoolRoom}   1    2   2  1000.33
    Verify Bundle items on Sales Order DB   ${soKey}   bundle_items       ${partnerItemId_HighValue}  1    3   2  1000.33
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_General}    2   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_CoolRoom}   3   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_HighValue}  4   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_Service}    5   1  100.0
    Verify Partner Item Id on Sales Order on DB    ${soKey}   products         ${partnerItemId_Discount}   6   1  -100.0
    Verify History of Sales Order on DB    ${soKey}       orderStatus     NEW             1
    Verify History of Sales Order on DB    ${soKey}       orderStatus     IN_PROGRESS     2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           1
    Verify History of Sales Order on DB    ${soKey}       backorder       false           2
    Verify History of Sales Order on DB    ${soKey}       backorder       false           3
    Verify History of Sales Order on DB    ${soKey}       backorder       false           4
    Verify History of Sales Order on DB    ${soKey}       backorder       false           5
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           1
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           2
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           3
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           4
    Verify History of Sales Order on DB    ${soKey}       onCancel        false           5
    Verify Fulfillment Order on DB    ${soKey}   fulfillmentStatus    PACKED
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_products    ${bundle_product_title}     1    1   1  3000.99
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_items       ${partnerItemId_General}    1    1   2  1000.33
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_items       ${partnerItemId_CoolRoom}   1    2   2  1000.33
    Verify Bundle items on Fulfillment Order DB   ${soKey}   bundle_items       ${partnerItemId_HighValue}  1    3   2  1000.33
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_General}    2   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_CoolRoom}   3   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_HighValue}  4   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_Service}    5   1  100.0
    Verify Partner Item Id on Fulfillment Order on DB    ${soKey}   products     ${partnerItemId_Discount}   6   1  -100.0
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    RESERVED               1
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    WAREHOUSE_SUBMITTED    2
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    READY_TO_PICK          3
    Verify History of Fulfillment Order on DB    ${soKey}     fulfillmentStatus    PACKED                 4
    
    comment  -------- Sales Order Create on Order Exchange  --------
    ##  Products level
    ##  1 - bundle_product_title
    ##       0 - partnerItemId_General
    ##       1 - partnerItemId_CoolRoom
    ##       2 - partnerItemId_HighValue
    ##  2 - partnerItemId_General
    ##  3 - partnerItemId_CoolRoom
    ##  4 - partnerItemId_HighValue
    ##  5 - partnerItemId_Service
    ##  6 - partnerItemId_Discount
    Verify the Messages for Sales Order Create on Order Exchange - All
    ...   ${soKey}
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

    comment  -------- Fulfillment Order Create on Order Exchange --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for Fulfillment Order Create on Order Exchange - All
    ...   ${foKey}
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

    comment  -------- Sales Status v2 on Status Exchange --------
    ${idType}=          Set Variable    ITEM_SALES_ORDER
    ${msgType}=         Set Variable    ORDER_STATUS
    @{orderStatus}=     Set Variable    NEW   NEW             NEW
    @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK   PACKED
    @{visibility}=      Set Variable    15    15              7
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
    @{orderStatus}=     Set Variable    NEW   IN_PROGRESS
    @{detailedStatus}=  Set Variable    NEW   IN_PROGRESS
    ${visibility}=      Set Variable    15    15
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
    @{orderStatus}=     Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
    @{detailedStatus}=  Set Variable    RESERVED   WAREHOUSE_SUBMITTED  READY_TO_PICK  PACKED
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

    comment   -------- Verify Inventory available and onhand  --------
    Verify Inventory Items on IMS   ${partnerItemId_General}    7    7    0    0   7   0   0
    Verify Inventory Items on IMS   ${partnerItemId_CoolRoom}   7    7    0    0   7   0   0
    Verify Inventory Items on IMS   ${partnerItemId_HighValue}  7    7    0    0   7   0   0