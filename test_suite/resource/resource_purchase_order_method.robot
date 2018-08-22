*** Settings ***
Library           OperatingSystem
Library           DateTime
Library           String

*** Variables ***

*** Keywords ***
Prepare Purchase Order TH
    [Arguments]   ${template_file}  ${partner_id}  ${expected_response}   ${partnerItemId}  ${qty}
    ${request_body}=   Create Purchase Order Payload  ${template_file}  ${partner_id}  ${partnerItemId}  ${qty}
    ${purchaseOrderKey}=   POST Purchase Order via API   ${partner_id}  ${request_body}  ${expected_response}
    [Return]  ${purchaseOrderKey}

Create Purchase Order Payload
    [Arguments]   ${template_file}  ${partner_id}  ${partnerItemId}    ${qty}
    ##########    Get current date    ##########
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    ${partner_purchase_order_id}=    Set Variable        PO_${partner_id}_${random_id}
    ${expected_receive_date}=        Add Time To Date    ${current_date}    1 days
    ##########    Set request body    ##########
    ${request_body}=    Get File    ${template_file}
    ${request_body}=    Replace String    ${request_body}    VAR_ACTION                   create
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_PO_ID            ${partner_purchase_order_id}
    ${request_body}=    Replace String    ${request_body}    VAR_CREATE_DATE              ${current_date}
    ${request_body}=    Replace String    ${request_body}    VAR_EXPECTED_RECEIVE_DATE    ${expected_receive_date}
    ${request_body}=    Replace String    ${request_body}    VAR_IMPORTED_BY              ROBOT_BEEHIVE
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_DESC_1              Mock by SO automation scripts
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_LINE_NO_1           1
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_QTY_1               ${qty}
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_TAX_RATE_1          10
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_UNIT_PRICE_1        15
    ${request_body}=    Replace String    ${request_body}    VAR_PO_DATE                  ${current_date}
    ${request_body}=    Replace String    ${request_body}    VAR_TAX_RATE                 7
    ${request_body}=    Replace String    ${request_body}    VAR_WH_CODE                  ${WAREHOUSE_CODE_SC_TH}
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1   ${partnerItemId}
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1     ${SUPPLIER_CODE_SC_TH}
    ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_NAME            ${SUPPLIER_CODE_SC_TH}
    Log   ${request_body}
    [Return]  ${request_body}

POST Purchase Order via API
    [Arguments]   ${partner_id}  ${request_body}  ${expected_response}
    # Replace global resource variable
    ${PURCHASE_ORDER_PATH}=   Replace String   ${PURCHASE_ORDER_PATH}   <CONFIG_PARTNER_ID>    ${partner_id}
    # Http library
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Header    X-User-Name           ${X_USER_NAME}
    Set Request Header    X-Roles               bo_${partner_id}
    Set Request Body      ${request_body}
    Next Request May Not Succeed
    POST   ${PURCHASE_ORDER_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
    ${response_msg}=    Get Response Body
    # ${getPurchaseOrderKey}=  Get Json Value    ${response_msg}         /
    ${getPurchaseOrderKey}=  Remove String     ${response_msg}  "
    GET Purchase Order via API  ${getPurchaseOrderKey}  200 OK
    Sleep  1s
    [Return]  ${getPurchaseOrderKey}

GET Purchase Order via API
    [Arguments]   ${purchaseOrderKey}  ${expected_response}
    ${PURCHASE_ORDER_API}=   Replace String   ${PURCHASE_ORDER_API}    <PO_KEY>    ${purchaseOrderKey}
    # Http library
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    GET   ${PURCHASE_ORDER_API}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
