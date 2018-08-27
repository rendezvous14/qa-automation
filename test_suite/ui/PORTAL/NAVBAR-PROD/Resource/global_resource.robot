*** Settings ***
Library           Selenium2Library

*** Variables ***
# ${ADMIN_PROD}     https://admin.acommerce.service
${ADMIN_PROD}     https://admin.acommerce.asia
${ADMIN_DEV}     https://admindev.acommercedev.com
${PARTNER_PROD}    https://partner.acommerce.asia
${PORTAL_PROD}    https://portal.acommerce.asia
${automation_password}    Acomm1234!
# C Level role
${C_LEVEL}        qa_sherlock
# Admin role
${ADM}            qa_admin
${SHP}            qa_shp
${VR}             qa_vr
${SUP}            qa_sup
${CS}             qa_cs
${INB}            qa_inb
${OUTB}           qa_outb
${RVR}            qa_rvr
${ROUT}           qa_rout
${SALE}           qa_sale
${MKT}            qa_mkt
${FNZ}            qa_fnz
${HR}             qa_hr
${SMGR}           qa_smgr
${PURC}           qa_purc
# New Sherlock Users
${BCOM}           qa_bcom
${SOPS}           qa_sops
${SDEL}           qa_sdel
# Partner role
${PADM}           qa_padm
${POPS}           qa_pops
${PSHP}           qa_pshp
${PDC}            qa_pdc
${CTVR}           qa_ctvr
${MERC}           qa_merc

*** Keywords ***
Login IDP
    [Arguments]    ${username}
    Comment    ${domain}    Set Variable    ${ADMIN_DEV}
    Open Browser    ${domain}    gc
    Maximize Browser Window
    Page Should Contain    Login to aCommerce Management Portal  20
    Input Text    name=username    ${username}
    Input Password    name=password    ${automation_password}
    Click Button    xpath=/html/body/div[2]/form/div[3]/button

Access Denied
    Wait Until Page Contains Element    xpath=/html/body/div/div/div
    Element Text Should Be    xpath=/html/body/div/div/div    Oops, You don't have the right access to the Domain!
    Element Text Should Be    xpath=/html/body/div/div/h1    403

URL should be
    [Arguments]    ${url}
    ${url}=    Catenate    SEPARATOR=    ${domain}    ${url}
    log    ${url}
    Location Should Be    ${url}

URL should contain
    [Arguments]    ${url}
    ${url}=    Catenate    SEPARATOR=    ${domain}    ${url}
    log    ${url}
    Location Should Contain    ${url}

Logout Portal and close browser
    Go To    ${domain}/user/logout/
    Close Browser
