*** Settings ***
Library   HttpLibrary.HTTP
Library   DateTime
Library   OperatingSystem
Library   String
Library   Collections


*** Variable ***
${partnerId}      3995
# ${partnerId}      3794
${template_file}   sales_order_template.json
# ${partnerItemId}   3794_20180425_General01
${partnerItemId}   NW_ITEM_3995_GENERAL_001
# ${endpoint_orderstore}   order-store-qa.acommercedev.service
${endpoint_orderstore}   order-store-staging.acommercedev.service
${order_store_path}      /os/item-sales-orders/
${cancel_sales_order_path}    /os/item-sales-orders/<so key>/cancel/
${reason_code_payload}   { "reason": "Duplicate Delivery", "reasonCode": "A05"}

*** Test Cases ***
Gen SO
    #------- Defined Variables ---------#
    ${request_body}=  SO tmp
    : FOR    ${INDEX}    IN RANGE    1    ${loop_no}+1
    \    Log To Console   ${INDEX}/${loop_no}
    \    ${current_date}  Get Current Date
    \    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S%f
    \    ${externalSalesOrderId}=  Set Variable    so_${partnerId}_${random_id}
    \    ${request_body}=   Replace String    ${request_body}   VAR_EXT_SO_ID  ${externalSalesOrderId}
    \    ${request_body}=   Replace String    ${request_body}    VAR_ORDER_DATE     ${current_date}
    \    ${request_body}=   Replace String    ${request_body}    VAR_INVOICE_DATE   ${current_date}
    \    Create Sales Order via API  ${request_body}
    \    ${request_body}=   Replace String    ${request_body}   ${externalSalesOrderId}  VAR_EXT_SO_ID
    Log    For loop is over

Gen SO 2
    #------- Defined Variables ---------#
    ${request_body}=  SO tmp
    : FOR    ${INDEX}    IN RANGE    1    ${loop_no}+1
    \    Log To Console   ${INDEX}/${loop_no}
    \    ${current_date}  Get Current Date
    \    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S%f
    \    ${externalSalesOrderId}=  Set Variable    so_${partnerId}_${random_id}
    \    ${request_body}=   Replace String    ${request_body}   VAR_EXT_SO_ID  ${externalSalesOrderId}
    \    ${request_body}=   Replace String    ${request_body}    VAR_ORDER_DATE     ${current_date}
    \    ${request_body}=   Replace String    ${request_body}    VAR_INVOICE_DATE   ${current_date}
    \    Create Sales Order via API  ${request_body}
    \    ${request_body}=   Replace String    ${request_body}   ${externalSalesOrderId}  VAR_EXT_SO_ID
    Log    For loop is over

Gen SO 3
    #------- Defined Variables ---------#
    ${request_body}=  SO tmp
    : FOR    ${INDEX}    IN RANGE    1    ${loop_no}+1
    \    Log To Console   ${INDEX}/${loop_no}
    \    ${current_date}  Get Current Date  exclude_millis=False
    \    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S%f
    \    ${externalSalesOrderId}=  Set Variable    so_${partnerId}_${random_id}
    \    ${request_body}=   Replace String    ${request_body}   VAR_EXT_SO_ID  ${externalSalesOrderId}
    \    ${request_body}=   Replace String    ${request_body}    VAR_ORDER_DATE     ${current_date}
    \    ${request_body}=   Replace String    ${request_body}    VAR_INVOICE_DATE   ${current_date}
    \    Create Sales Order via API  ${request_body}
    \    ${request_body}=   Replace String    ${request_body}   ${externalSalesOrderId}  VAR_EXT_SO_ID
    Log    For loop is over

Cancel SO
    ${request_body}=   Set Variable    ${reason_code_payload}
    Log  ${request_body}
    Log  ${cancel_sales_order_path}
    ${soKeyList}=   Get File    so_list
    ${loop_no}=   Evaluate    len(${soKeyList})
    : FOR    ${INDEX}    IN RANGE    0    ${loop_no}-1
    \    Log To Console   ${INDEX}/${loop_no}
    \    ${soKey}=  Evaluate  ${soKeyList}[${INDEX}]
    \    ${cancel_sales_order_path}   Replace String    ${cancel_sales_order_path}    <so key>    ${soKey}
    \    Cancel Sales Order via api  ${cancel_sales_order_path}  ${reason_code_payload}
    \    ${cancel_sales_order_path}   Replace String    ${cancel_sales_order_path}    ${soKey}    <so key>
    Log    For loop is over

*** Keywords ***
SO tmp
    # ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${g_current_date}    1 days
    ##########    Set request body    ##########
    ${request_body}    Get File   ${template_file}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_SHIPPING_TYPE       STANDARD_2_4_DAYS
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PAYMENT_TYPE        CCOD
    ${request_body}    Replace String    ${request_body}    VAR_LINE_NUMBER      1
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ID       ${partnerId}
    ${request_body}    Replace String    ${request_body}    VAR_PRODUCT_ID       ${partnerItemId}
    ${request_body}    Replace String    ${request_body}    VAR_PRODUCT_TITLE    ${partnerItemId}
    ${request_body}    Replace String    ${request_body}    VAR_PRODUCT_QTY      1
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID  ${partnerItemId}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_QTY         1
    ${request_body}    Replace String    ${request_body}    VAR_SUB_TOTAL        100.00
    ${request_body}    Replace String    ${request_body}    VAR_GROSS_TOTAL      400
    ${request_body}    Replace String    ${request_body}    VAR_GROSS_AMOUNT      400
    ${request_body}    Replace String    ${request_body}    VAR_COLLECTION_AMOUNT    500
    ${request_body}    Replace String    ${request_body}    VAR_INSURANCE_DECLARED_VALUE    600
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY_UNIT       THB
    ${request_body}    Replace String    ${request_body}    VAR_ORDER_NOTE          Beehive QA Testing
    ${request_body}    Replace String    ${request_body}    VAR_SHIPPING_NOTE       Beehive QA Testing
    ${request_body}    Replace String    ${request_body}    VAR_SALE_SUB_CH_NAME    ALIBABA
    ${request_body}    Replace String    ${request_body}    VAR_SALE_CH_TYPE        e-Marketplace
    ${request_body}    Replace String    ${request_body}    VAR_SALE_CH_ID          ALI
    ${request_body}    Replace String    ${request_body}    VAR_CUSTOMER_TAX_ID    ALI_TAX_0001
    ${request_body}    Replace String    ${request_body}    VAR_CUSTOMER_TAX_TYPE    ALI_TAX_TYPE
    ${request_body}    Replace String    ${request_body}    VAR_CUSTOMER_BRANCH_CODE    ALI_BRANCH_0001
    [Return]   ${request_body}

Create Sales Order via API
    [Arguments]    ${request_body}
    ##### HTTP Request
    Create Http Context     ${endpoint_orderstore}    http
    Set Request Header      Content-Type   application/json
    Set Request Header      X-roles        bo_${partnerId}
    Set Request Header      X-User-Name    bh_automation
    Set Request Body        ${request_body}
    Next Request May Not Succeed
    POST                    ${order_store_path}
    # ${resultJSONBody}=    Get Response Body
    # Log   ${resultJSONBody}
    # Log Response Body
    Response Status Code Should Equal    201
    # Log Response Body
    # [Return]   ${resultJSONBody}

Cancel Sales Order via api
    [Arguments]  ${cancel_sales_order_path}  ${request_body}
    ##### HTTP Request
    Create Http Context     ${endpoint_orderstore}    http
    Set Request Header      Content-Type   application/json
    Set Request Body        ${request_body}
    POST                    ${cancel_sales_order_path}
    Response Status Code Should Equal    200
