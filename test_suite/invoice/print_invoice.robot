*** Settings ***
# Test Teardown     Teardown item master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
TC001
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    # Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_200_OK}
    # # Verify Item Service on portal    ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${getdate}
    ######   Login to NS
    ${R_NS_URL}=  Set Variable    https://system.na2.netsuite.com/app/site/hosting/scriptlet.nl?script=285&deploy=1&compid=3686224&opt=inv&data=99832978&whence=
    Open browser    ${R_NS_URL}    gc
    # Set open browser    ${R_NS_URL}
    Maximize Browser Window
    Sleep    3s
    Input text    xpath=//*[@id="loginForm"]/table/tbody/tr[2]/td/table/tbody/tr[1]/td/table/tbody/tr/td/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[1]/td[2]/input   nattapol.wilarat@acommerce.asia
    Input password    xpath=//*[@id="password"]    S0laris10!
    Click element    xpath=//*[@id="submitter"]
    Sleep    3s
    ${question}=    Get Text    ${R_NS_XPATH_QUESTION}
    Run Keyword If    "${question }"=="What is your maternal grandmother's maiden name?"    Input password    ${R_NS_XPATH_ANSWER}    name1234
    Run Keyword If    "${question }"=="What was your childhood nickname?"    Input password    ${R_NS_XPATH_ANSWER}    nickname1234
    Run Keyword If    "${question }"== "In what city did you meet your spouse/significant other?"    Input password    ${R_NS_XPATH_ANSWER}   other1234
    Run Keyword If    "${question }"== "What is your oldest sibling's middle name?"    Input password    ${R_NS_XPATH_ANSWER}    name1234
    Run Keyword If    "${question }"== "In what city or town was your first job?"    Input password    ${R_NS_XPATH_ANSWER}    job1234
    Click element    ${R_NS_XPATH_ANSWER_SUBMIT}
    Sleep    3s
    Click elemnet     xpath=/html/body/div/table/tbody/tr[1]/td[3]/a
    # Click element    xpath=/html/body/div/table/tbody/tr[1]/td[3]/a
    # Sleep    2s
    # Select Window    print-preview
    # Click button    xpath=//*[@id="print-header"]/div/button[2]
