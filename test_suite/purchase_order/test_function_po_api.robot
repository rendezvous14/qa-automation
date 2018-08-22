*** Settings ***
Suite Setup       Prepare po mock data
Test Teardown     Teardown po master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
PO_API_001_[partnerPurchaseOrderId] length = 45
    [Documentation]    Expected result
    ...
    ...    1. return 201
    ...    check all field in message response its correct
    ...
    ...    2. Get check PO that can find it.
    ...
    ...    3. Check can find on NS
    ...    - check partnerPurchaseOrderId at External id in NS
    ...
    ...    4. Check in Portal Purchase Order at PO ID
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    API_${random}_1234567890_12345678901
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
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
    Click Element    ${R_WE_PO_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_PO_DETAIL_PO_ID}
    Element Text Should Be    ${R_WE_PO_DETAIL_PO_ID}    PO ID: ${partner_po_id_gen}
    Element Text Should Be    ${R_WE_PO_DETAIL_PARTNER}    ${R_PARTNER_NAME_NS_6}
    Element Text Should Be    ${R_WE_PO_DETAIL_SUPPLIER}    ${R_SUPPLIER_NS_6}
    Element Text Should Be    ${R_WE_PO_DETAIL_CURRENCY}    THB
    Element Text Should Be    ${R_WE_PO_DETAIL_WH}    ${R_WAREHOUSE_CODE_NS1}
    Element Should Contain    ${R_WE_PO_DETAIL_DATE}    ${current_date_sub}
    Element Should Contain    ${R_WE_PO_DETAIL_EXPECTED_RECEIVE_DATE}    ${expected_date_sub}
    Element Should Contain    ${R_WE_PO_DETAIL_CREATED_DATE}    ${current_date_sub}
    Element Should Contain    ${R_WE_PO_DETAIL_CREATED_DATE}    APP_Beehive
    Element Text Should Be    ${R_WE_PO_DETAIL_SUMMARY_SUB}    150
    Element Text Should Be    ${R_WE_PO_DETAIL_SUMMARY_TAX}    10.5
    Element Text Should Be    ${R_WE_PO_DETAIL_SUMMARY_TOTAL}    160.5
    Verify po detail item tab    1    ${R_ITEM_XXX_G_FIFO_007}    ${R_SUPPLIER_NS_6}    Item description    10    0
    ...    10    15    150    0.07    10.5    160.5
    Click element    ${R_WE_PO_DETAIL_ADDR_TAB}
    Verify po detail address tab
    Click element    ${R_WE_PO_DETAIL_SUP_ADDR_TAB}
    Verify po detail supplier address tab    ${R_SUPPLIER_NS_6}
    Click element    ${R_WE_PO_DETAIL_GRN_TAB}
    Page Should Contain    No Goods Received Note.
    Login to NS
    Input Text    ${R_NS_XPATH_SEARCH_STRING}    ${partner_po_id_gen}
    Press Key    ${R_NS_XPATH_SEARCH_STRING}    \\13
    Sleep    ${R_SLEEP_3_S}
    Wait Until Page Contains Element Override    ${R_NS_XPATH_SEARCH_RESULT}
    Click Element    ${R_NS_XPATH_SEARCH_RESULT}
    Sleep    ${R_SLEEP_3_S}
    Element Text Should Be    ${R_NS_XPATH_PO_PARTNER_PO_ID}    ${R_PARTNER_PREFIX_NS_6}${partner_po_id_gen}

PO_API_002_[partnerPurchaseOrderId] length < 45
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}_1234567890_1234567890
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_003_[partnerPurchaseOrderId] Eng words
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_004_[partnerPurchaseOrderId] Chiness words (ตัวเต็ม)
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_須介首助職例_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_005_[partnerPurchaseOrderId] Chiness words (ตัวย่อ)
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_质油救效须介首助职例_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_006_[partnerPurchaseOrderId] Japaness words (hiragana)
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_ういたしまして_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_007_[partnerPurchaseOrderId] Japaness words (Kanji)
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_明行極珠度清_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_008_[partnerPurchaseOrderId] Japaness words (Katakana)
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_ホチキス_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_009_[partnerPurchaseOrderId] Thai words
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_ใบสั่งซื้อ_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_010_[partnerPurchaseOrderId] has "single quote" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    'API_${random}'
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_011_[partnerPurchaseOrderId] has "low-9 quote" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_,TEST,${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_012_[partnerPurchaseOrderId] has "double quote" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_\\"TEST\\"${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_013_[partnerPurchaseOrderId] has "double quote" Special Char in text(first,last)
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    \\"API_${random}\\"
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_014_[partnerPurchaseOrderId] has "dagger" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}†
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_015_[partnerPurchaseOrderId] has "double dagger" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}‡
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_016_[partnerPurchaseOrderId] has "per mill sign" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    ‰API_${random}‰
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_017_[partnerPurchaseOrderId] has "pointing angle quote" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    ‹API_$${random}›
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_018_[partnerPurchaseOrderId] has "spade, club,heart, diamond suit " Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_♠♣♥_${random}♦
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_019_[partnerPurchaseOrderId] has "dot " Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_.._${random}..
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_020_[partnerPurchaseOrderId] has "dash" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_TEST-01_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_021_[partnerPurchaseOrderId] has "at sign" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    @API_TEST-01_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_022_[partnerPurchaseOrderId] has "backslash" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    \\\\API_TEST-01_${random}\\\\
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_023_[partnerPurchaseOrderId] has "slash" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    \\\/API_TEST-01_${random}\\\/
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_024_[partnerPurchaseOrderId] has "space" Special Char in front text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    ${SPACE}API_TEST-01_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_025_[partnerPurchaseOrderId] has "space" Special Char in behind text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_TEST-01_${random}${SPACE}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_026_[partnerPurchaseOrderId] set "space" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    ${SPACE}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_027_[partnerPurchaseOrderId] has "parenthesis" Special Char in text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_(TEST-01)_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_028_[partnerPurchaseOrderId] has numeric
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_TEST-01_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_029_[partnerPurchaseOrderId] can't create if length> 46
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}_1234567890_1234567890_12345678
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_030_[partnerPurchaseOrderId] can't create if put empty string
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    ${EMPTY}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_031_[partnerPurchaseOrderId] can't create if delete field
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Remove String    ${request_body}    "partnerPurchaseOrderId": "VAR_PARTNER_PO_ID",
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_032_[supplierName] can create if specific default supplier
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_033_[supplierName] can create if specific not default supplier
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    QA_NS_AUTOMATION_6_NOT_DEFAULT
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    QA_NS_AUTOMATION_6_NOT_DEFAULT
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_034_[supplierName] can create if put empty string
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${EMPTY}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_035_[supplierName] can create if delete this field
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Remove String    ${request_body}    "supplierName": "VAR_SUPPLIER_NAME",
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_036_[supplierName] can't create if supplierName doesn't exist in partner
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    SUPPLIER_NAME
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_037_[warehouseCode] can create if warehouseCode exist in warehouse master
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_038_[warehouseCode] can create if empty string
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    "warehouseCode": "TH-AUTO-NS1"    "warehouseCode": "${EMPTY}"
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_039_[warehouseCode] can't create if warehouseCode is space
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    "warehouseCode": "TH-AUTO-NS1"    "warehouseCode": "${SPACE}"
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_040_[warehouseCode] can create if delete field
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    "taxRate": 7,    "taxRate": 7
    ${request_body}    Remove String    ${request_body}    "warehouseCode": "TH-AUTO-NS1"
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_041_[warehouseCode] can't create if warehouseCode does not exist in warehouse master
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    "warehouseCode": "TH-AUTO-NS1"    "warehouseCode": "TH-AUTO-NS1_XXX"
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_042_[expectedReceiveDate] can create if expectedReceiveDate is day/month/year hh:mm:ss
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days    result_format=%d/%m/%Y %H:%M:%S
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_043_[expectedReceiveDate] can create if set day/month/year
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days    result_format=%d/%m/%Y
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_044_[expectedReceiveDate] can't create if empty string
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${EMPTY}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_045_[expectedReceiveDate] can create if delete field
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Remove String    ${G_REQUEST_BODY}    "expectedReceiveDate": "VAR_EXPECTED_RECEIVE_DATE",
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_046_[expectedReceiveDate] can't create if expectedReceiveDate is TH lang.
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    1 มกราคม 2560
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_047_[expectedReceiveDate] can't create if expectedReceiveDate is over date
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    2017-11-31
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_048_[expectedReceiveDate] can't create if expectedReceiveDate is over month
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    31 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    2017-15-10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_050_[purchaseOrderDate] can create if purchaseOrderDate is day/ month/ year hh:mm:ss
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date    result_format=%d/%m/%Y %H:%M:%S
    ${G_CURRENT_DATE_2}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE_2}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_051_[purchaseOrderDate] can create if purchaseOrderDate is day/ month/ year
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date    result_format=%d/%m/%Y
    ${G_CURRENT_DATE_2}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE_2}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_052_[purchaseOrderDate] can create if delete field
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Remove String    ${G_REQUEST_BODY}    "purchaseOrderDate": "VAR_PO_DATE",
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_053_[purchaseOrderDate] can't create if purchaseOrderDate is TH lang.
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    1 มกราคม 2560
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_054_[purchaseOrderDate] can't create if purchaseOrderDate is over date
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    2017-11-31
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_055_[purchaseOrderDate] can't create if purchaseOrderDate is over month
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    2017-15-30
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_056_[purchaseOrderDate] can create if purchaseOrderDate has "slash"
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    2017/11/1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_057_[taxRate] can create if set empty string
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    ${EMPTY}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_058_[taxRate] can create if delete field
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Remove String    ${G_REQUEST_BODY}    "taxRate": VAR_TAX_RATE,
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_059_[taxRate] can create if partner Indo taxRate input 0
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_ID}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_1}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_1}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_1}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_1}    ${R_X_ROLES_NS_1}
    ...    ${R_HTTP_POST}

PO_API_060_[taxRate] can create if partner Indo taxRate input 10
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_ID}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_1}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_1}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_1}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_1}    ${R_X_ROLES_NS_1}
    ...    ${R_HTTP_POST}

PO_API_061_[taxRate] can create if partner Phili taxRate input 0
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_PH}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_2}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_2}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_2}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_2}    ${R_X_ROLES_NS_2}
    ...    ${R_HTTP_POST}

PO_API_062_[taxRate] can create if partner Phili taxRate input 12
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    12
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_PH}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_2}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_2}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_2}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_2}    ${R_X_ROLES_NS_2}
    ...    ${R_HTTP_POST}

PO_API_063_[taxRate] can create if partner Thailand taxRate input 0
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_064_[taxRate] can create if partner Thailand taxRate input 7
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_065_[taxRate] can create if partner Singapore taxRate input 0
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_SG}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_5}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_5}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_5}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_5}    ${R_X_ROLES_NS_5}
    ...    ${R_HTTP_POST}

PO_API_066_[taxRate] can create if partner Singapore taxRate input 7
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_SG}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_5}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_5}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_5}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_5}    ${R_X_ROLES_NS_5}
    ...    ${R_HTTP_POST}

PO_API_067_[taxRate] can't create if taxRate has decimal(ทศนิยม)
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_068_[taxRate] can't create if taxRate is negative
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    -7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_069_[taxRate] can't create if taxRate is text
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    ten
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_070_[taxRate] can't create if partner Indo taxRate input 12
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    12
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_ID}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_1}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_1}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_1}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_1}    ${R_X_ROLES_NS_1}
    ...    ${R_HTTP_POST}

PO_API_071_[taxRate] can't create if partner Phili taxRate input 20
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    20
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_PH}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_2}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_2}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_2}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_2}    ${R_X_ROLES_NS_2}
    ...    ${R_HTTP_POST}

PO_API_072_[taxRate] can't create if partner Thailand taxRate input 30
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    30
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_073_[taxRate] can't create if partner Singapore taxRate input 40
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    40
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_SG}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_5}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_5}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_5}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_5}    ${R_X_ROLES_NS_5}
    ...    ${R_HTTP_POST}

PO_API_074_[partnerItemId] can't create if partnerItemId does not exist in partner
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}_X
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_075_[partnerItemId] can't create if partnerItemId is empty string
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_077_[partnerItemId] can't create if delete field
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Remove String    ${request_body}    "partnerPurchaseOrderId": "VAR_PARTNER_PO_ID",
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_078_[supplierCode] can create if supplierCode is text
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_079_[supplierCode] can create if supplierCode is empty syring
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_081_[supplierCode] can create if delete field
    Comment    ******create PO By API *****
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Remove String    ${request_body}    "supplierCode": "VAR_ITEM_SUPPLIER_CODE_1",
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_082_[unitPrice][agent] can create if unitPrice length <=9
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    123456789
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_TH_AGENT}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_3}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_3}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_3}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_3}    ${R_X_ROLES_NS_3}
    ...    ${R_HTTP_POST}

PO_API_084_[unitPrice][agent] can create if unitPrice has decimal <=5
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    123456789.12345
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_TH_AGENT}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_3}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_3}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_3}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_3}    ${R_X_ROLES_NS_3}
    ...    ${R_HTTP_POST}

PO_API_085_[unitPrice][agent] can create if unitPrice is positive number
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    20
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_TH_AGENT}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_3}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_3}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_3}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_3}    ${R_X_ROLES_NS_3}
    ...    ${R_HTTP_POST}

PO_API_086_[unitPrice][agent] can create if unitPrice is Zero
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_TH_AGENT}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_3}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_3}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_3}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_3}    ${R_X_ROLES_NS_3}
    ...    ${R_HTTP_POST}

PO_API_087_[unitPrice][agent] can't create if unitPrice is empty
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    ${EMPTY}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_TH_AGENT}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_3}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_3}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_3}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_3}    ${R_X_ROLES_NS_3}
    ...    ${R_HTTP_POST}

PO_API_088_[unitPrice][agent] can create if delete field
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    "taxRate": "10",    "taxRate": "10"
    ${G_REQUEST_BODY}    Remove String    ${G_REQUEST_BODY}    "unitPrice": VAR_ITEM_UNIT_PRICE_1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007_TH_AGENT}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_3}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_3}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_3}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_3}    ${R_X_ROLES_NS_3}
    ...    ${R_HTTP_POST}

PO_API_089_[unitPrice][principle] can create if unitPrice length <=9
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    12345
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_090_[unitPrice][principle] can create if unitPrice has decimal(length) <=5
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15.12345
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_091_[unitPrice][principle] can create if unitPrice is positive number length <= 9
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    123456789
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_092_[unitPrice][principle] can create if unitPrice is Zero
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_093_[unitPrice][principle] can't create if unitPrice length > 9
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    1234567890
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_094_[unitPrice][agent] can't create if unitPrice is negative number
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    -123456789
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_095_[unitPrice][principle] can't create if unitPrice is decimal > 5
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    123456789.123456
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_096_[unitPrice][principle] can't create if unitPrice is negative number
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    -15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_099_[unitPrice][principle] can't create if unitPrice is negative number
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    -10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_100_[unitPrice][principle] can create if unitPrice is Zero
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_201_OK}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_101_[qty] can't create if qty length > 9
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    1234567890
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_102_[qty] can create if qty is negative number
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    -15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}

PO_API_103_[qty] can't create if qty has decimal
    Comment    ******create PO By API *****
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    0
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_po_id_gen}=    Set Variable    API_${random}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_PARTNER_ITEM_ID_1    ${R_ITEM_XXX_G_FIFO_007}
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${R_SUPPLIER_NS_6}
    log    ${request_body}
    #####    Send Http request    #####
    ${R_PATH_PO}    Replace String    ${R_PATH_PO}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create po    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ORDERSTORE}    ${R_PATH_PO}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}
