*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = ADMINTEST
Resource          resource/resource_idp_user.robot

*** Test Cases ***
1. Verify User role = ADM can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_ADM}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

2. Verify User role = SMGR can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_SMGR}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

3. Verify User role = PURC can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_PURC}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

5. Verify User role = CS can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_CS}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

6. Verify User role = INB can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_INB}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

7. Verify User role = OUTB can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_OUTB}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

8. Verify User role = SHP can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_SHP}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

9. Verify User role = SUP can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_SUP}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

10. Verify User role = VR can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_VR}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

11. Verify User role = RVR can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_RVR}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

12. Verify User role = ROUT can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_ROUT}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

13. Verify User role = MKT can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_MKT}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

14. Verify User role = FNZ can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_FNZ}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

15. Verify User role = HR can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_HR}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

16. Verify User role = SALE can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_SALE}
  Reporting Services Page Should Be Open
  [Teardown]  Logout Reporting Service and close browser

# Access Denied
17. Verify User role = PADM cannot access Reporting Services
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_PADM}
  Access Denied to Reporting Services
  [Teardown]  close browser

18. Verify User role = POPS cannot access Reporting Services
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}   ${USER_POPS}
  Access Denied to Reporting Services
  [Teardown]  close browser

19. Verify User role = PSHP cannot access Reporting Services
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}   ${USER_PSHP}
  Access Denied to Reporting Services
  [Teardown]  close browser

20. Verify User role = PDC cannot access Reporting Services
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}   ${USER_PDC}
  Access Denied to Reporting Services
  [Teardown]  close browser

21. Verify User role = CTVR cannot access Reporting Services
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}   ${USER_CTVR}
  Access Denied to Reporting Services
  [Teardown]  close browser

4. Verify User role = MERC can access Reporting Services successfully
  Login Platform    ${ADMINTEST_URL}   ${REPORTING_SERVICES}    ${USER_MERC}
  Access Denied to Reporting Services
  [Teardown]  close browser
