*** Settings ***
Resource          global_resource_api.robot
Resource          global_resource_selenium.robot

*** Variables ***
#-------- Selenium library variables --------#
${browser}              Google Chrome
# ${browser}             PhantomJS
#-------- Content-Type ----------------------#
${JSON}                     application/json
${JSON_UTF8}                application/json;charset=UTF-8
${FORM_URLENCODED}          application/x-www-form-urlencoded
#-------- etc ----------------------------#
${Bearer}                   Bearer
${api-version}              2.0
#-------- Notification variables ------------#
${noti_dev}                 notification.acommercedev.service
${user_noti_dev}                 notifications.acommercedev.service
#-------- Consumer Notification variables ------------#
${noti_admin_path}          /notification/admin/
${noti_service_path}        /notification/
${publish_notification_url}  publish/notification/
${configuration_url}        publish/configuration/
${noti_admin_url}           http://${domain}${noti_admin_path}
${noti_user}                admin
${noti_password}            zB9-D93-tKk-2zV
#CSS Selector
${partner_65_cancelled_url}     publish/partnertemplate/565/change/
${partner_65_rejected_url}      publish/partnertemplate/567/change/
${partner_65_in_transit_url}    publish/partnertemplate/566/change/
${partner_65_delivered_url}     publish/partnertemplate/568/change/
${partner_65_failed_to_deliver_url}   publish/partnertemplate/569/change/
${partner_65_preparing_deliver_url}   publish/partnertemplate/570/change/
#Test data
${recipentEmailIncluded}       "recipientEmail": "nattapol.wilarat@acommerce.asia",
${recipentPhoneIncluded}       "recipientPhone": "+66846987582",
${recipentPhoneIncludedNocomma}       "recipientPhone": "+66846987582"
#-------  IDP Users services ----------------#
${idp_users_dev}                identity.acommercedev.com
${idp_users_partner_id_path}    /adminservice/users/partner/
${results_partner_id_30}        [{"username": "mark", "email": "mark@acommerce.asia"}, {"username": "ashopth", "email": "ashopth@acommerce.asia"}]

#-------- User notification variables -------#
${user_noti_admin_path}            /notifications/admin/
${user_noti_service_path}     /notifications/api/notify/
${user_noti_admin_url}        http://${domain}${user_noti_admin_path}
${user_noti_user}             admin
${user_noti_password}         zB9-D93-tKk-2zV
${user_noti_event}            /publish/event
${user_noti_subscriber}       /publish/subscriber
#-------- decoration ------------#
${horizontal_line}            ------------------------------------------------------------------------------
