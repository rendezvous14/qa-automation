*** Settings ***
Documentation     Verify the reporting services integrated with platform successfully
...               Verify IDP User role can access Reporting Services
...               platform = admindev
Test Teardown     Logout Reporting Service and close browser
Resource          resource/resource_idp_user.robot
Resource          variables/variables_dev_platform.robot

*** Variables ***
${domain}         ${ADMINDEV_URL}
${MICRO_SERVICES}    ${REPORTING_SERVICES}

*** Test Cases ***
C_LEVEL
    [Documentation]    *Verify User role = C_LEVEL can access Reporting Services successfully*
    Login Platform    ${C_LEVEL}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder can be displayed    Marketing
    Sherlock folder can be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder can be displayed    Deliver
    Sherlock folder can be displayed    Operation
    Sherlock folder can be displayed    BusinessDevelopment
    Sherlock folder can be displayed    BrandCommerce

ADM
    [Documentation]    *Verify User role = ADM can access Reporting Services successfully*
    Login Platform    ${ADM}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

SMGR
    [Documentation]    *Verify User role = SMGR can access Reporting Services successfully*
    Login Platform    ${SMGR}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

PURC
    [Documentation]    *Verify User role = PURC can access Reporting Services successfully*
    Login Platform    ${PURC}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

CS
    [Documentation]    *Verify User role = CS can access Reporting Services successfully*
    Login Platform    ${CS}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

INB
    [Documentation]    *Verify User role = INB can access Reporting Services successfully*
    Login Platform    ${INB}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

OUTB
    [Documentation]    *Verify User role = OUTB can access Reporting Services successfully*
    Login Platform    ${OUTB}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

SHP
    [Documentation]    *Verify User role = SHP can access Reporting Services successfully*
    Login Platform    ${SHP}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

SUP
    [Documentation]    *Verify User role = SUP can access Reporting Services successfully*
    Login Platform    ${SUP}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

VR
    [Documentation]    *Verify User role = VR can access Reporting Services successfully*
    Login Platform    ${VR}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

RVR
    [Documentation]    *Verify User role = RVR can access Reporting Services successfully*
    Login Platform    ${RVR}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

ROUT
    [Documentation]    *Verify User role = ROUT can access Reporting Services successfully*
    Login Platform    ${ROUT}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

MKT
    [Documentation]    *Verify User role = MKT can access Reporting Services successfully*
    Login Platform    ${MKT}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder can be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

FNZ
    [Documentation]    *Verify User role = FNZ can access Reporting Services successfully*
    Login Platform    ${FNZ}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder can be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce
    # HR
    #    [Documentation]    *Verify User role = HR can access Reporting Services successfully*
    #    Login Platform    ${HR}
    #    Reporting Services Page Should Be Opened
    #    Sherlock folder can be displayed    Public
    #    Sherlock folder cannot be displayed    Marketing
    #    Sherlock folder cannot be displayed    Finance
    #    Sherlock folder can be displayed    HR
    #    Sherlock folder cannot be displayed    Deliver
    #    Sherlock folder cannot be displayed    Operation
    #    Sherlock folder cannot be displayed    BusinessDevelopment
    #    Sherlock folder cannot be displayed    BrandCommerce

SDEL
    [Documentation]    *Verify User role = SDEL can access Reporting Services successfully*
    Login Platform    ${SDEL}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder can be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

SOPS
    [Documentation]    *Verify User role = SOPS can access Reporting Services successfully*
    Login Platform    ${SOPS}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder can be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce

BCOM
    [Documentation]    *Verify User role = BCOM can access Reporting Services successfully*
    Login Platform    ${BCOM}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder cannot be displayed    BusinessDevelopment
    Sherlock folder can be displayed    BrandCommerce

SALE
    [Documentation]    *Verify User role = SALE can access Reporting Services successfully*
    Login Platform    ${SALE}
    Reporting Services Page Should Be Opened
    Sherlock folder can be displayed    Public
    Sherlock folder cannot be displayed    Marketing
    Sherlock folder cannot be displayed    Finance
    Sherlock folder cannot be displayed    HR
    Sherlock folder cannot be displayed    Deliver
    Sherlock folder cannot be displayed    Operation
    Sherlock folder can be displayed    BusinessDevelopment
    Sherlock folder cannot be displayed    BrandCommerce
    # Access Denied

PADM
    [Documentation]    *Verify User role = PADM cannot access Reporting Services*
    Login Platform    ${PADM}
    Access Denied to Reporting Services

POPS
    [Documentation]    *Verify User role = POPS cannot access Reporting Services*
    Login Platform    ${POPS}
    Access Denied to Reporting Services

PSHP
    [Documentation]    *Verify User role = PSHP cannot access Reporting Services*
    Login Platform    ${PSHP}
    Access Denied to Reporting Services

PDC
    [Documentation]    *Verify User role = PDC cannot access Reporting Services*
    Login Platform    ${PDC}
    Access Denied to Reporting Services

CTVR
    [Documentation]    *Verify User role = CTVR cannot access Reporting Services*
    Login Platform    ${CTVR}
    Access Denied to Reporting Services

MERC
    [Documentation]    *Verify User role = MERC cannot access Reporting Services*
    Login Platform    ${MERC}
    Access Denied to Reporting Services
