*** Settings ***
Documentation     To verify the navigator bar is controlled by login user role
...               Domain: ${domain}
Test Teardown     Logout Portal and close browser
Resource          ../Resource/global_resource.robot
Resource          ../Resource/NAVBAR_ADMIN.robot

*** Variables ***
${domain}         ${ADMIN_PROD}
${login_role}     ${PADM}

*** Test Cases ***
PADM role
    [Tags]    External role
    Login IDP    ${login_role}
    Access Denied
