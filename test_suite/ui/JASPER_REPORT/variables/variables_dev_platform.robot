*** Variables ***
#-------- Platform URL --------#
# Prod
${ADMINPROD_URL}        https://admin.acommerce.asia
# Non-Prod Dev
${ADMINDEV_URL}        https://admindev.acommercedev.com
${ADMINTEST_URL}       https://admintest.acommercedev.com
${PORTALDEV_URL}       https://portaldev.acommercedev.com
# Non-Prod Test
${PORTALTEST_URL}      https://portaltest.acommercedev.com
${PARTNERDEV_URL}      https://partnerdev.acommercedev.com
${PARTNERTEST_URL}     https://partnerdev.acommercedev.com
#-------- Browser -------------#
${BROWSER}             Chrome
# ${BROWSER}             phantomjs
#-------- Roles   -------------#
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

${PASSWORD}            Acomm1234!
#-------- MICRO_SERVICES ------#
${REPORTING_SERVICES}  /jasperserver/

#-------- Element Locators ----#
${welcome_text_login_page_locator}      css=body > div.content > form > h3
${input_username_locator}               xpath=/html/body/div[2]/form/div[1]/div/input
${input_password_locator}               xpath=/html/body/div[2]/form/div[2]/div/input
${jasper_server_home_locator}           xpath=//*[@id="results"]/div/div[1]/div
${login_failed_message_locator}         css=body > div > div > div
${login_failed_403_locator}             css=body > div > div > h1
${logout_button_locator}                css=#main_logOut_link
${login_button_locator}                 css=body > div.content > form > div.form-actions > button
