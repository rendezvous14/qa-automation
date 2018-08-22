*** Settings ***
Documentation     Netsuite
# Resource          test_suite/resource/group_vars/${env}/global_resource.robot
Resource          ../test_suite/resource/global_resource_netsuite.robot
# Resource          .../test_suite/resource/global_resource_metadata.robot
# Resource          .../test_suite/resource/All_global_library.robot
Library    ExtendedSelenium2Library

*** Test Cases ***
NS_01
    ${isFirstReceive}   Set Variable   true
    ${want_to_close}    Set Variable   false
    ${qty}              Set Variable   10
    ${lot_number}       Set Variable   201201010
    ${line_number}      Set Variable   1
    Login to NS
    Input Text    //*[@id="_searchstring"]   UI_20180420_123317
    Sleep   5s
    Press Key     //*[@id="_searchstring"]    \\13
    Wait Until Page Contains Element    //*[@id="row0"]/td[1]/a[2]    timeout=30s
    Click Element    //*[@id="row0"]/td[1]/a[2]
    Sleep   5s
    Run Keyword If    '${isFirstReceive}'=='true'    Element Text Should Be    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[4]/div[3]    PENDING RECEIPT
    Run Keyword If    '${isFirstReceive}'=='false'    Element Text Should Be    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[4]/div[3]    ${expected_status}
    Wait Until Page Contains Element    //*[@id="receive"]    timeout=30s
    Click Element    //*[@id="receive"]
    Wait Until Page Contains Element    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[4]/div[1]    timeout=30s
    ${item_receipt_id}=    Get Text    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[4]/div[1]
    Wait Until Page Contains Element    //*[@id="quantity1_formattedValue"]    timeout=30s
    Run Keyword If    '${want_to_close}'=='false'    Input Text    //*[@id="quantity1_formattedValue"]    ${qty}
    Wait Until Page Contains Element    //*[@id="inventorydetail_helper_popup_${line_number}"]    timeout=30s
    Click Element    //*[@id="inventorydetail_helper_popup_1"]

    # Wait Until Page Contains Element    xpath=//*[@id="childdrecord_frame"] timeout=30s
    Wait Until Page Contains Element    xpath=//*[@id="childdrecord_frame"] timeout=30s
    Select Frame    xpath=//div[@class='x-window-mc']/iframe/
    Sleep   5s
    Click Element    xpath=//*[@id="receiptinventorynumber"]
    Input Text    xpath=//*[@id="receiptinventorynumber"]  ${lot_number}

    Wait Until Page Contains Element    //*[@id="inventoryassignment_splits"]/tbody/tr[2]/td[4]/div    timeout=30s
    Click Element    //*[@id="inventoryassignment_splits"]/tbody/tr[2]/td[4]/div
    Wait Until Page Contains Element    //*[@id="inventoryassignment_form"]    timeout=30s
    Double Click Element    //*[@id="inventoryassignment_form"]
    Wait Until Page Contains Element    //*[@id="inventoryassignment_splits"]/tbody/tr[2]/td[2]/div    timeout=30s
    Click Element    //*[@id="inventoryassignment_splits"]/tbody/tr[2]/td[2]/div
    Wait Until Page Contains Element    //*[@id="inpt_binnumber1"]    timeout=30s
    Click Element    //*[@id="inpt_binnumber1"]
    Wait Until Page Contains Element    //*[@id="nl2"]    timeout=30s
    Click Element    //*[@id="nl2"]
    Wait Until Page Contains Element    //*[@id="inventoryassignment_splits"]/tbody/tr[2]/td[4]/div    timeout=30s
    Click Element    //*[@id="inventoryassignment_splits"]/tbody/tr[2]/td[4]/div
    Wait Until Page Contains Element    //*[@id="quantity_formattedValue"]    timeout=30s
    Input Text    //*[@id="quantity_formattedValue"]    ${qty}
    Wait Until Page Contains Element    //*[@id="inventoryassignment_addedit"]    timeout=30s
    Click Element    //*[@id="inventoryassignment_addedit"]
    Wait Until Page Contains Element    //*[@id="secondaryok"]    timeout=30s
    Click Element    //*[@id="secondaryok"]
    Wait Until Page Contains Element    //*[@id="btn_secondarymultibutton_submitter"]    timeout=30s
    Click Element    //*[@id="btn_secondarymultibutton_submitter"]
    sleep    3s


*** Keywords ***
