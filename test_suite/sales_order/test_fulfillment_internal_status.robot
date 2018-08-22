*** Settings ***
Documentation     Verify that OMS will have Internal Status for all Fulfillment Status and Shipping Status
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
FO_INT_STAUTS_003
    [Documentation]  Verify the Internal Status for the order when Order Status is 'COMPLETED' and FO Status is 'COMPLETED'
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
    comment  -------- Verify Internal Status on Fulfillment Order DB --------
    Verify Fulfillment Order on DB    ${soKey}   internalStatus    PACKED
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    RESERVED                                 1
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    INVOICE_GENERATED                        2
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    DOCUMENT_GENERATED                       3
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    OPE_SUBMITTED_CREATE_SHIPPING_ORDER      4
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    BPMN_RESERVE_RESPONDED                   5
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    SHIPPING_ORDER_CREATED                   6
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    OPE_SUBMITTED_CREATE_FULFILLMENT_ORDER   7
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    BPMN_SHIPPING_ORDER_CREATED_RESPONDED    8
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    WMS_CREATE_FO_SUBMITTED                  9
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    WAREHOUSE_SUBMITTED                      10
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    READY_TO_PICK                            11
    Verify History of Fulfillment Order on DB    ${soKey}   internalStatus    PACKED                                   12
