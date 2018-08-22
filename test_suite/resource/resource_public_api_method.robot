*** Settings ***
Library           HttpLibrary.HTTP
Library           OperatingSystem
Library           DateTime
Library           String

*** Variables ***

*** Keywords ***
GET Public API
    [Arguments]   ${SCHEME}  ${HOST}  ${URL}   ${expected_message}  ${expected_response}
    ##### HTTP Request
    Create Http Context   ${HOST}    ${SCHEME}
    Set Request Header    Accept     ${CONTENT_TYPE}
    Next Request May Not Succeed
    GET                  ${URL}
    ${response_msg}=    Get Response Status
    Log   ${response_msg}
    Run Keyword If   '${expected_response}'=='${STATUS_200}'   Run Keywords
    ...    Response Status Code Should Equal	${expected_response}
    ...    AND   
    ...    Response Body Should Contain   ${expected_message} 
    Run Keyword If   '${expected_response}'=='${STATUS_302}'    Run Keywords
    ...    Response Status Code Should Equal	${expected_response}
    ...    AND
    ...    Follow Response
    ...    AND  
    ...    Response Body Should Contain   ${expected_message} 
    Run Keyword If   '${expected_response}'=='${STATUS_404}'    Run Keywords
    ...    Response Status Code Should Equal	${expected_response}
    ...    AND
    ...    Response Body Should Contain   ${expected_message} 

Request Public API for Document   
    [Arguments]   ${foKey}   ${expected_message}  ${expected_response}  
    ##### Prepare Request path
    ${DOCUMENT_PATH}=  Replace String   ${DOCUMENT_PATH}   <FO_KEY>   ${foKey}
    Log   ${DOCUMENT_PATH}
    Log   ${PUBLIC_API_DOC_URL}
    GET Public API   http   ${PUBLIC_API_DOC_URL}   ${DOCUMENT_PATH}   ${expected_message}  ${expected_response}




