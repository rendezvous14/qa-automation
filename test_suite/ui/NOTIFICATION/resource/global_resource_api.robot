*** Settings ***
Documentation     Keyword collections for REST API
...               Support GET, POST, PUT, PATCH
Library           HttpLibrary.HTTP
Library           DateTime
Resource          global_variables.robot

*** Keywords ***
Make Notification request body
    [Arguments]    ${got_partner}    ${got_event}   ${is_recipientEmail}   ${is_recipientPhone}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${is_recipientEmail}" == "yes"   ${recipentEmailIncluded}
    ...      ${EMPTY}
    ${recipientPhone}=   Set Variable If
    ...      "${is_recipientPhone}" == "yes"   ${recipentPhoneIncluded}
    ...      ${EMPTY}
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipientPhone}
    ...     "var": {
    ...        "partner_order_id" : "1234567890ABC-A",
    ...        "shipping_addressee" : "จอห์นแว่น",
    ...        "shipping_address" : "47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิมิตรใหม่ ซอยนิมิตรใหม่ 40 แขวงคลองสามวาตะวันออก เขตคลไองสามวา กรุงเทพ 10510",
    ...        "in_transit_date": "2016-02-14T23:00:00.000000Z",
    ...        "provider_name": "aComm Provider",
    ...        "provider_tracking_id": "1Z4922AE0399435779",
    ...        "order_total": 99,
    ...        "sales_order_items" : [
    ...            {
    ...                "item_title" : "Feels So Good",
    ...                "sku" : "0001",
    ...                "item_qty" : "1"
    ...            },
    ...            {
    ...                "item_title" : "What a Difference a Day Makes",
    ...                "sku" : "0002",
    ...                "item_qty" : "1"
    ...            }
    ...          ]
    ...        }
    ...     }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

Make Notification request body with null for all variables
    [Arguments]    ${got_partner}    ${got_event}   ${is_recipientEmail}   ${is_recipientPhone}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${is_recipientEmail}" == "yes"   ${recipentEmailIncluded}
    ...      ${EMPTY}
    ${recipientPhone}=   Set Variable If
    ...      "${is_recipientPhone}" == "yes"   ${recipentPhoneIncluded}
    ...      ${EMPTY}
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipientPhone}
    ...     "var": {
    ...        "partner_order_id" : null,
    ...        "shipping_addressee" : null,
    ...        "shipping_address" : null,
    ...        "in_transit_date": null,
    ...        "provider_name": null,
    ...        "provider_tracking_id": null,
    ...        "order_total": null,
    ...        "sales_order_items" : [
    ...            {
    ...                "item_title" : null,
    ...                "sku" : null,
    ...                "item_qty" : null
    ...            },
    ...            {
    ...                "item_title" : null,
    ...                "sku" : null,
    ...                "item_qty" : null
    ...            }
    ...          ]
    ...        }
    ...     }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

Make Notification request body with variable is null
    [Arguments]    ${got_partner}    ${got_event}   ${is_recipientEmail}   ${is_recipientPhone}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${is_recipientEmail}" == "yes"   ${recipentEmailIncluded}
    ...      ${EMPTY}
    ${recipientPhone}=   Set Variable If
    ...      "${is_recipientPhone}" == "yes"   ${recipentPhoneIncluded}
    ...      ${EMPTY}
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipientPhone}
    ...     "var": null
    ...   }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

Make Notification request body without variable
    [Arguments]    ${got_partner}    ${got_event}   ${is_recipientEmail}   ${is_recipientPhone}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${is_recipientEmail}" == "yes"   ${recipentEmailIncluded}
    ...      ${EMPTY}
    ${recipientPhone}=   Set Variable If
    ...      "${is_recipientPhone}" == "yes"   ${recipentPhoneIncluded}
    ...      ${EMPTY}
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipentPhoneIncludedNocomma}
    ...   }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

Make Notification request body with blank string
    [Arguments]    ${got_partner}    ${got_event}   ${is_recipientEmail}   ${is_recipientPhone}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${is_recipientEmail}" == "yes"   ${recipentEmailIncluded}
    ...      ${EMPTY}
    ${recipientPhone}=   Set Variable If
    ...      "${is_recipientPhone}" == "yes"   ${recipentPhoneIncluded}
    ...      ${EMPTY}
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipientPhone}
    ...     "var": {
    ...        "partner_order_id" : "",
    ...        "shipping_addressee" : "",
    ...        "shipping_address" : "",
    ...        "in_transit_date": "",
    ...        "provider_name": "",
    ...        "provider_tracking_id": "",
    ...        "order_total": "",
    ...        "sales_order_items" : [
    ...            {
    ...                "item_title" : "",
    ...                "sku" : "",
    ...                "item_qty" : ""
    ...            },
    ...            {
    ...                "item_title" : "",
    ...                "sku" : "",
    ...                "item_qty" : ""
    ...            }
    ...          ]
    ...        }
    ...   }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

Make Notification request body with variable is ""
    [Arguments]    ${got_partner}    ${got_event}   ${is_recipientEmail}   ${is_recipientPhone}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${is_recipientEmail}" == "yes"   ${recipentEmailIncluded}
    ...      ${EMPTY}
    ${recipientPhone}=   Set Variable If
    ...      "${is_recipientPhone}" == "yes"   ${recipentPhoneIncluded}
    ...      ${EMPTY}
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipientPhone}
    ...     "var": ""
    ...   }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

Make Notification request body with other date format
    [Arguments]    ${got_partner}    ${got_event}   ${is_recipientEmail}   ${is_recipientPhone}   ${dateformat}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${is_recipientEmail}" == "yes"   ${recipentEmailIncluded}
    ...      ${EMPTY}
    ${recipientPhone}=   Set Variable If
    ...      "${is_recipientPhone}" == "yes"   ${recipentPhoneIncluded}
    ...      ${EMPTY}
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipientPhone}
    ...     "var": {
    ...        "partner_order_id" : "สวัสดี1234567890ABC-A",
    ...        "shipping_addressee" : "จอห์นแว่น",
    ...        "shipping_address" : "47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิมิตรใหม่ ซอยนิมิตรใหม่ 40 แขวงคลองสามวาตะวันออก เขตคลไองสามวา กรุงเทพ 10510",
    ...        "in_transit_date": "${dateformat}",
    ...        "provider_name": "aComm Provider",
    ...        "provider_tracking_id": "1Z4922AE0399435779",
    ...        "order_total": 9999999999,
    ...        "sales_order_items" : [
    ...            {
    ...                "item_title" : "Feels So Good",
    ...                "sku" : "0001",
    ...                "item_qty" : "1"
    ...            },
    ...            {
    ...                "item_title" : "What a Difference a Day Makes",
    ...                "sku" : "0002",
    ...                "item_qty" : "1"
    ...            },
    ...            {
    ...                "item_title" : "What the",
    ...                "sku" : "0003",
    ...                "item_qty" : "1"
    ...            },
    ...            {
    ...                "item_title" : "row 4",
    ...                "sku" : "0004",
    ...                "item_qty" : "1"
    ...            }
    ...          ]
    ...        }
    ...     }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

Make Notification request with custom recipientEmail and recipientPhone
    [Arguments]    ${got_partner}    ${got_event}   ${got_email}   ${got_phone}
    ${partner}=   Set Variable If
    ...      "${got_partner}" == "no"     ${EMPTY}
    ...      "${got_partner}" == "yes"     ${EMPTY}
    ...      "partner": "${got_partner}",
    ${event}=     Set Variable If
    ...      "${got_event}" == "no"      ${EMPTY}
    ...      "event": "${got_event}",
    ${recipientEmail}=   Set Variable If
    ...      "${got_email}" == "no"   ${EMPTY}
    ...      "${got_email}" == "yes"  ${recipentEmailIncluded}
    ...      "${got_email}" == "empty"      "recipientEmail": "",
    ...      "${got_email}" == "null"  "recipientEmail": null,
    ...      "recipientEmail": "${got_email}",
    ${recipientPhone}=   Set Variable If
    ...      "${got_phone}" == "no"   ${EMPTY}
    ...      "${got_phone}" == "yes"   ${recipentPhoneIncluded}
    ...      "${got_phone}" == "empty"      "recipientPhone": "",
    ...      "${got_phone}" == "null"  "recipientPhone": null,
    ...      "recipientPhone": "${got_phone}",
    #
    ${requested_body}=    Catenate
    ...   { ${partner}
    ...     ${event}
    ...     ${recipientEmail}
    ...     ${recipientPhone}
    ...     "var": {
    ...        "partner_order_id" : "1234567890ABC-A",
    ...        "shipping_addressee" : "จอห์นแว่น",
    ...        "shipping_address" : "47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิมิตรใหม่ ซอยนิมิตรใหม่ 40 แขวงคลองสามวาตะวันออก เขตคลไองสามวา กรุงเทพ 10510",
    ...        "in_transit_date": "2016-02-14T23:00:00.000000Z",
    ...        "provider_name": "aComm Provider",
    ...        "provider_tracking_id": "1Z4922AE0399435779",
    ...        "order_total": 99,
    ...        "sales_order_items" : [
    ...            {
    ...                "item_title" : "Feels So Good",
    ...                "sku" : "0001",
    ...                "item_qty" : "1"
    ...            },
    ...            {
    ...                "item_title" : "What a Difference a Day Makes",
    ...                "sku" : "0002",
    ...                "item_qty" : "1"
    ...            }
    ...          ]
    ...        }
    ...     }
    Log     ${requested_body}
    Set Global Variable    ${noti_body}    ${requested_body}

POST Consumer Notification with error status
    [Arguments]    ${partner}    ${event}     ${is_recipientEmail}   ${is_recipientPhone}   ${ErrorCode}
    Create Http Context   ${domain}    http
    Set Request Header    Content-Type    ${JSON}
    Make Notification request body   ${partner}    ${event}   ${is_recipientEmail}   ${is_recipientPhone}
    Set Request Body      ${noti_body}
    Next Request May Not Succeed
    POST    ${noti_service_path}
    ${status}=  Get Response Status
    Should Start With   ${ErrorCode}   ${status}
    # ${resultBody}=    Get Response Body
    # ${getNotiStatus}=    Get Json Value    ${resultBody}    /result
    # Should Be Equal    ${getNotiStatus}  "ok"

POST Consumer Notification with custom email and sms
    [Arguments]    ${partner}    ${event}     ${got_email}   ${got_phone}   ${ErrorCode}
    Create Http Context   ${domain}    http
    Set Request Header    Content-Type    ${JSON}
    Make Notification request with custom recipientEmail and recipientPhone   ${partner}    ${event}   ${got_email}   ${got_phone}
    Set Request Body      ${noti_body}
    Next Request May Not Succeed
    POST    ${noti_service_path}
    ${status}=  Get Response Status
    Should Start With   ${ErrorCode}   ${status}

POST Consumer Notification with custom variable
    [Arguments]    ${partner}    ${event}    ${ErrorCode}
    Create Http Context   ${domain}    http
    Set Request Header    Content-Type    ${JSON}
    # got the noti_body from input arguments
    Set Request Body      ${noti_body}
    Next Request May Not Succeed
    POST    ${noti_service_path}
    ${status}=  Get Response Status
    Should Start With   ${ErrorCode}   ${status}

POST Consumer Notification
    [Arguments]    ${partner}    ${event}     ${yes}   ${yes}
    Create Http Context   ${domain}    http
    Set Request Header    Content-Type    ${JSON}
    Make Notification request body   ${partner}    ${event}   ${yes}   ${yes}
    Set Request Body      ${noti_body}
    POST    ${noti_service_path}
    Response Status Code Should Equal    201
    ${resultBody}=    Get Response Body
    ${getNotiStatus}=    Get Json Value    ${resultBody}    /result
    Should Be Equal    ${getNotiStatus}  "ok"

Get IDP user_name
    [Arguments]  ${partner_id}   ${expected_results}
    Create Http Context   ${domain}    https
    Set Request Header    Content-Type    ${JSON}
    GEt    ${idp_users_partner_id_path}/${partner_id}
    Response Status Code Should Equal    200
    ${resultBody}=    Get Response Body
    Should Be Equal    ${resultBody}  ${expected_results}

Make User Notification request
    [Arguments]  ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}
    ${event}=   Set Variable If
    ...      "${event}" == "no"   ${EMPTY}
    ...      "${event}" == "null"  "event": null,
    ...      "event": "${event}",
    ${publisherId}=   Set Variable If
    ...      "${publisherId}" == "no"   ${EMPTY}
    ...      "${publisherId}" == "null"  "publisherId": null,
    ...      "publisherId": "${publisherId}",
    ${targetUser}=   Set Variable If
    ...      "${targetUser}" == "no"   ${EMPTY}
    ...      "${targetUser}" == "null"  "targetUser": null,
    ...      "targetUser": "${targetUser}",
    ${targetPartner}=   Set Variable If
    ...      "${targetPartner}" == "no"   ${EMPTY}
    ...      "${targetPartner}" == "null"  "targetPartner": null,
    ...      "targetPartner": "${targetPartner}",
    ${group_by}=   Set Variable If
    ...      "${group_by}" == "no"   ${EMPTY}
    ...      "${group_by}" == "null"  "group_by": null,
    ...      "group_by": "${group_by}",
    ${href}=   Set Variable If
    ...      "${href}" == "no"   ${EMPTY}
    ...      "${href}" == "null"  "href": null,
    ...      "href": "${href}",
    #
    ${ms}=  Get Current Date
    ${requested_body}=    Catenate
    ...   { ${event}
    ...     ${publisherId}
    ...     ${targetUser}
    ...     ${targetPartner}
    ...     ${group_by}
    ...     ${href}
    ...     "subject": "Automation",
    ...     "body": "${TEST NAME} on ${ms}"
    ...   }
    Log     ${requested_body}
    Set Global Variable    ${user_noti_body}    ${requested_body}

POST User Notification
    [Arguments]    ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ErrorCode}
    Create Http Context   ${domain}    http
    Set Request Header    Content-Type    ${JSON}
    Make User Notification request  ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}
    Set Request Body      ${user_noti_body}
    Next Request May Not Succeed
    POST    ${user_noti_service_path}
    ${status}=  Get Response Status
    Should Start With   ${ErrorCode}   ${status}
