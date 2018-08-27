*** Settings ***
Library           ExtendedSelenium2Library
Resource          global_resource.robot

*** Variables ***
####### id
${SideBar}        xpath=/html/body/div[3]/div[1]/ul/li[1]/div
${Dashboard}      id=dashboard-0
${Import}         id=import-7
${Import_AllImportHistory}      id=all-import-history-7-0
####### locator
${Import_locator}         xpath=//*[@id="import-7"]/a/span
${Import_AllImportHistory_locator}      xpath=//*[@id="all-import-history-7-0"]/span
####### File Importer Locator
${advanced_search_menu}       xpath=//*[@id="main-container"]/div/div[2]/div/div[1]/quick-search/div/form/div[2]/div[2]/div/a
${import_file_button}         xpath=//*[@id="main-container"]/div/div[2]/div/div[1]/quick-search/div/form/div[2]/div[4]/div/button
${search_button}              xpath=//*[@id="main-container"]/div/div[2]/div/div[1]/quick-search/div/form/div[2]/div[1]/div/div/div/span/button
####### Partner List dropdown
${partner_dropdown_list}        xpath=//*[@id="file-import-modal"]/div/div/div[2]/div[1]/div/div/div/button
${partner_dropdown_inputtext}   xpath=//*[@id="file-import-modal"]/div/div/div[2]/div[1]/div/div/div/div/div/input
####### Import File dropdown options
${import_file_type_locator}     xpath=//*[@id="file-import-modal"]/div/div/div[2]/div[2]/div/div/div/button
####### List table
${file_importer_table}              css=div.history-table.table-responsive > table
####### Pop-up file import window
${upload_button}     xpath=//*[@id="file-import-modal"]/div/div/div[3]/button[1]

####### Partner Name for testing
${partner_fulfillment}    demo automate 1
${partner_dropship}       demo automate 2
${partner_hybrid}         demo automate 3

####### Test data
${file_importer_ui_home}   ${EXECDIR}/automation/PLATFORM/FILES_IMPORTER_UI/Testdata/
${test_item_001}           Item_demo_automate_1_001.csv
${test_po_001}             PO_demo_automate_1_001.csv
${test_so_001}             SO_demo_automate_1_001.csv


*** Keywords ***
Login Portal
    [Arguments]    ${username}
    Comment    ${domain}    Set Variable    ${ADMIN_DEV}
    Open Browser    ${domain}    gc
    Maximize Browser Window
    Page Should Contain    Login to aCommerce Management Portal  20
    Input Text    name=username    ${username}
    Input Password    name=password    ${automation_password}
    Click Button    xpath=/html/body/div[2]/form/div[3]/button

Access Denied
    Wait Until Page Contains Element    xpath=/html/body/div/div/div
    Element Text Should Be    xpath=/html/body/div/div/div    Oops, You don't have the right access to the Domain!
    Element Text Should Be    xpath=/html/body/div/div/h1    403

URL should be
    [Arguments]    ${url}
    ${url}=    Catenate    SEPARATOR=    ${domain}    ${url}
    Log    ${url}
    Location Should Be    ${url}

URL should contain
    [Arguments]    ${url}
    ${url}=    Catenate    SEPARATOR=    ${domain}    ${url}
    Log    ${url}
    Location Should Contain    ${url}

Logout Portal and close browser
    Go To    ${domain}/user/Logout/
    Close Browser

Click side bar
    Wait Until Page Contains Element    xpath=/html/body/div[3]/div[1]/ul/li[1]/div    10
    Click Element    ${SideBar}

Validate Import menu
    [Arguments]    ${isImport History}
    Click side bar
    Element Text Should Be    ${Import_locator}    Import
    Click Element    ${Import_locator}
    Run Keyword If    '${isImport History}'=='true'    Run Keywords    Element Text Should Be    ${Import_ImportHistory_locator}    Import History
    ...    AND    Click Element    ${Import_ImportHistory_locator}
    ...    AND    URL should contain    /filesimporterui/frontend/
    ...    AND    Wait Until Page Contains     All Import History    10

Go File Importer UI and Import file
    [Arguments]   ${login_role}   ${partnerName}   ${fileType}  ${importedFile}  ${status}
    Login Portal    ${login_role}
    Go File Importer UI
    Ensure File Importer button is enable for importing
    Import File  ${fileType}  ${partnerName}  ${importedFile}
    Get Imported File status   ${EMPTY}   ${partnerName}   ${fileType}   Drop File   ${importedFile}   ${login_role}   ${status}

Go File Importer UI
    Click side bar
    Page Should Contain Element    ${Import}
    Page Should Contain Element    ${Import_AllImportHistory}
    Click Element   ${Import_locator}
    Click Element   ${Import_AllImportHistory_locator}
    Page Should Contain Element   ${advanced_search_menu}   20
    Maximize Browser Window

Select Partner
    [Arguments]  ${partnerName}
    Click Element   ${partner_dropdown_list}
    Input Text      ${partner_dropdown_inputtext}   ${partnerName}
    Press Key       ${partner_dropdown_inputtext}   \\13

Select File Type
    [Arguments]  ${fileType}
    Wait Until Angular Ready   5s
    Click Element   ${import_file_type_locator}
    ${fileType}=  Set Variable If
    ...      "${fileType}" == "Please Select File Type..."              1
    ...      "${fileType}" == "Item"              2
    ...      "${fileType}" == "Purchase Order"    3
    ...      "${fileType}" == "Sales Order"       4
    ...      "${fileType}" == "Shipping Order"    5
    Click Element  xpath=//*[@id="file-import-modal"]/div/div/div[2]/div[2]/div/div/div/div/ul/li[${fileType}]/a/span[1]

Ensure File Importer button is enable for importing
    [Arguments]
    Wait Until Angular Ready   30s
    Page Should Contain Element    ${import_file_button}    5
    Element Should Be Enabled    ${import_file_button}

Import File
    [Arguments]  ${fileType}  ${partnerName}  ${importedFile}
    Click Element    ${import_file_button}
    Page Should Contain Element    ${partner_dropdown_list}  10s
    Select Partner    ${partnerName}
    Select File Type  ${fileType}
    #### Select File on Pop-up windows
    Log    ${file_importer_ui_home}${importedFile}
    Choose File      xpath=//input[@type='file']    ${file_importer_ui_home}${importedFile}
    Click Element    ${upload_button}
    Page Should Contain Element   ${file_importer_table}

Get Imported File status
    [Arguments]    ${Error}   ${partnerName}   ${fileType}   ${source}   ${importedFile}   ${login_role}  ${status}
    Page Should Contain Element   ${file_importer_table}
    Table Cell Should Contain   ${file_importer_table}   2   3    ${Error}
    Table Cell Should Contain   ${file_importer_table}   2   4    ${partnerName}
    Table Cell Should Contain   ${file_importer_table}   2   5    ${fileType}
    Table Cell Should Contain   ${file_importer_table}   2   6    ${source}
    Table Cell Should Contain   ${file_importer_table}   2   7    ${importedFile}
    Table Cell Should Contain   ${file_importer_table}   2   9    ${login_role}
    Click Element    ${search_button}
    Wait Until Keyword Succeeds    2x  5s  Run Keywords
    ...   Click Element   ${search_button}
    ...   AND   Table Cell Should Contain   ${file_importer_table}   2   10   ${status}
