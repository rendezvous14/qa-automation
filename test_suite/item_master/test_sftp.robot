*** Settings ***
Test Teardown     Teardown item master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
ITEM_SFTP_001
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    ${request_body_except_partner_item_id}=    Set Variable    ${request_body}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body_except_partner_item_id}    Replace String    ${request_body_except_partner_item_id}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}_12345678901234567890123456789012345678901234567890
    log    ${request_body}
    log    ${request_body_except_partner_item_id}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_fail.csv    ${request_body_except_partner_item_id}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    put_file_from_local_to_sftp_server    ${R_SFTP_HOST}    ${EXECDIR}${/}${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${R_SFTP_USERNAME}    ${R_SFTP_PWD}    ${R_SFTP_ITEM_PATH_NS_6}
    put_file_from_local_to_sftp_server    ${R_SFTP_HOST}    ${EXECDIR}${/}${R_TEST_DATA_ITEM_GENERATE}create_fail.csv    ${R_SFTP_USERNAME}    ${R_SFTP_PWD}    ${R_SFTP_ITEM_PATH_NS_6}
    Sleep    ${R_SLEEP_6_M}
    #####    Check item on portal    #####
    Login to admin    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_12345678901234567890123456789012345678901234567890
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_NO_ITEMS}    No items.
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    APP_SFTP    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005
