*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = admindev
Resource          ../resource/resource_idp_user.robot

*** Test Cases ***
# Access Denied
17. Verify User role = PADM cannot access Reporting Services
  Login Platform    ${ADMINDEV_URL}   ${REPORTING_SERVICES}    ${USER_PADM}
  Access Denied to Reporting Services
  [Teardown]  close browser