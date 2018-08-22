*** Settings ***
Documentation     BEEH-4905 [Public API] Retrieve print documen
Resource          ../resource/group_vars/${env}/global_resource.robot
Resource          ../resource/resource_public_api_method.robot

*** Variables ***
${partner_id}           ${PARTNER_ID_SC_TH}
${partner_name}         ${PARTNER_NAME_SC_TH}
${partner_slug}         ${PARTNER_SLUG_SC_TH}
${partner_prefix}       ${PARTNER_PREFIX_SC_TH}

*** Test Cases ***
PUBLIC_API_DOCUMENT_01
    [Documentation]   - Fulfillment Order contain only Invoice document
    [Tags]   Public API
    comment  -------- Defined Variables --------
    comment  -------- Test Data --------
    ${foKey}=               Set Variable  RZ0X6C0YIA2QMU5KZ0L34PD11  
    ${expectedDocumentId}=  Set Variable  THIVBAT1806001838
    Log to console   "Fulfillment Order Id = ${foKey}"
    comment  -------- Request Public API --------
    Request Public API for Document   ${foKey}  ${expectedDocumentId}  ${STATUS_302}  

PUBLIC_API_DOCUMENT_02
    [Documentation]   - Fulfillment Order contain only DO document
    [Tags]   Public API
    comment  -------- Defined Variables --------
    comment  -------- Test Data --------
    ${foKey}=               Set Variable  01M1L3N1E4Y49GNYRHJL09LD1  
    ${expectedDocumentId}=  Set Variable  THDOBAT1806001839
    Log to console   "Fulfillment Order Id = ${foKey}"
    comment  -------- Request Public API --------
    Request Public API for Document   ${foKey}  ${expectedDocumentId}  ${STATUS_302}

PUBLIC_API_DOCUMENT_03
    [Documentation]   - Fulfillment Order contain Invoice and DO document
    [Tags]   Public API
    comment  -------- Defined Variables --------
    comment  -------- Test Data --------
    ${foKey}=               Set Variable  G1MBJ49YFY9QMW1S1AAGG7B6D  
    ${expectedDocumentId}=  Set Variable  THIVBAT1806001835
    Log to console   "Fulfillment Order Id = ${foKey}"
    comment  -------- Request Public API --------
    Request Public API for Document   ${foKey}  ${expectedDocumentId}  ${STATUS_302}

PUBLIC_API_DOCUMENT_04
    [Documentation]   - Fulfillment Order is cancelled
    [Tags]   Public API
    comment  -------- Defined Variables --------
    comment  -------- Test Data --------
    ${foKey}=               Set Variable  JJ6S1VLGBP1ZV1J2APCQBFBLB  
    ${expectedDocumentId}=  Set Variable  THIVBAT1806001834
    Log to console   "Fulfillment Order Id = ${foKey}"
    comment  -------- Request Public API --------
    Request Public API for Document   ${foKey}  ${expectedDocumentId}  ${STATUS_302}

PUBLIC_API_DOCUMENT_05
    [Documentation]   - Fulfillment Order is cancelled
    [Tags]   Public API
    comment  -------- Defined Variables --------
    comment  -------- Test Data --------
    ${foKey}=               Set Variable  F0HMK08V3I8868NTY2DHTPSD6  
    ${expectedDocumentId}=  Set Variable  No Document matches the id
    Log to console   "Fulfillment Order Id = ${foKey}"
    comment  -------- Request Public API --------
    Request Public API for Document   ${foKey}  ${expectedDocumentId}  ${STATUS_404}


PUBLIC_API_DOCUMENT_06
    [Documentation]   - Unknown Fulfillment Order Key
    [Tags]   Public API
    comment  -------- Defined Variables --------
    comment  -------- Test Data --------
    ${foKey}=               Set Variable  AAAXXXXIDAE9GKTRHXF8PZZZZ  
    ${expectedDocumentId}=  Set Variable  No Document matches the id
    Log to console   "Fulfillment Order Id = ${foKey}"
    comment  -------- Request Public API --------
    Request Public API for Document   ${foKey}  ${expectedDocumentId}  ${STATUS_404}

PUBLIC_API_DOCUMENT_07
    [Documentation]   - Request with empty key
    [Tags]   Public API
    comment  -------- Defined Variables --------
    comment  -------- Test Data --------
    ${foKey}=               Set Variable  ${EMPTY}  
    ${expectedDocumentId}=  Set Variable  The requested URL /document/v1/documents/ was not found on this server.
    Log to console   "Fulfillment Order Id = ${foKey}"
    comment  -------- Request Public API --------
    Request Public API for Document   ${foKey}  ${expectedDocumentId}  ${STATUS_404}

