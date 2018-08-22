*** Settings ***
Resource          All_global_library.robot
Resource          global_resource_metadata.robot
Resource          global_resource_selenium.robot

*** Variables ***
${R_USERNAME_ADMIN_PORTAL}    ${CONFIG_USERNAME_ADMIN_PORTAL}
${R_PASSWORD_ADMIN_PORTAL}    ${CONFIG_PASSWORD_ADMIN_PORTAL}
${R_USERNAME_INBOUND_PORTAL}    ${CONFIG_USERNAME_INBOUND_PORTAL}
${R_PASSWORD_INBOUND_PORTAL}    ${CONFIG_PASSWORD_INBOUND_PORTAL}
${R_USERNAME_OUTBOUND_PORTAL}    ${CONFIG_USERNAME_OUTBOUND_PORTAL}
${R_PASSWORD_OUTBOUND_PORTAL}    ${CONFIG_PASSWORD_OUTBOUND_PORTAL}
${R_USERNAME_SUPERVISOR_PORTAL}    ${CONFIG_USERNAME_SUPERVISOR_PORTAL}
${R_PASSWORD_SUPERVISOR_PORTAL}    ${CONFIG_PASSWORD_SUPERVISOR_PORTAL}
${R_INVENTORY_LIST}    ${CONFIG_INVENTORY_LIST}
${R_ITEM_SERVICE_LIST}    ${CONFIG_ITEM_SERVICE_LIST}
${R_ITEM_DISCOUNT_LIST}    ${CONFIG_ITEM_DISCOUNT_LIST}
${R_IMPORT_HIST_INVENTORY}    ${CONFIG_IMPORT_HIST_INVENTORY}
${R_SUPPLIER_LIST}    ${CONFIG_SUPPLIER_LIST}
${R_IMPORT_HIST_SUPPLIER}    ${CONFIG_IMPORT_HIST_SUPPLIER}
${R_PO_LIST}      ${CONFIG_PO_LIST}
${R_IMPORT_HIST_PO}    ${CONFIG_IMPORT_HIST_PO}
${R_SALE_ORDER_LIST}    ${CONFIG_SALE_ORDER_LIST}
${R_SALE_ORDER_DETAIL}    ${CONFIG_SALE_ORDER_DETAIL}
${R_CANCEL_SALE_ORDER}    ${CONFIG_CANCEL_SALE_ORDER}
${R_BACK_ORDER_LIST}    ${CONFIG_BACK_ORDER_LIST}
${R_WE_LOGIN_BUTTON}    xpath=/html/body/div[2]/form/div[3]/button

*** Keywords ***
Login to admin
    [Arguments]    ${url}    ${username}=${R_USER_NAME_ADMIN_PORTAL}    ${password}=${R_PASSWORD_ADMIN_PORTAL}
    Comment    open browser    ${url}    chrome
    Set open browser    ${url}
    Maximize Browser Window
    Wait Until Page Contains Element    ${R_WE_LOGIN_BUTTON}    timeout=30    error=Time out!!!
    input text    name=username    ${username}
    input password    name=password    ${password}
    Click Button    ${R_WE_LOGIN_BUTTON}
    sleep    ${R_SLEEP_5_S}

Verify Item Discount on portal
    [Arguments]    ${partner_id}  ${partner_item_id}  ${description}  ${getdate}
    #####    Check item on portal    #####
    ${R_ITEM_DISCOUNT_LIST}    Replace String    ${R_ITEM_DISCOUNT_LIST}    <CONFIG_PARTNER_ID>    ${partner_id}
    Login to admin    ${R_ITEM_DISCOUNT_LIST}
    Element Text Should Be    ${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_2}    ${description}
    Element Should Contain    ${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_3}    ${getdate}

Verify Item Service on portal
    [Arguments]    ${partner_id}  ${partner_item_id}  ${description}  ${getdate}
    #####    Check item on portal    #####
    ${R_ITEM_SERVICE_LIST}    Replace String    ${R_ITEM_SERVICE_LIST}    <CONFIG_PARTNER_ID>    ${partner_id}
    Login to admin    ${R_ITEM_SERVICE_LIST}
    Element Text Should Be    ${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_2}    ${description}
    Element Should Contain    ${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_3}    ${getdate}
