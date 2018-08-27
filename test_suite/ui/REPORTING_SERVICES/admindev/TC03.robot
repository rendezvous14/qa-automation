*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = admindev
Resource          ../resource/resource_idp_user.robot

*** Test Cases ***
3. Verify User role = PURC can access Reporting Services successfully
  Login Platform    ${ADMINDEV_URL}   ${REPORTING_SERVICES}    ${USER_PURC}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser
