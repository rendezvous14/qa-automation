*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = admindev
Resource          ../resource/resource_idp_user.robot

*** Test Cases ***
4. Verify User role = MERC can access Reporting Services successfully
  Login Platform    ${ADMINDEV_URL}   ${REPORTING_SERVICES}    ${USER_MERC}
  Access Denied to Reporting Services
  [Teardown]  close browser
