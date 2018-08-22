*** Settings ***
Documentation     Create Sales Order for simple so flow
Resource          ../resource/group_vars/${env}/global_resource.robot
# Test Setup        Initial Queue

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
RMA_001
    [Documentation]  RMA1
    [Tags]   RMA
    Verify RMA API 


*** Keywords ***
Verify RMA API
    [Arguments]   ${cancel_soKey}  ${request_body}  ${expected_response}
    # Replace global resource variable
    ${CANCEL_ITEM_SALES_ORDER_PATH}=   Replace String   ${CANCEL_ITEM_SALES_ORDER_PATH}  <SO_KEY>    ${cancel_soKey}
    ##### HTTP Request
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Header    X-User-Name           ${X_USER_NAME}
    Set Request Header    X-Roles               bo_${partner_id}
    Set Request Body      ${request_body}
    Next Request May Not Succeed
    POST                  ${CANCEL_ITEM_SALES_ORDER_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
