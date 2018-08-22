*** Settings ***
Suite Setup       Prepare po mock data
Test Teardown     Teardown po master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
Create Purchase Order with item contain special character
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    API_${random}_1234567890_12345678901
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    UI_20171113_Special !@#+
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}
    Sleep    ${R_SLEEP_15_S}
    #####    Check po on portal    #####
    ${R_PO_LIST}    Replace String    ${R_PO_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Login to admin    ${R_PO_LIST}
    Comment    Element Should Contain    ${R_WE_PO_LIST_ROW_1_COL_1}    ${current_date_sub}
    Comment    Element Should Contain    ${R_WE_PO_LIST_ROW_1_COL_2}    ${expected_date_sub}
    Element Text Should Be    ${R_WE_PO_LIST_ROW_1_COL_3}    ${partner_po_id_gen}
    Element Text Should Be    ${R_WE_PO_LIST_ROW_1_COL_4}    ${R_SUPPLIER_NS_6}
    Element Text Should Be    ${R_WE_PO_LIST_ROW_1_COL_5}    ${R_WAREHOUSE_CODE_NS1}
    Element Text Should Be    ${R_WE_PO_LIST_ROW_1_COL_6}    10
    Element Text Should Be    ${R_WE_PO_LIST_ROW_1_COL_7}    10
    Element Text Should Be    ${R_WE_PO_LIST_ROW_1_COL_8}    Pending Receipt
    Login to NS
    Input Text    ${R_NS_XPATH_SEARCH_STRING}    ${partner_po_id_gen}
    Press Key    ${R_NS_XPATH_SEARCH_STRING}    \\13
    Sleep    ${R_SLEEP_3_S}
    Wait Until Page Contains Element Override    ${R_NS_XPATH_SEARCH_RESULT}
    Click Element    ${R_NS_XPATH_SEARCH_RESULT}
    Sleep    ${R_SLEEP_3_S}
    Element Text Should Be    ${R_NS_XPATH_PO_PARTNER_PO_ID}    ${R_PARTNER_PREFIX_NS_6}${partner_po_id_gen}
