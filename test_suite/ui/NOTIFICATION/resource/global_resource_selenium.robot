*** Settings ***
Documentation     Keyword collections for Selenium Web Testing
Library           Selenium2Library
Resource          global_variables.robot

*** Keywords ***
Login Notification Admin
  Open Browser   ${noti_admin_url}   ${browser}
  Maximize Browser Window
  Login Notification Admin Page Should Be Open
  Enter User Name   ${noti_user}
  Enter Password    ${noti_password}
  Submit Credentials

Login Notification Admin Page Should Be Open
  Element Text Should Be   css=#site-name > a  Django administration

Enter User Name
  [Arguments]   ${noti_user}
  Input Text    id=id_username    ${noti_user}

Enter Password
  [Arguments]   ${noti_password}
  Input Password   id=id_password    ${noti_password}

Submit Credentials
  Click Button    css=#login-form > div.submit-row > input[type="submit"]

Logout and close browser
  Go To  ${noti_admin_url}logout/
  Close Browser

Go partner template page
  [Arguments]    ${event}
  #See partner url in global_variables.robot
  ${partner_template_url}=  Set Variable If
  ...      "${event}" == "CANCELLED"     ${partner_65_cancelled_url}
  ...      "${event}" == "REJECTED"      ${partner_65_rejected_url}
  ...      "${event}" == "IN_TRANSIT"    ${partner_65_in_transit_url}
  ...      "${event}" == "DELIVERED"    ${partner_65_delivered_url}
  ...      "${event}" == "FAILED_TO_DELIVER"    ${partner_65_failed_to_deliver_url}
  ...      "${event}" == "PREPARING_DELIVERY"    ${partner_65_preparing_deliver_url}
  ${partner_template_path}=   Catenate  SEPARATOR=     ${noti_admin_url}  ${partner_template_url}
  Go To   ${partner_template_path}

Go publish notification page
  ${publish_notification_path}=   Catenate  SEPARATOR=     ${noti_admin_url}  ${publish_notification_url}
  Go To   ${publish_notification_path}

Add Partner Template
  [Arguments]   ${partner}  ${event}  ${predefine_template}  ${sms_template}  ${notify_preference}
  Log   ${partner}
  Log   ${event}
  Log   ${predefine_template}
  Log   ${sms_template}
  Log   ${notify_preference}
  Login Notification Admin
  Go partner template page
  Click Element  xpath=//*[@id="content-main"]/ul/li/a
  #Input user's options
  Click Element  xpath=//*[@id="id_partner"]/option[@value="${partner}"]
  Click Element  xpath=//*[@id="id_event"]/option[@value="${event}"]
  Click Element  xpath=//*[@id="id_emailTemplatePredefinedOverride"]/option[@value="${predefine_template}"]
  Input Text     xpath=//*[@id="id_smsTemplateOverride"]   ${sms_template}
  #Option Mapping
  ${notify_preference}=  Set Variable If
  ...      "${notify_preference}" == "None"    0
  ...      "${notify_preference}" == "Email Over Sms"    1
  ...      "${notify_preference}" == "Sms Over Email"    2
  ...      "${notify_preference}" == "Email Only"        3
  ...      "${notify_preference}" == "Sms Only"          4
  ...      "${notify_preference}" == "Email And Sms"     5
  Click Element  xpath=//*[@id="id_notifyPreference"]/option[@value="${notify_preference}"]
  Click Element  xpath=//*[@id="partnertemplate_form"]/div/div/input[1]
  Wait Until Element Contains    xpath=//*[@id="container"]/ul/li  The partner template "${partner} ${event}" was added successfully.

Configure Partner Template
  [Arguments]   ${partner}  ${event}  ${predefine_template}  ${sms_template}  ${notify_preference}
  Log   ${partner}
  Log   ${event}
  Log   ${predefine_template}
  Log   ${sms_template}
  Log   ${notify_preference}
  Login Notification Admin
  Go partner template page   ${event}
  #Input user's options
  Click Element  xpath=//*[@id="id_partner"]/option[@value="${partner}"]
  Click Element  xpath=//*[@id="id_event"]/option[@value="${event}"]
  Click Element  xpath=//*[@id="id_emailTemplatePredefinedOverride"]/option[@value="${predefine_template}"]
  Input Text     xpath=//*[@id="id_smsTemplateOverride"]   ${sms_template}
  #Option Mapping
  ${notify_preference}=  Set Variable If
  ...      "${notify_preference}" == "None"    0
  ...      "${notify_preference}" == "Email Over Sms"    1
  ...      "${notify_preference}" == "Sms Over Email"    2
  ...      "${notify_preference}" == "Email Only"        3
  ...      "${notify_preference}" == "Sms Only"          4
  ...      "${notify_preference}" == "Email And Sms"     5
  Click Element  xpath=//*[@id="id_notifyPreference"]/option[@value="${notify_preference}"]
  Click Element  xpath=//*[@id="partnertemplate_form"]/div/div/input[1]
  Wait Until Element Contains    xpath=//*[@id="container"]/ul/li  The partner template "${partner} ${event}" was changed successfully.
  Logout and close browser

Enable Test Mode
  Login Notification Admin
  ${configuration_path}=   Catenate  SEPARATOR=     ${noti_admin_url}   ${configuration_url}
  Go To  ${configuration_path}
  Click Element    xpath=//*[@id="result_list"]/tbody/tr/th/a/img
  Page Should Contain    Change configuration
  Select Checkbox    xpath=//*[@id="id_test_mode"]
  Click Element    xpath=//*[@id="configuration_form"]/div/div/input[1]
  Wait Until Page Contains    The configuration "Configuration object" was changed successfully.
  Logout and close browser

Disable Test Mode
  Login Notification Admin
  ${configuration_path}=   Catenate  SEPARATOR=     ${noti_admin_url}   ${configuration_url}
  Go To  ${configuration_path}
  Click Element    xpath=//*[@id="result_list"]/tbody/tr/th/a/img
  Page Should Contain    Change configuration
  Unselect Checkbox    xpath=//*[@id="id_test_mode"]
  Click Element    xpath=//*[@id="configuration_form"]/div/div/input[1]
  Wait Until Page Contains    The configuration "Configuration object" was changed successfully.
  Logout and close browser

Confirm Notification Sent successfully
  Go publish notification page
  Element Should Not Contain   xpath=//*[@id="result_list"]/tbody/tr[1]/td[8]   NULL

Login User Notification Admin
  Open Browser   ${user_noti_admin_url}   ${browser}
  Maximize Browser Window
  Login Notification Admin Page Should Be Open
  Enter User Name   ${user_noti_user}
  Enter Password    ${user_noti_password}
  Submit Credentials

User Noti Event Add
  [Arguments]   ${event_id}  ${event_desc}  ${icon}   ${color}  ${grouping}
  Log To Console    Add ${event_id} user noti event
  Login User Notification Admin
  #### create event
  Go to  ${user_noti_admin_url}${user_noti_event}/add
  Input Text    xpath=//*[@id="id_event_id"]    ${event_id}
  Input Text    xpath=//*[@id="id_event_description"]  ${event_desc}
  Click Element    xpath=//*[@id="select2-chosen-1"]
  Input Text    xpath=//*[@id="s2id_autogen1_search"]    ${icon}
  Press Key     xpath=//*[@id="s2id_autogen1_search"]    \\13   #Press Enter button
  Input Text    xpath=//*[@id="id_color"]    ${color}
  Input Text    xpath=//*[@id="id_event_group"]    ${grouping}
  Click Button    xpath=//*[@id="event_form"]/div/div/input[1]
  #### Subscribe this event
  Go To    ${user_noti_admin_url}${user_noti_subscriber}/add
  Click Element  xpath=//*[@id="id_event"]/option[@value="${event_id}"]
  Click Element  xpath=//*[@id="id_user"]/option[@value="nattapol"]
  Select Checkbox    xpath=//*[@id="id_is_portal"]
  Select Checkbox    xpath=//*[@id="id_is_email"]
  Click Button    xpath=//*[@id="subscriber_form"]/div/div/input[1]
  Page Should Contain    The subscriber "Subscriber object" was added successfully.  10
  ####
  Go To    ${user_noti_admin_url}/logout
  Close Browser
  Log To Console    Done
  Log To Console    ${horizontal_line}

User Noti Event Delete
  [Arguments]  ${event_id}
  Log To Console    Delete ${event_id} user noti event
  Login User Notification Admin
  Go to  ${user_noti_admin_url}${user_noti_event}
  Click Element   xpath=(//input[@name='_selected_action'])[@value='${event_id}']
  Click Element   xpath=//*[@id="changelist-form"]/div[1]/label/select/option[2]
  Click Button    xpath=//*[@id="changelist-form"]/div[1]/button
  Page Should Contain    Delete Selected Event
  Click Button    xpath=//*[@id="content"]/form/div/input[2]
  Page Should Contain    event deleted
  Go To    ${user_noti_admin_url}/logout
  Close Browser
  Log To Console    Done
  Log To Console    ${horizontal_line}

# Select option
#   [Arguments]   ${option1}   ${option2}
#   ${select_option_1}=   Set Variable    ${option1}
#   ${select_option_2}=   Set Variable    ${option2}
#   Run Keyword If   '${select_option_1}' == 'A'  Log  You got A
#   Run Keyword If   '${select_option_1}' == 'B'  Log  You got B
#   Run Keyword If   '${select_option_1}' == 'C'  Log  You got C
#   Run Keyword If   '${select_option_2}' == '1'  Log  You got 1
#   Run Keyword If   '${select_option_2}' == '2'  Log  You got 2
#   Run Keyword If   '${select_option_2}' == '3'  Log  You got 3
