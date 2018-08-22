*** Settings ***
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
BEEH-1016 File status won't be completed when drop file to update Supplier
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${date}=    Get Current Date    result_format=%Y-%m-%d
    ${supplier_name}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_SUPPLIER_FALSE_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_NAME    ${supplier_name}
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT_NAME    CREATE_CONTACT
    log    ${request_body}
    Create File    ${R_TEST_DATA_SUPPLIER_GENERATE}create_supplier_${supplier_name}.csv    ${request_body}
    ${R_SUPPLIER_LIST}    Replace String    ${R_SUPPLIER_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_SUPPLIER}    Replace String    ${R_IMPORT_HIST_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Supplier drop file and verify import history    ${R_SUPPLIER_LIST}    ${R_IMPORT_HIST_SUPPLIER}    create_supplier_${supplier_name}.csv    ${EMPTY}    ${date}    ${date}
    ...    ${R_USERNAME_ADMIN_PORTAL}    Completed
    Go to    ${R_SUPPLIER_LIST}
    Sleep    ${R_SLEEP_3_S}
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_1}    ${supplier_name}
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_2}    CREATE_CONTACT
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_3}    email@acommerce.asia
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_4}    123456789
    Element Should Contain    ${R_WE_SUPPLIER_LIST_ROW_1_COL_5}    ${date}
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_6}    Off
    ${request_body}    Replace String    ${request_body}    CREATE_CONTACT    UPDATE_CONTACT
    Create File    ${R_TEST_DATA_SUPPLIER_GENERATE}create_supplier_${supplier_name}_update.csv    ${request_body}
    Supplier drop file and verify import history    ${R_SUPPLIER_LIST}    ${R_IMPORT_HIST_SUPPLIER}    create_supplier_${supplier_name}_update.csv    ${EMPTY}    ${date}    ${date}
    ...    ${R_USERNAME_ADMIN_PORTAL}    Completed
    Go to    ${R_SUPPLIER_LIST}
    Sleep    ${R_SLEEP_3_S}
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_1}    ${supplier_name}
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_2}    UPDATE_CONTACT
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_3}    email@acommerce.asia
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_4}    123456789
    Element Should Contain    ${R_WE_SUPPLIER_LIST_ROW_1_COL_5}    ${date}
    Element Text Should Be    ${R_WE_SUPPLIER_LIST_ROW_1_COL_6}    Off
    [Teardown]    Close all browsers
