*** Settings ***
Test Setup        Init Rabbitmq Connection    queue-common.acommercedev.service   5672   admin  aCom1234   ScaleBridge-qa
Test Teardown     Close Rabbitmq Connection
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
SO_SIMPLE_001
    [Documentation]    SO_SIMPLE_001_[General] Create single item, line and no serial number
    ...    - Checkout = FIFO
    ...    - Location = General
    [Tags]    Sales Order
    ####### Common Variables #########
    ${g_current_date}=    Get Current Date    UTC
    ${g_random_id}=     Convert date    ${g_current_date}  result_format=%Y%m%d_%H%M%S
    ${g_partner_id}=    Set Variable    ${R_PARTNER_ID_SCALE_2}
    Set Global Variable    ${g_current_date}
    Set Global Variable    ${g_random_id}
    Set Global Variable    ${g_partner_id}
    ${partnerSalesOrderId}=  Set Variable    SO_${g_partner_id}_${g_random_id}
    ####### Item master #########
    ####### Prepare Inventory Items for Sales Orders    ${template_file}   ${location}=General  ${isSerialTracked}=False  ${isBatchTracked}=False
    # ${partner_item_id}=   Prepare Inventory Items for Sales Orders  ${R_TEMPLATE_ITEM_MASTER}   Cool Room   false    false
    # ${partner_item_key}=   Verify Inventory Items on itemmaster_service   ITEM_3916_20171214_071830  ${g_partner_id}
    # Verify Inventory Items on IMS   ${partner_item_key}   0   0
    ####### Purchase Order #########
    # ${partner_item_id}=    Set Variable    ITEM_3916_20171214_071830
    # ${partner_item_key}=    Set Variable    ${item_master_key}
    # ${partner_purchase_order_id}=   Prepare Purchase Order for Sales Orders  ${R_TEMPLATE_PO_ONE_ITEM}   ${partner_item_id}  100
    #####    Send Http request    #####
    # ${request_body}=    Prepare Simple Sales Order template   ${R_TEMPLATE_SO_SINGLE_LINE_SINGLE_ITEM}  ${g_partner_id}  ${partnerSalesOrderId}
    # ####### SO Test Data ########
    # ${request_body}=    Replace String    ${request_body}    VAR_CURRENCY_UNIT               THB
    # ${request_body}=    Replace String    ${request_body}    VAR_SUB_TOTAL                   100.00
    # ${request_body}=    Replace String    ${request_body}    VAR_GROSS_TOTAL                 100.00
    # ${request_body}=    Replace String    ${request_body}    VAR_COLLECTION_AMOUNT           100.00
    # ${request_body}=    Replace String    ${request_body}    VAR_INSURANCE_DECLARED_VALUE    100.00
    # ${request_body}=    Replace String    ${request_body}    VAR_LINE_NUMBER                 1
    # ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ID                  ${g_partner_id}
    # ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_ID                  ${partner_item_id}
    # ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_TITLE               ${partner_item_id}
    # ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_QTY                 1
    # ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID             ${partner_item_id}
    # ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ID                  ${g_partner_id}
    # ${request_body}=    Replace String    ${request_body}    VAR_ITEM_QTY                    1
    # ${request_body}=    Replace String    ${request_body}    VAR_GROSS_AMOUNT                100.00
    # Log   ${request_body}
    ####### Send HTTP Request #####
    # Create Sales Order via API successfully  ${R_PARTNER_ID_SCALE_2}  ${request_body}

    ##### Get GRN from
    # SCALE upload GRN to IMS
    # SCALE upload PUT AWAY to IMS
    ##### IMS
    # Verify Inventory Items on IMS   ${partner_item_key}   0   0

*** Keywords ***
  # ${shippingStatusLength}=   verify_shipping_status   ${runId}  ${resultJSONBody}   ${trackingId}   ${shippingStatus}
# 
# Prepare Inventory Items for Sales Orders
#     [Arguments]   ${template_file}   ${location}=General  ${isSerialTracked}=False  ${isBatchTracked}=False
#     ####    Set variable    #####
#     # ${partner_item_id}=    Set Variable    ITEM_3916_20171207_172058
#     ${partner_item_id}=    Set Variable    ITEM_${g_partner_id}_${g_random_id}
#     #####    Set request body #1    #####
#     ${request_body}=    Get File    ${template_file}
#     ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID            ${partner_item_id}
#     ${request_body}=    Replace String    ${request_body}    VAR_UPC_CODE                   UPC_${g_random_id}
#     ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_CODE              ${R_SUPPLIER_SCALE_2}
#     ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_KEY               ${R_SUPPLIER_SCALE_2_KEY}
#     ${request_body}=    Replace String    ${request_body}    VAR_STANDARD_EXPIRY_TIME       30
#     ${request_body}=    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN        FIFO
#     ${request_body}=    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT        ${location}
#     ${request_body}=    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED          ${isSerialTracked}
#     ${request_body}=    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED           ${isBatchTracked}
#     Log   ${request_body}
#     #####    Send Http request
#     ${R_PATH_ITEM}=     Replace String    ${R_PATH_ITEM}     <CONFIG_PARTNER_ID>    ${g_partner_id}
#     # ${response}=    Create_item    ${request_body}   ${R_EXPECTED_STATUS_200_OK}  ${R_ENDPOINT_ITEM}  ${R_PATH_ITEM}  ${g_partner_id}  ${R_X_ROLES_SCALE_2}   ${R_HTTP_POST}
#     # Log   ${response}
#     # Sleep    10s
#     ###
#     ${R_PATH_ITEM_GET}=     Replace String    ${R_PATH_ITEM_GET}     <CONFIG_PARTNER_ID>   ${g_partner_id}
#     Verify Item master via API   ${R_EXPECTED_STATUS_200_OK}   ${R_PATH_ITEM_GET}   ${partner_item_id}
#     [Return]     ${partner_item_id}
#
# Prepare Purchase Order for Sales Orders
#     [Arguments]    ${template_file}   ${partner_item_id}    ${qty}
#     ##########    Get current date    ##########
#     ${partner_purchase_order_id}=    Set Variable        PO_${g_partner_id}_${g_random_id}
#     ${expected_receive_date}=        Add Time To Date    ${g_current_date}    1 days
#     ##########    Set request body    ##########
#     ${request_body}=    Get File    ${template_file}
#     ${request_body}=    Replace String    ${request_body}    VAR_ACTION    create
#     ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_PO_ID            ${partner_purchase_order_id}
#     ${request_body}=    Replace String    ${request_body}    VAR_CREATE_DATE              ${g_current_date}
#     ${request_body}=    Replace String    ${request_body}    VAR_EXPECTED_RECEIVE_DATE    ${expected_receive_date}
#     ${request_body}=    Replace String    ${request_body}    VAR_IMPORTED_BY              ROBOT_BEEHIVE
#     ${request_body}=    Replace String    ${request_body}    VAR_ITEM_DESC_1              Mock by SO automation scripts
#     ${request_body}=    Replace String    ${request_body}    VAR_ITEM_LINE_NO_1           1
#     ${request_body}=    Replace String    ${request_body}    VAR_ITEM_QTY_1               ${qty}
#     ${request_body}=    Replace String    ${request_body}    VAR_ITEM_TAX_RATE_1          10
#     ${request_body}=    Replace String    ${request_body}    VAR_ITEM_UNIT_PRICE_1        15
#     ${request_body}=    Replace String    ${request_body}    VAR_PO_DATE                  ${g_current_date}
#     ${request_body}=    Replace String    ${request_body}    VAR_TAX_RATE                 7
#     ${request_body}=    Replace String    ${request_body}    VAR_WH_CODE                  TH-ACOM-RM3
#     ${request_body}=    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1   ${partner_item_id}
#     ${request_body}=    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1     ${R_SUPPLIER_CODE_SCALE_2}
#     ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_NAME            ${R_SUPPLIER_SCALE_2}
#     Log   ${request_body}
#     #####    Send Http request
#     ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${g_partner_id}
#     Create po    ${request_body}   ${R_EXPECTED_STATUS_201_OK}   ${R_ENDPOINT_ORDERSTORE}   ${R_PATH_PO}   ${partner_item_id}  ${R_X_ROLES_SCALE_2}  ${R_HTTP_POST}
#
# Verify Inventory Items on IMS
#     [Arguments]   ${partner_item_key}  ${qty_ats}  ${qty_sum_onhand}
#     ${return}=   query_inventory_item   ${R_IMS_DB_CON}   ${partner_item_key}  ${qty_ats}  ${qty_sum_onhand}
#     Should Be Equal    '${return}'   '0'
#
# Verify Inventory Items on itemmaster_service
#     [Arguments]   ${partnerItemId}  ${partnerId}
#     Connect ItemMaster Mongo DB
#     ${item_query}=   Create Dictionary  partnerId=${partnerId}  partnerItemId=${partnerItemId}
#     ${item_dict}=   Find one item from collection   item_master   ${item_query}
#     ${partner_item_key}=   Get From Dictionary   ${item_dict}    key
#     [Return]   ${partner_item_key}
