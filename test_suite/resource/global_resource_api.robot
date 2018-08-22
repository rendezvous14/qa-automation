*** Variables ***
${R_USER_NAME_API}    ${CONFIG_USER_NAME_API}
${R_CONTENT_TYPE}    ${CONFIG_CONTENT_TYPE}
${R_X_ROLES_NS_1}    ${CONFIG_X_ROLES_NS_1}
${R_X_ROLES_NS_2}    ${CONFIG_X_ROLES_NS_2}
${R_X_ROLES_NS_3}    ${CONFIG_X_ROLES_NS_3}
${R_X_ROLES_NS_4}    ${CONFIG_X_ROLES_NS_4}
${R_X_ROLES_NS_5}    ${CONFIG_X_ROLES_NS_5}
${R_X_ROLES_NS_6}    ${CONFIG_X_ROLES_NS_6}
${R_X_ROLES_SC_1}    ${CONFIG_X_ROLES_SC_1}
${R_PARTNER_ID_NS_1}    ${CONFIG_PARTNER_ID_NS_1}
${R_PARTNER_ID_NS_2}    ${CONFIG_PARTNER_ID_NS_2}
${R_PARTNER_ID_NS_3}    ${CONFIG_PARTNER_ID_NS_3}
${R_PARTNER_ID_NS_4}    ${CONFIG_PARTNER_ID_NS_4}
${R_PARTNER_ID_NS_5}    ${CONFIG_PARTNER_ID_NS_5}
${R_PARTNER_ID_NS_6}    ${CONFIG_PARTNER_ID_NS_6}
${R_PARTNER_ID_SC_1}    ${CONFIG_PARTNER_ID_SC_1}
${R_PARTNER_NAME_NS_1}    ${CONFIG_PARTNER_NAME_NS_1}
${R_PARTNER_NAME_NS_2}    ${CONFIG_PARTNER_NAME_NS_2}
${R_PARTNER_NAME_NS_3}    ${CONFIG_PARTNER_NAME_NS_3}
${R_PARTNER_NAME_NS_4}    ${CONFIG_PARTNER_NAME_NS_4}
${R_PARTNER_NAME_NS_5}    ${CONFIG_PARTNER_NAME_NS_5}
${R_PARTNER_NAME_NS_6}    ${CONFIG_PARTNER_NAME_NS_6}
${R_PARTNER_NAME_SC_1}    ${CONFIG_PARTNER_NAME_SC_1}
##### Sales Order : partnerName = BH_AUTOMATION_SO_2
# ${R_X_ROLES_SCALE_2}              ${CONFIG_X_ROLES_SCALE_2}
# ${R_PARTNER_ID_SCALE_2}           ${CONFIG_PARTNER_ID_SCALE_2}
# ${R_PARTNER_NAME_SCALE_2}         ${CONFIG_PARTNER_NAME_SCALE_2}
# ${R_PARTNER_PREFIX_SCALE_2}       ${CONFIG_PARTNER_PREFIX_SCALE_2}
# ${R_PARTNER_SLUG_SCALE_2}         ${CONFIG_PARTNER_SLUG_SCALE_2}
# ${R_SO_SCALE_SALE_CH_ID_2}        ${CONFIG_SO_SCALE_SALE_CH_ID_2}
# ${R_SO_SCALE_SALE_SUB_CH_NAME_2}        ${CONFIG_SO_SCALE_SALE_SUB_CH_NAME_2}
# ${R_SO_SCALE_SALE_CH_TYPE_2}            ${CONFIG_SO_SCALE_SALE_CH_TYPE_2}
# ${R_SO_SCALE_CUSTOMER_TAX_ID_2}         ${CONFIG_SO_SCALE_CUSTOMER_TAX_ID_2}
# ${R_SO_SCALE_CUSTOMER_TAX_TYPE_2}       ${CONFIG_SO_SCALE_CUSTOMER_TAX_TYPE_2}
# ${R_SO_SCALE_CUSTOMER_BRANCH_CODE_2}    ${CONFIG_SO_SCALE_CUSTOMER_BRANCH_CODE_2}
# ${R_SUPPLIER_SCALE_2}                  ${CONFIG_SUPPLIER_SCALE_2}
# ${R_SUPPLIER_SCALE_2_KEY}              ${CONFIG_SUPPLIER_SCALE_2_KEY}
# ${R_SUPPLIER_CODE_SCALE_2}             ${CONFIG_SUPPLIER_CODE_SCALE_2}
# ${R_PATH_SO_UPDATE_NON_GL}             ${CONFIG_PATH_SO_UPDATE_NON_GL}

*** Keywords ***
HttpRequest
    [Arguments]    ${request_body}    ${expected_status_code}    ${endpoint}    ${path}    ${partner_id}    ${x_roles}    ${method}=POST
    log    ${endpoint}
    log    ${path}
    log    ${x_roles}
    Create Http Context    ${endpoint}    http
    Set Request Header    Content-Type    ${R_CONTENT_TYPE}
    Set Request Header    X-User-Name    ${R_USER_NAME_API}
    Set Request Header    X-Roles    ${x_roles}
    Run Keyword If    '${method}'=='POST'    Set Request Body    ${request_body}
    Run Keyword If    '${method}'=='PUT'    Set Request Body            ${request_body}
    HttpLibrary.HTTP.Next Request May Not Succeed
    Run Keyword If    '${method}'=='GET'    GET    ${path}
    Run Keyword If    '${method}'=='POST'    POST    ${path}
    Run Keyword If    '${method}'=='PUT'    PUT    ${path}
    Response Status Code Should Equal    ${expected_status_code}
    ${response}=    HttpLibrary.HTTP.Get Response Body
    Sleep   1.5s
    [Return]    ${response}
