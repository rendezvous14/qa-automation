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
${sales_order_template}       ${SO_TEST_DATA}/json/sales_order_max_lenght.json
${bundle_productLineItems_template}   ${SO_TEST_DATA}/json/bundle_productLineItems_template.json
${lineItems_template}       ${SO_TEST_DATA}/json/LineItems_template.json

*** Test Cases ***
SO_MAX_LENGHT_001
    [Documentation]  Create Sales Order with shipping address equal to max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   25   [LOWER]
    ${address1}=   Generate Random String   50   [LOWER]
    ${city}=   Generate Random String   25   [LOWER]
    ${postalCode}=   Generate Random String   25   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_002
    [Documentation]  Create Sales Order with addressee more than max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   30   [LOWER]
    ${address1}=   Generate Random String   50   [LOWER]
    ${city}=   Generate Random String   25   [LOWER]
    ${postalCode}=   Generate Random String   25   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_003
    [Documentation]  Create Sales Order with addressee less then max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   24   [LOWER]
    ${address1}=   Generate Random String   50   [LOWER]
    ${city}=   Generate Random String   25   [LOWER]
    ${postalCode}=   Generate Random String   25   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_004
    [Documentation]  Create Sales Order with address1 more than max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   25   [LOWER]
    ${address1}=   Generate Random String   60   [LOWER]
    ${city}=   Generate Random String   25   [LOWER]
    ${postalCode}=   Generate Random String   25   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_005
    [Documentation]  Create Sales Order with address1 less then max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   25   [LOWER]
    ${address1}=   Generate Random String   40   [LOWER]
    ${city}=   Generate Random String   25   [LOWER]
    ${postalCode}=   Generate Random String   25   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_006
    [Documentation]  Create Sales Order with city more than max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   25   [LOWER]
    ${address1}=   Generate Random String   50   [LOWER]
    ${city}=   Generate Random String   30   [LOWER]
    ${postalCode}=   Generate Random String   25   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_007
    [Documentation]  Create Sales Order with city less then max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   25   [LOWER]
    ${address1}=   Generate Random String   50   [LOWER]
    ${city}=   Generate Random String   23   [LOWER]
    ${postalCode}=   Generate Random String   25   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_008
    [Documentation]  Create Sales Order with postalCode more than max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   25   [LOWER]
    ${address1}=   Generate Random String   50   [LOWER]
    ${city}=   Generate Random String   25   [LOWER]
    ${postalCode}=   Generate Random String   30   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_009
    [Documentation]  Create Sales Order with postalCode less then max lenght
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    ${addressee}=   Generate Random String   25   [LOWER]
    ${address1}=   Generate Random String   50   [LOWER]
    ${city}=   Generate Random String   25   [LOWER]
    ${postalCode}=   Generate Random String   20   [LOWER]
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}

SO_MAX_LENGHT_010
    [Documentation]  Create Sales Order with shiiping address contain TH language
    [Tags]   Max lenght
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     SO_${partner_id}_${g_random_id}
    ${addressee}=   Set Variable   เรืออากาศโทหม่อมราชวงศ์รณพีร์ จุฑาเทพ
    ${address1}=   Set Variable   สถานทูตกัมพูชาประจำประเทศไทย
    ${city}=    Set Variable    กรุงเทพมหานคร อมรรัตนโกสินทร์ มหินทรายุธยา มหาดิลกภพ นพรัตนราชธานีบูรีรมย์
    ${postalCode}=   Set Variable   123456789012345678901234567890123456789012345678901234567890
    ${country}=    Set Variable    Thailand
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
    
    Clear Scale Bridge Queue   
    Sleep   2s

    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order for max lenght  
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    ...           ${addressee}
    ...           ${address1} 
    ...           ${city} 
    ...           ${postalCode}
    ...           ${country}
    Log To Console  "soKey = ${soKey}"

    Sleep   20s
    
    comment  -------- Get item key via API -----------
    ${getItemKey_General}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_General}  ${STATUS_200}
    ${getItemKey_CoolRoom}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_CoolRoom}  ${STATUS_200}
    ${getItemKey_HighValue}=   GET Item Master via API  key  ${partnerId}  ${partnerItemId_HighValue}  ${STATUS_200}

    comment  -------- Sales Order Create on Download Exchange  --------
    ${foKey}=   Get Fulfillment Order Key on DB   ${soKey}
    ${shippingOrderId}=  Set Variable   ${foKey}
    Verify the Messages for sale order on Scale Download Exchange  
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

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Shipping address on Order Exchange  
    ...   ${soKey}
    ...   ${addressee}
    ...   ${address1}
    ...   ${city}
    ...   ${postalCode}
    ...   ${country}