*** Settings ***
Resource          All_global_library.robot
Resource          global_resource_testdata_template.robot
Resource          global_resource_api.robot
Resource          global_resource_selenium.robot
Resource          global_resource_metadata.robot
Resource          global_resource_portal.robot

*** Variables ***
${R_WE_SUPPLIER_IMPORT_BUTTON}    //*[@id="import_button"]
${R_WE_SUPPLIER_LIST_ROW_1_COL_1}    //*[@id="tbody_item"]/tr[1]/td[1]/a
${R_WE_SUPPLIER_LIST_ROW_1_COL_2}    //*[@id="tbody_item"]/tr[1]/td[2]/a
${R_WE_SUPPLIER_LIST_ROW_1_COL_3}    //*[@id="tbody_item"]/tr[1]/td[3]/a
${R_WE_SUPPLIER_LIST_ROW_1_COL_4}    //*[@id="tbody_item"]/tr[1]/td[4]/a
${R_WE_SUPPLIER_LIST_ROW_1_COL_5}    //*[@id="tbody_item"]/tr[1]/td[5]/a
${R_WE_SUPPLIER_LIST_ROW_1_COL_6}    //*[@id="tbody_item"]/tr[1]/td[6]/a
${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_1}    //*[@id="element_list"]/tbody/tr[1]/td[1]/a
${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_2}    //*[@id="element_list"]/tbody/tr[1]/td[2]/div/div[2]/a
${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_3}    //*[@id="element_list"]/tbody/tr[1]/td[3]/a
${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_4}    //*[@id="element_list"]/tbody/tr[1]/td[4]/a
${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_5}    //*[@id="element_list"]/tbody/tr[1]/td[5]/a
${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_6}    //*[@id="element_list"]/tbody/tr[1]/td[6]/a
${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_7}    //*[@id="element_list"]/tbody/tr[1]/td[7]/a
${R_WE_SUPPLIER_DETAIL_SUPPLIER_NAME}    //*[@id="main-container"]/app-root/div/supplier-detail/div[1]/div[2]/h3/span
${R_WE_SUPPLIER_DETAIL_SUPPLIER_ID}    //*[@id="main-container"]/app-root/div/supplier-detail/div[2]/div[1]/div[1]/div[2]
${R_WE_SUPPLIER_DETAIL_SUPPLIER_PARTNER}    //*[@id="main-container"]/app-root/div/supplier-detail/div[2]/div[1]/div[2]/div[2]
${R_WE_SUPPLIER_DETAIL_SUPPLIER_CURRENCY}    //*[@id="main-container"]/app-root/div/supplier-detail/div[2]/div[1]/div[3]/div[2]
${R_WE_SUPPLIER_DETAIL_SUPPLIER_DATE_CREATED}    //*[@id="main-container"]/app-root/div/supplier-detail/div[2]/div[1]/div[3]/div[2]
${R_WE_SUPPLIER_DETAIL_SUPPLIER_LAST_MODIFIED}    //*[@id="main-container"]/app-root/div/supplier-detail/div[2]/div[1]/div[5]/div[2]
${R_WE_SUPPLIER_DETAIL_SUPPLIER_UPDATE_BY}    //*[@id="main-container"]/app-root/div/supplier-detail/div[2]/div[2]/div[1]/div[2]
${R_WE_SUPPLIER_DETAIL_SUPPLIER_DEFAULT}    //*[@id="main-container"]/app-root/div/supplier-detail/div[2]/div[2]/div[2]/div[2]

*** Keywords ***
Create_supplier
    [Arguments]    ${request_body}    ${expected_result}    ${endpoint_sup}    ${path}    ${partner_id}    ${x_roles}
    ...    ${http_method}
    ${response}=    HttpRequest    ${request_body}    ${expected_result}    ${endpoint_sup}    ${path}    ${partner_id}
    ...    ${x_roles}    ${http_method}
    log    ${response}
    [Return]    ${response}

Teardown supplier method
    Close all browsers
    Sleep    ${R_SLEEP_1_S}
    Remove File    ${R_TEST_DATA_SUPPLIER_GENERATE}*.*

Supplier drop file and verify import history
    [Arguments]    ${supplier_list_path}    ${supplier_import_hist_path}    ${csv_file}    ${error_message}    ${start_date}    ${update_date}
    ...    ${import_by}    ${status}
    Login to admin    ${supplier_list_path}
    log    ${EXECDIR}${/}${R_TEST_DATA_SUPPLIER_GENERATE}${csv_file}
    Choose File    ${R_WE_SUPPLIER_IMPORT_BUTTON}    ${EXECDIR}${/}${R_TEST_DATA_SUPPLIER_GENERATE}${csv_file}
    Sleep    ${R_SLEEP_15_S}
    Go To    ${supplier_import_hist_path}
    Element Text Should Be    ${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_1}    Drop File
    Element Text Should Be    ${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_2}    ${csv_file}
    Element Text Should Be    ${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_3}    ${error_message}
    Element Text Should Be    ${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_6}    ${import_by}
    Element Text Should Be    ${R_WE_SUPPLIER_IMPORT_HIST_ROW_1_COL_7}    ${status}
