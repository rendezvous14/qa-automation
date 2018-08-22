*** Settings ***
Library           HttpLibrary.HTTP
Library           OperatingSystem
Library           DateTime
Library           String
Library           SeleniumLibrary

*** Variables ***
#-------------- Item List -------#
${ITEM_MASTERLIST_ROW_1_COL_1}   xpath=//*[@id="tbody_item"]/tr[1]/td[1]/a
${ITEM_MASTERLIST_ROW_1_COL_2}   xpath=//*[@id="tbody_item"]/tr[1]/td[2]/a

*** Keywords ***
Prepare Inventory Items
    [Arguments]   ${template_file}   ${partner_id}  ${expected_response}  ${storage_requirement}  ${fulfillment_pattern}  ${is_serial_tracked}  ${isBatchTracked}    ${isGDPMDS}=false   
    ${request_body}=   Create Item Master Payload  ${template_file}  ${storage_requirement}  ${fulfillment_pattern}  ${is_serial_tracked}  ${isBatchTracked}    ${isGDPMDS}
    ${partnerItemId}=   POST Item Master via API   ${partner_id}  ${request_body}  ${expected_response}
    ${partnerItemId}=   Wait Until Keyword Succeeds   3x  5s   GET Item Master via API    partnerItemId  ${partner_id}  ${partnerItemId}  ${expected_response}
    [Return]  ${partnerItemId}

Create Item Master Payload
    [Arguments]   ${template_file}  ${storage_requirement}  ${fulfillment_pattern}  ${is_serial_tracked}  ${isBatchTracked}  ${isGDPMDS}
    ############## Set item Id ########
    ${partnerItemId}=   Run Keyword If  '${storage_requirement}'=='General'  Set Variable  ITEM_GENERAL_${g_random_id}
    ...                 ELSE IF   '${storage_requirement}'=='Cool Room'      Set Variable   ITEM_COOLROOM_${g_random_id}
    ...                 ELSE IF   '${storage_requirement}'=='High Value'     Set Variable   ITEM_HIGHVALUE_${g_random_id}
    Log  ${partnerItemId}
    ############## Set Request body  #####
    ${request_body}=    Get File    ${template_file}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID            ${partnerItemId}
    ${request_body}=    Replace String    ${request_body}    VAR_UPC_CODE                   ${g_random_id}
    ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_CODE              ${SUPPLIER_CODE_SC_TH}
    ${request_body}=    Replace String    ${request_body}    VAR_SUPPLIER_KEY               ${SUPPLIER_KEY_SC_TH}
    ${request_body}=    Replace String    ${request_body}    VAR_STANDARD_EXPIRY_TIME       30
    ${request_body}=    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN        ${fulfillment_pattern}
    ${request_body}=    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT        ${storage_requirement}
    ${request_body}=    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED          ${is_serial_tracked}
    ${request_body}=    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED           ${isBatchTracked}
    ${request_body}=    Replace String    ${request_body}    VAR_IS_GDPMDS                  ${isGDPMDS}
    Log   ${request_body}
    
    [Return]    ${request_body}

POST Item Master via API
    [Arguments]     ${partner_id}  ${request_body}  ${expected_response}
    # Replace global resource variable
    ${ITEM_MASTER_PATH}=   Replace String   ${ITEM_MASTER_PATH}  <CONFIG_PARTNER_ID>    ${partner_id}
    # Http library
    Create Http Context   ${ITEM_MASTER_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Header    X-User-Name           ${X_USER_NAME}
    Set Request Header    X-Roles               bo_${partner_id}
    Set Request Body      ${request_body}
    Next Request May Not Succeed
    POST   ${ITEM_MASTER_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
    ${response_msg}=    Get Response Body
    ${getItemKey}=  Get Json Value    ${response_msg}  /key
    ${getItemKey}=  Remove String   ${getItemKey}  "
    ${getPartnerItemId}=  Get Json Value    ${response_msg}  /partnerItemId
    ${getPartnerItemId}=  Remove String   ${getPartnerItemId}  "
    Set Global Variable   ${g_ItemKey}  ${getItemKey}
    Sleep  2s
    [Return]  ${getPartnerItemId}

GET Item Master via API
    [Arguments]   ${field_name}  ${partner_id}  ${partnerItemId}   ${expected_response}
    ${ITEM_MASTER_API}=  Replace String   ${ITEM_MASTER_API}  <CONFIG_PARTNER_ID>   ${partner_id}
    ${ITEM_MASTER_API}=  Replace String   ${ITEM_MASTER_API}  <PARTNER_ITEM_ID>   ${partnerItemId}
    log    ${ITEM_MASTER_API}
    Create Http Context   ${ITEM_MASTER_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Next Request May Not Succeed
    GET    ${ITEM_MASTER_API}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
    ${response_msg}=    Get Response Body
    ${getValue}=  Get Json Value    ${response_msg}  /${field_name}
    ${getValue}=  Remove String   ${getValue}   "
    [Return]    ${getValue}