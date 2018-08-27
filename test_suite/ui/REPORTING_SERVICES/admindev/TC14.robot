*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = admindev
Resource          ../resource/resource_idp_user.robot

*** Test Cases ***

14. Verify User role = FNZ can access Reporting Services successfully
  Login Platform    ${ADMINDEV_URL}   ${REPORTING_SERVICES}    ${USER_FNZ}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

