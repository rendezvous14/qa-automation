*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = admindev
Resource          ../resource/resource_idp_user.robot

*** Test Cases ***
2. Verify User role = SMGR can access Reporting Services successfully
  Login Platform    ${ADMINDEV_URL}   ${REPORTING_SERVICES}    ${USER_SMGR}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser
