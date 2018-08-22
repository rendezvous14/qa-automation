*** Settings ***
Library           OperatingSystem
Library           SeleniumLibrary
Test Teardown     Teardown item master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
ITEM_UI_001_[partnerItemId] length not over 50 characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_002_[partnerItemId] length over 50 characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}_12345678901234567890123456789012345678901234567890
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_PARTNER_ITEM_ID_CANNOT_EXCEED_50_CHAR}

ITEM_UI_003_[partnerItemId] input special characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}_[TEST]
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_004_[partnerItemId] input other language ex. TH
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}_เทสโดยคิวเอ
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_005_[partnerItemId] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    ${EMPTY}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_empty.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_empty.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_PARTNER_ITEM_ID_CANNOT_BE_NULL}

ITEM_UI_006_[partnerItemId] delete partnerItemId field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Remove String    ${request_body}    partnerItemId,
    ${request_body}    Remove String    ${request_body}    VAR_PARTNER_ITEM_ID_1,
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Column ['partnerItemId'] is missing    ${EMPTY}

ITEM_UI_009_[upcCode] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Remove String    ${request_body}    upcCode,
    ${request_body}    Remove String    ${request_body}    VAR_UPC_CODE_1,
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    ${EMPTY}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Sleep    ${R_SLEEP_2_S}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    ${EMPTY}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    ${SPACE}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_010_[upcCode] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    ${EMPTY}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    ${EMPTY}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Sleep    ${R_SLEEP_2_S}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    ${EMPTY}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    ${SPACE}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_011_[upcCode] length not over 180 char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Comment    #####    Wait for discuss because upc length for scale max 25 chars, if config more than 25 char, on inventory list will not display
    Comment    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    ${EMPTY}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_012_[upcCode] length over 180 char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_UPCCODE_CANNOT_EXCEED_180_CHAR}

ITEM_UI_013_[upcCode] input spacial char in array of string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_[TEST]
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_[TEST]
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_[TEST]    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_[TEST]    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_014_[upcCode] updated not over 10 array of string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}_1
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}_1    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}_1    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005
    #####    Update upcCode    #####
    ${request_body}    Replace String    ${request_body}    UPC_${random}_1    UPC_${random}_2
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}_2    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}_2    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_016_[description] length not over 255 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_017_[description] length over 255 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_DESC_CANNOT_EXCEED_255_CHAR}

ITEM_UI_018_[description] input special characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script [TEST]
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script [TEST]
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script [TEST]    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script [TEST]    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_019_[description] input other language ex. TH
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    เทสสร้างโดยสคริป
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    เทสสร้างโดยสคริป
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    เทสสร้างโดยสคริป    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    เทสสร้างโดยสคริป    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_020_[description] input other language ex. Chinese
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    圆领，凸显脖子的线条美，显得精神有气质。灯笼袖的造型，上身舒适不紧绷。耀眼的银色钉珠扣袢，吸睛耀眼。
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    圆领，凸显脖子的线条美，显得精神有气质。灯笼袖的造型，上身舒适不紧绷。耀眼的银色钉珠扣袢，吸睛耀眼。
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    圆领，凸显脖子的线条美，显得精神有气质。灯笼袖的造型，上身舒适不紧绷。耀眼的银色钉珠扣袢，吸睛耀眼。    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    圆领，凸显脖子的线条美，显得精神有气质。灯笼袖的造型，上身舒适不紧绷。耀眼的银色钉珠扣袢，吸睛耀眼。    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_021_[description] input other language ex. Japanese
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    特別割引コードはチラシ裏の下部に記載があります。
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    特別割引コードはチラシ裏の下部に記載があります。
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    特別割引コードはチラシ裏の下部に記載があります。    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    特別割引コードはチラシ裏の下部に記載があります。    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_022_[description] input other language ex. Korean
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    델리모먼트 드레싱 디퓨저
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    델리모먼트 드레싱 디퓨저
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    델리모먼트 드레싱 디퓨저    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    델리모먼트 드레싱 디퓨저    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_023_[description] input data type Numeric
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    12345
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
    Go to    ${R_INVENTORY_LIST}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    12345
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    12345    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    12345    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_024_[description] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    ${EMPTY}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_DESC_FIELD_IS_REQUIRED}

ITEM_UI_025_[description] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Remove String    ${request_body}    description,
    ${request_body}    Remove String    ${request_body}    VAR_DESCRIPTION_1,
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_DESC_FIELD_IS_REQUIRED}

ITEM_UI_026_[width] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    12345678.80005
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WIDTH_VALUE}
    #####    Update width    #####
    ${request_body}    Replace String    ${request_body}    12345678.80005    1234567.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WIDTH_VALUE}
    #####    Update width    #####
    ${request_body}    Replace String    ${request_body}    1234567.800059    12345678.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WIDTH_VALUE}

ITEM_UI_027_[width] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    ten
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WIDTH_VALUE}

ITEM_UI_028_[width] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    -7.80005
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WIDTH_VALUE_NOT_LESS_THAN_0}

ITEM_UI_029_[width] can updated width
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005
    #####    Update width    #####
    ${request_body}    Replace String    ${request_body}    7.80005    7.99995
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.99995    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.99995    3.50005

ITEM_UI_030_[length] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    12345678.80005
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_LENGTH_VALUE}
    #####    Update length    #####
    ${request_body}    Replace String    ${request_body}    12345678.80005    1234567.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_LENGTH_VALUE}
    #####    Update length    #####
    ${request_body}    Replace String    ${request_body}    1234567.800059    12345678.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_LENGTH_VALUE}

ITEM_UI_031_[length] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    ten
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_LENGTH_VALUE}

ITEM_UI_032_[length] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    -5.60005
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_LENGTH_VALUE_NOT_LESS_THAN_0}

ITEM_UI_033_[length] can updated length
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005
    #####    Update length    #####
    ${request_body}    Replace String    ${request_body}    5.60005    5.99995
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.99995    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.99995    7.80005    3.50005

ITEM_UI_034_[weight] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    12345678.80005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WEIGHT_VALUE}
    #####    Update weight    #####
    ${request_body}    Replace String    ${request_body}    12345678.80005    1234567.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WEIGHT_VALUE}
    #####    Update weight    #####
    ${request_body}    Replace String    ${request_body}    1234567.800059    12345678.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WEIGHT_VALUE}

ITEM_UI_035_[weight] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    ten
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WEIGHT_VALUE}

ITEM_UI_036_[weight] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    -4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_WEIGHT_VALUE_NOT_LESS_THAN_0}

ITEM_UI_037_[height] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    12345678.80005
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_HEIGHT_VALUE}
    #####    Update height    #####
    ${request_body}    Replace String    ${request_body}    12345678.80005    1234567.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_HEIGHT_VALUE}
    #####    Update height    #####
    ${request_body}    Replace String    ${request_body}    1234567.800059    12345678.800059
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_HEIGHT_VALUE}

ITEM_UI_039_[height] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    ten
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_HEIGHT_VALUE}

ITEM_UI_040_[height] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    -3.50005
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_HEIGHT_VALUE_NOT_LESS_THAN_0}

ITEM_UI_041_[storageRequirement] input incorrect data(Cool_RoomX)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_RoomX
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_COOL_ROOMX_IS_NOT_VALID}

ITEM_UI_042_[storageRequirement] input incorrect data (Number)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    12345
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_12345_IS_NOT_VALID}

ITEM_UI_043_[storageRequirement] input blank field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    General
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    General    4.70005    5.60005    7.80005    3.50005

ITEM_UI_044_[fulfillmentPattern] input incorrect data(LILO)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    LILO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_LILO_IS_NOT_VALID}

ITEM_UI_045_[fulfillmentPattern] input incorrect data (Number)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    12345
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_12345_IS_NOT_VALID}

ITEM_UI_046_[fulfillmentPattern] input blank field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_047_[qcInformation] input over length (100.55)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    100.55
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_QC_VALUE_CANNOT_EXCEED_100}

ITEM_UI_048_[qcInformation] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    ten
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_QC_VALUE}

ITEM_UI_049_[qcInformation] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    -15
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_QC_VALUE_NOT_LESS_THAN_0}

ITEM_UI_050_[isSerialTracked] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Remove String    ${request_body}    isSerialTracked,
    ${request_body}    Remove String    ${request_body}    VAR_IS_SERIAL_TRACKED_1,
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_051_[isSerialTracked] input false
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    false
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_052_[isSerialTracked] input other word (No Boolean) : No, Yes
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    Yes
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_053_[isBatchTracked] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Remove String    ${request_body}    isBatchTracked,
    ${request_body}    Remove String    ${request_body}    VAR_IS_BATCH_TRACKED_1,
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_054_[isBatchTracked] input false
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    false
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_055_[active] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Remove String    ${request_body}    ,active
    ${request_body}    Remove String    ${request_body}    ,VAR_ACTIVE_1
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_056_[active] input other word (No Boolean) : No, Yes
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    Yes
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_057_[price] input over length (9 digits)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    123456789.12345
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_PRICES_CANNOT_EXCEED_13_DIGIT}

ITEM_UI_058_[price] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    ten
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_PRICES_CANNOT_CONVERT_TO_FLOAT}

ITEM_UI_059_[price] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    -50.25
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_PRICES_VALUE}

ITEM_UI_060_[supplierCode] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${EMPTY}
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Fail because set supplierCode is required field    #####
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_SUPPLIER_CODE_CANNOT_BE_NULL}

ITEM_UI_061_[supplierCode] deleted field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Remove String    ${request_body}    supplierCode,
    ${request_body}    Remove String    ${request_body}    VAR_SUPPLIER_CODE_1,
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
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Fail because set supplierCode is required field    #####
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    ${R_ERROR_MSG_UI_SUPPLIER_CODE_IS_MISSING}    ${R_ERROR_MSG_UI_SUPPLIER_CODE_IS_MISSING}

ITEM_UI_062_[preferred] delete_field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Remove String    ${request_body}    preferred,
    ${request_body}    Remove String    ${request_body}    VAR_PREFERRED_1,
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_063_[preferred] input false
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    false
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_064_[preferred] input other word (No Boolean) : No, Yes
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    Yes
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_065_[itemGroup] length not over 25 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group_123456789
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    Yes
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group_123456789    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_066_[itemGroup] length over 25 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group_1234567890
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    Yes
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_ITEM_GROUP_CANNOT_EXCEED_25_CHAR}

ITEM_UI_067_[itemGroup] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Remove String    ${request_body}    itemGroup,
    ${request_body}    Remove String    ${request_body}    VAR_ITEM_GROUP_1,
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    Yes
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    ${EMPTY}    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_068_[retailSellingPrice] input over length
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    9800000.500005
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    Yes
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_RSP_VALUE}
    #####    Update rsp    #####
    ${request_body}    Replace String    ${request_body}    9800000.500005    980000000000000.50005
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_RSP_VALUE_NOT_LESS_THAN_0}
    #####    Update rsp    #####
    ${request_body}    Replace String    ${request_body}    980000000000000.50005    980000000000000.500005
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_RSP_VALUE_NOT_LESS_THAN_0}

ITEM_UI_069_[retailSellingPrice] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
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
    ${request_body}    Remove String    ${request_body}    retailSellingPrice,
    ${request_body}    Remove String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1,
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    Yes
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check item on portal    #####
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
    ...    ${R_USERNAME_ADMIN_PORTAL}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    ${EMPTY}
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Search partner item id and verify    ${partner_item_id}    ${R_PARTNER_PREFIX_NS_6}    ${R_PARTNER_ID_NS_6}    UPC_${random}    Test by automation script    FIFO
    ...    Cool_Room    4.70005    5.60005    7.80005    3.50005

ITEM_UI_070_Can create two items with full fields
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body #1    #####
    ${request_body}=    Get File    ${R_TEMPLATE_TWO_ITEMS_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${partner_item_id}_1
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
    #####    Set request body #2    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_2    ${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_2    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_2    UPC_${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_2    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_2    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_2    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_2    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_2    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_2    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_2    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_2    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_2    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_2    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_2    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_2    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_2    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}_1_2.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}_1_2.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check partner item id by quick search    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_1
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_2
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0

ITEM_UI_071_Can create three items with full fields
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body #1    #####
    ${request_body}=    Get File    ${R_TEMPLATE_THREE_ITEMS_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${partner_item_id}_1
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
    #####    Set request body #2    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_2    ${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_2    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_2    UPC_${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_2    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_2    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_2    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_2    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_2    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_2    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_2    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_2    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_2    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_2    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_2    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_2    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_2    true
    #####    Set request body #3    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_3    ${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_3    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_3    UPC_${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_3    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_3    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_3    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_3    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_3    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_3    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_3    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_3    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_3    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_3    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_3    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_3    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_3    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}_1_2_3.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}_1_2_3.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Check partner item id by quick search    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_1
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_2
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_3
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_3
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_3
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0

ITEM_UI_072_Can create item with mandatory and require fields
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    50.25
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}

ITEM_UI_073_Cannot create partner item id with invalid file type
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    50.25
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.txt    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.txt    Failed    Unsupported file extension txt. The supported file extension is csv.    ${EMPTY}

ITEM_UI_074_Cannot create partner item id with thai file name
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    50.25
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}ครีเอท_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    ครีเอท_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}

ITEM_UI_075_Cannot create partner item id with japanese file name
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    50.25
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}ファイル_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    ファイル_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}

ITEM_UI_076_Cannot create partner item id with chinese file name
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    50.25
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}文件_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    文件_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}

ITEM_UI_077_Cannot create partner item id with korean file name
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    50.25
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}파일_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    파일_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}

ITEM_UI_078_Can create some valid items with full fields
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body #1    #####
    ${request_body}=    Get File    ${R_TEMPLATE_THREE_ITEMS_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${partner_item_id}_1
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
    #####    Set request body #2    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_2    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_2    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_2    UPC_${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_2    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_2    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_2    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_2    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_2    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_2    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_2    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_2    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_2    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_2    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_2    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_2    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_2    true
    #####    Set request body #3    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_3    ${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_3    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_3    UPC_${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_3    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_3    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_3    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_3    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_3    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_3    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_3    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_3    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_3    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_3    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_3    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_3    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_3    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}_1_2_3.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}_1_2_3.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_PARTNER_ITEM_ID_CANNOT_BE_NULL}
    #####    Check partner item id by quick search    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_1
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_3
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_3
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_3
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0

ITEM_UI_078_Can create some valid items with full fields
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body #1    #####
    ${request_body}=    Get File    ${R_TEMPLATE_THREE_ITEMS_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${partner_item_id}_1
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
    #####    Set request body #2    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_2    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_2    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_2    UPC_${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_2    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_2    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_2    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_2    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_2    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_2    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_2    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_2    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_2    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_2    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_2    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_2    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_2    true
    #####    Set request body #3    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_3    ${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_3    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_3    UPC_${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_3    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_3    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_3    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_3    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_3    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_3    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_3    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_3    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_3    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_3    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_3    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_3    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_3    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}_1_2_3.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}_1_2_3.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_PARTNER_ITEM_ID_CANNOT_BE_NULL}
    #####    Check partner item id by quick search    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_1
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_3
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_3
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_3
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
