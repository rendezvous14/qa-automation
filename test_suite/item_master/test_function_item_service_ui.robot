*** Settings ***
Test Teardown     Teardown item master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
UI_SERVICE_001 partner_item_id length not over 50 characters
    [Documentation]   Verify item-service has been created successfully on NS and display on UI
    [Tags]   item-service
    ####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_200_OK}
    Verify Item Service on portal    ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${getdate}
    Verify Item Service on NS  ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}

UI_SERVICE_002 partner_item_id length not over 50 characters and include special character
    [Documentation]   Verify item-service has been created successfully on NS and display on UI
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_!@#$%*${random}
    ${description}=    Set Variable    DESC_SERVICE_!@#$%*${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_200_OK}
    Verify Item Service on portal    ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${getdate}
    Verify Item Service on NS  ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}

UI_SERVICE_003 partner_item_id length not over 50 characters and include space in the middle
    [Documentation]   Verify item-service has been created successfully on NS and display on UI
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE ${random}
    ${description}=    Set Variable    DESC SERVICE ${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_200_OK}
    Verify Item Service on portal    ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${getdate}
    Verify Item Service on NS  ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}

UI_SERVICE_004 partner_item_id is Thai language
    [Documentation]   partner_item_id is Thai language
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    เซอวิส_${random}
    ${description}=    Set Variable    DESC_เซอวิส_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_200_OK}
    Verify Item Service on portal    ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${getdate}
    Verify Item Service on NS  ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}

UI_SERVICE_005 Cannot be created when partner_item_id is missing
    [Documentation]   partner_item_id field is missing in body
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    "partnerItemId": "VAR_PARTNER_ITEM_ID"   ${EMPTY}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    "VAR_DESCRIPTION",        "${description}"
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}   ${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_NULL}

UI_SERVICE_006 Cannot be created when description is missing
    [Documentation]   discription field is missing
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    "description":"VAR_DESCRIPTION",        ${EMPTY}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}  ${R_ERROR_MSG_DESC_IS_REQUIRED}

UI_SERVICE_007 Cannot be created when description is missing
    [Documentation]   action field is missing
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    "action": "VAR_ACTION",   ${EMPTY}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}  ${R_ERROR_MSG_ACTION_CANNOT_BLANK}

UI_SERVICE_008 Cannot be created when body is empty
    [Documentation]   action field is missing
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    "action": "VAR_ACTION",   ${EMPTY}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    "partnerItemId": "VAR_PARTNER_ITEM_ID"   ${EMPTY}
    ${G_REQUEST_BODY}=  Replace String    ${G_REQUEST_BODY}    "description":"VAR_DESCRIPTION",        ${EMPTY}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}  ${R_ERROR_MSG_BODY_CANNOT_EMTPY}

UI_SERVICE_009 partner_item_id length is over 50 characters
    [Documentation]   partner_item_id length is over 50 characters
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}_1234567890123456789012345
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}  ${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_EXCEED}

UI_SERVICE_010 description length is over 255 characters
    [Documentation]   partner_item_id length is over 50 characters
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}_The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz.
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}  ${R_ERROR_MSG_DESC_CANNOT_EXCEED_255_CHAR}

UI_SERVICE_011 description length is not over 255 characters
    [Documentation]   partner_item_id length is over 50 characters
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}_The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived walt.
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_200_OK}
    Verify Item Service on portal    ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${getdate}
    Verify Item Service on NS  ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}

UI_SERVICE_012 partner_item_id cannot be null
    [Documentation]   partner_item_id is null
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    "partnerItemId": "VAR_PARTNER_ITEM_ID"   "partnerItemId": null
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}  ${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_NULL}

UI_SERVICE_013 description cannot be null
    [Documentation]   description is null
    [Tags]   item-service
    #####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    "description":"VAR_DESCRIPTION"   "description": null
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_400_BAD}  {"description":["This field may not be null."]}

UI_SERVICE_014 Get item-service API for all items
    [Documentation]   get all partner_item_id
    [Tags]   item-service
    ${R_PATH_ITEM_SERVICES}=    Replace String    ${R_PATH_ITEM_SERVICES}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create Http Context   ${R_ENDPOINT_ITEM}    http
    Set Request Header    Content-Type    ${R_CONTENT_TYPE}
    Set Request Header    X-User-Name    ${R_USER_NAME_API}
    Set Request Header    X-Roles    ${R_X_ROLES_NS_6}
    GET   ${R_PATH_ITEM_SERVICES}
    Next Request May Not Succeed
    Response Status Code Should Equal    ${R_EXPECTED_STATUS_200_OK}
    ${response}=     Get Response Body
    ${get_ItemId}=  Get Json Value    ${response}    /1/itemId
    ${get_partnerItemId}=  Get Json Value    ${response}    /1/partnerItemId
    ${get_partnerId}=  Get Json Value    ${response}    /1/partnerId
    ${get_type}=  Get Json Value    ${response}    /1/type
    ${get_description}=  Get Json Value    ${response}    /1/description

UI_SERVICE_015 Get item-service API for one item
    [Documentation]   get one partner_item_id
    [Tags]   item-service
    ####    Set variable    #####
    ${getdate}=    Get Current Date    result_format=%Y-%m-%d
    ${random}=     Get Current Date    result_format=%Y-%m-%d_%H%M%S
    ${partner_item_id}=    Set Variable    SERVICE_${random}
    ${description}=    Set Variable    DESC_SERVICE_${random}
    #####    Set request body #1    #####
    ${G_REQUEST_BODY}=    Get File    ${R_TEMPLATE_ITEM_SERVICE_DISCOUNT_ONE_ITEM}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_ACTION             create
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${G_REQUEST_BODY}=    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION        ${description}
    ## Keywords                    Partner_id             Partner_item_id    Description     JSON Body          Expected_status               Expected_results
    Create Item Service via API   ${R_PARTNER_ID_NS_6}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${R_EXPECTED_STATUS_200_OK}
    # Get item
    Sleep    ${R_SLEEP_10_S}
    ${R_PATH_ITEM_SERVICES}=    Replace String    ${R_PATH_ITEM_SERVICES}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Create Http Context   ${R_ENDPOINT_ITEM}    http
    Set Request Header    Content-Type    ${R_CONTENT_TYPE}
    Set Request Header    X-User-Name    ${R_USER_NAME_API}
    Set Request Header    X-Roles    ${R_X_ROLES_NS_6}
    GET   ${R_PATH_ITEM_SERVICES}${partner_item_id}/
    Next Request May Not Succeed
    Response Status Code Should Equal    ${R_EXPECTED_STATUS_200_OK}
    ${response}=     Get Response Body
    ${get_ItemId}=  Get Json Value    ${response}    /itemId
    ${get_partnerItemId}=  Get Json Value    ${response}    /partnerItemId
    ${get_partnerId}=  Get Json Value    ${response}    /partnerId
    ${get_type}=  Get Json Value    ${response}    /type
    ${get_description}=  Get Json Value    ${response}    /description
    ## Verify response
    Should Be Equal    ${get_ItemId}    "${R_PARTNER_PREFIX_NS_6}_${partner_item_id}"
    Should Be Equal    ${get_partnerItemId}   "${partner_item_id}"
    Should Be Equal    ${get_partnerId}   "${R_PARTNER_ID_NS_6}"
    Should Be Equal    ${get_type}    "Service"
    Should Be Equal    ${get_description}    "${description}"
