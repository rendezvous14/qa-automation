*** Settings ***
Documentation     SIMPLE SO FLOW
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot
Resource          ../resource/global_resource_sale_order_method.robot

*** Test Cases ***
SO_SIMPLE_001
    [Documentation]  SO_SIMPLE_001_[General] Create single item, line and no serial number
    [Tags]   Simple SO
    Comment   ###### Defined Variables #########
    ${g_current_date}=    Get Current Date    UTC
    ${g_random_id}=     Convert date    ${g_current_date}  result_format=%Y%m%d_%H%M%S
    ${g_partner_id}=    Set Variable    ${R_PARTNER_ID_SCALE_2}
    ${g_partner_slug}=  Set Variable    ${R_PARTNER_SLUG_SCALE_2}
    Set Global Variable    ${g_current_date}
    Set Global Variable    ${g_random_id}
    Set Global Variable    ${g_partner_id}
    Set Global Variable    ${g_partner_slug}
    Comment   ####### Test Data #################
    ${partner_item_id}=    Set Variable             ITEM_${g_partner_id}_${g_random_id}
    ${partner_purchase_order_id}=    Set Variable   PO_${g_partner_id}_${g_random_id}
    ${partnerSalesOrderId}=  Set Variable           SO_${g_partner_id}_${g_random_id}
    ${location_zone}=     Set Variable    Cool Room
    ${purchase_qty}=      Set Variable    100
    ${sales_order_qty}=   Set Variable    50

    Comment   ############## Prepare Item Master ########
    ${partner_item_id}=   Prepare Inventory Items for Sales Orders   ${partner_item_id}  ${R_TEMPLATE_ITEM_MASTER}   ${location_zone}   false    false
    ${partner_item_key}=   Verify Inventory Items on itemmaster_service   ${partner_item_id}    ${g_partner_id}
    Comment   ############## Verify Inventory available and onhand  ######
    Verify Inventory Items on IMS   ${partner_item_key}   0   0
    Comment   ############## Prepare Purchase Order #########
    ${partner_purchase_order_key}=   Prepare Purchase Order for Sales Orders  ${partner_purchase_order_id}   ${R_TEMPLATE_PO_ONE_ITEM}   ${partner_item_id}   ${purchase_qty}
    Comment   ############## Simulate GRN message from Scale ######
    SCALE upload GRN to IMS   ${R_TEMPLATE_SCALE_PO_GRN_ONE_ITEM}  ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}  ${purchase_qty}
    Comment   ############## Verify Inventory available and onhand  ######
    Verify Inventory Items on IMS   ${partner_item_key}   0     ${purchase_qty}
    Comment   ############## Simulate Putaway message from Scale ##########
    SCALE upload PUT AWAY to IMS   ${R_TEMPLATE_SCALE_PO_PUT_AWAY_ONE_ITEM}  ${partner_item_key}  ${partner_purchase_order_id}  ${partner_purchase_order_key}   ${purchase_qty}   ${location_zone}
    Comment   ############## Verify Inventory available and onhand  ######
    Verify Inventory Items on IMS   ${partner_item_key}   ${purchase_qty}   ${purchase_qty}
    #
    ### monitor_order_status
    # Consume Sales Order - Creation queue   ${g_partner_id}
    # Consume Sales Order - Item mapper queue   ${g_partner_id}
    # Consume Sales Order - Order status queue   ${g_partner_id}
    # Consume Sales Order - Creation queue   ${g_partner_id}
    # Comment   ############## Create Sales Order ################
    # ${sales_order_key}=   Prepare Simple Sales Order   ${g_partner_id}   ${partnerSalesOrderId}   ${partner_item_id}   ${sales_order_qty}
    # # ${fulfillment_order_key}=   Get Fulfilment Order ID   ${sales_order_key}
    # # Confirm Sales Order CREATE has been published to order exchange correctly  ${g_partner_id}  ${sales_order_key}
    # ###    so_status_monitor
    # Comment   ############## Simulate Picking pending ######
    # SCALE upload Picking pending to IMS   ${R_TEMPLATE_SCALE_PICKING_PENDING_ONE_ITEM}   ${fulfillment_order_key}
    # Comment   ############## Simulate Order confirm ######
    # # SCALE upload Order confirm to IMS


*** Keywords ***
  # ${shippingStatusLength}=   verify_shipping_status   ${runId}  ${resultJSONBody}   ${trackingId}   ${shippingStatus}

Prepare Inventory Items for Sales Orders
    [Arguments]   ${partner_item_id}    ${template_file}   ${location}=General  ${isSerialTracked}=False  ${isBatchTracked}=False
    ####    Set variable    #####
    # ${partner_item_id}=    Set Variable    ITEM_3916_20171207_172058
    # ${partner_item_id}=    Set Variable    ITEM_${g_partner_id}_${g_random_id}
    #####    Set request body #1    #####
    ${request_body}=    Get File    ${template_file}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID            ${partner_item_id}
    ${request_body}=    Replace String    ${request_body}    VAR_UPC_CODE                   UPC_${g_random_id}
    ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_CODE              ${R_SUPPLIER_SCALE_2}
    ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_KEY               ${R_SUPPLIER_SCALE_2_KEY}
    ${request_body}=    Replace String    ${request_body}    VAR_STANDARD_EXPIRY_TIME       30
    ${request_body}=    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN        FIFO
    ${request_body}=    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT        ${location}
    ${request_body}=    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED          ${isSerialTracked}
    ${request_body}=    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED           ${isBatchTracked}
    Log   ${request_body}
    #####    Send Http request
    ${R_PATH_ITEM}=     Replace String    ${R_PATH_ITEM}     <CONFIG_PARTNER_ID>    ${g_partner_id}
    ${response}=    Create_item    ${request_body}   ${R_EXPECTED_STATUS_200_OK}  ${R_ENDPOINT_ITEM}  ${R_PATH_ITEM}  ${g_partner_id}  ${R_X_ROLES_SCALE_2}   ${R_HTTP_POST}
    Log   ${response}
    Sleep    30s
    ###
    ${R_PATH_ITEM_GET}=     Replace String    ${R_PATH_ITEM_GET}     <CONFIG_PARTNER_ID>   ${g_partner_id}
    Verify Item master via API   ${R_EXPECTED_STATUS_200_OK}   ${R_PATH_ITEM_GET}   ${partner_item_id}
    [Return]     ${partner_item_id}

Prepare Purchase Order for Sales Orders
    [Arguments]    ${partner_purchase_order_id}   ${template_file}   ${partner_item_id}    ${qty}
    ##########    Get current date    ##########
    # ${partner_purchase_order_id}=    Set Variable        PO_${g_partner_id}_${g_random_id}
    ${expected_receive_date}=        Add Time To Date    ${g_current_date}    1 days
    ##########    Set request body    ##########
    ${request_body}=    Get File    ${template_file}
    ${request_body}=    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_PO_ID            ${partner_purchase_order_id}
    ${request_body}=    Replace String    ${request_body}    VAR_CREATE_DATE              ${g_current_date}
    ${request_body}=    Replace String    ${request_body}    VAR_EXPECTED_RECEIVE_DATE    ${expected_receive_date}
    ${request_body}=    Replace String    ${request_body}    VAR_IMPORTED_BY              ROBOT_BEEHIVE
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_DESC_1              Mock by SO automation scripts
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_LINE_NO_1           1
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_QTY_1               ${qty}
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_TAX_RATE_1          10
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_UNIT_PRICE_1        15
    ${request_body}=    Replace String    ${request_body}    VAR_PO_DATE                  ${g_current_date}
    ${request_body}=    Replace String    ${request_body}    VAR_TAX_RATE                 7
    ${request_body}=    Replace String    ${request_body}    VAR_WH_CODE                  TH-ACOM-RM3
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1   ${partner_item_id}
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1     ${R_SUPPLIER_CODE_SCALE_2}
    ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_NAME            ${R_SUPPLIER_SCALE_2}
    Log   ${request_body}
    #####    Send Http request
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${g_partner_id}
    ${purchase_order_key}=   Create po    ${request_body}   ${R_EXPECTED_STATUS_201_OK}   ${R_ENDPOINT_ORDERSTORE}   ${R_PATH_PO}   ${partner_item_id}  ${R_X_ROLES_SCALE_2}  ${R_HTTP_POST}
    ${purchase_order_key}=   Remove String  ${purchase_order_key}  "
    [Return]   ${purchase_order_key}

old - Verify Inventory Items on IMS
    [Arguments]   ${partner_item_key}  ${qty_ats}  ${qty_sum_onhand}
    ${return}=   query_inventory_item   ${R_IMS_DB_CON}   ${partner_item_key}  ${qty_ats}  ${qty_sum_onhand}
    Should Be Equal    '${return}'   '0'

old - Verify Inventory Items on itemmaster_service
    [Arguments]   ${partnerItemId}  ${partnerId}
    Connect ItemMaster Mongo DB
    ${item_query}=   Create Dictionary  partnerId=${partnerId}  partnerItemId=${partnerItemId}
    ${item_dict}=   Find one item from collection   item_master   ${item_query}
    ${partner_item_key}=   Get From Dictionary   ${item_dict}    key
    [Return]   ${partner_item_key}
