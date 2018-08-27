*** Settings ***
Library           Selenium2Library

*** Variables ***
${ADMIN_PROD}     https://admintest.acommerce.asia    # https://admin.acommerce.asia
${PARTNER_PROD}    https://partner.acommerce.asia
${PORTAL_PROD}    https://portal.acommerce.asia
${ADMIN_DEV}      https://admindev.acommercedev.com
${ADMIN_TEST}     https://admintest.acommercedev.com
${PARTNER_DEV}    https://partnerdev.acommercedev.com
${PORTAL_DEV}     https://portaldev.acommercedev.com
${PARTNER_TEST}   https://partnertest.acommercedev.com
${automation_password}    Acomm1234!
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
    Page Should Contain    Login to aCommerce Management Portal
    Input Text    name=username    ${username}
    Input Password    name=password    ${automation_password}
    Click Button    xpath=/html/body/div[2]/form/div[3]/button

Access Denied
    Element Text Should Be    css=body > div > div > div    Oops, You don't have the right access to the Domain!
    Element Text Should Be    css=body > div > div > h1    403

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
