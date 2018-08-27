*** Settings ***
Documentation     To verify the File Importer is controlled by login user role on
...               Domain: ${domain}
Test Teardown     Logout Portal and close browser
Library           ExtendedSelenium2Library
Resource          Resource/global_resource.robot
Resource          Resource/resource_portal_ui.robot

*** Variables ***
${domain}         ${ADMIN_TEST}
${login_role}     ${ADM}

*** Test Cases ***
TC001
    [Documentation]    *Ensure that user with roles ADM will be able to see Item menu and be able to import file
    ...    when selcted Partner type is Fulfillment partner*
    [Tags]    ADM    ITEM    FULFILLMENT
    Go File Importer UI and Import file    ${login_role}    ${partner_fulfillment}    Item    ${test_item_001}    Failed

TC002
    [Documentation]    *Ensure that user with roles ADM will be able to see Purchase Order menu and be able to import file
    ...    when selcted Partner type is Fulfillment partner*
    [Tags]    ADM    PO    FULFILLMENT
    Go File Importer UI and Import file    ${login_role}    ${partner_fulfillment}    Purchase Order    ${test_po_001}    Completed

TC003
    [Documentation]    *Ensure that user with roles ADM will be able to see Sales Order menu and be able to import file
    ...    when selcted Partner type is Fulfillment partner*
    [Tags]    ADM    SO    FULFILLMENT
    # Go File Importer UI and Import file    ${login_role}    ${partner_fulfillment}    Sales Order    ${test_so_001}    Completed
