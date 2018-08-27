*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = admindev
Resource          ../resource/resource_idp_user.robot

*** Test Cases ***

21. Verify User role = CTVR cannot access Reporting Services
  Login Platform    ${ADMINDEV_URL}   ${REPORTING_SERVICES}   ${USER_CTVR}
  Access Denied to Reporting Services
  [Teardown]  close browser

