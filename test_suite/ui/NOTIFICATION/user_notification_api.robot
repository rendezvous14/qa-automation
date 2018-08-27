*** Settings ***
Documentation       PLAT-467 [Notification] Create an end user notification system
Resource            resource/global_resource_selenium.robot
Resource            resource/global_resource_api.robot
Suite Setup         User Noti Event Add  ${event}  Test event for automation testing  Apple  '#777777'  Test event for automation testing
Suite Teardown      User Noti Event Delete  ${event}

*** Variables ***
${domain}            ${user_noti_dev}
${event}             AUTOMATION

*** Test Cases ***
TC001 specify targetUser as a user
    [Tags]   targetUser
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  no  robotframework   no    201 Created

TC002 specify targetUser as *
    [Tags]   targetUser
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  *  no  robotframework   no    201 Created

TC003 specify targetUser as null
    [Tags]   targetUser
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  null  no  robotframework   no    400 Bad Request

TC004 specify targetUser as ""
    [Tags]   targetUser
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  ${EMPTY}  no  robotframework   no    400 Bad Request

TC005 specify targetUser as unknown user
    [Tags]   targetUser
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  unknown user  no  robotframework   no    201 Created

TC006 specify targetPartner as partnerId = 31
    [Tags]   targetPartner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  no  31  robotframework   no    201 Created

TC007 specify targetPartner as "*"
    [Tags]   targetPartner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  no   *   robotframework   no    400 Bad Request

TC008 specify targetPartner as unknown partner = 100000
    [Tags]   targetPartner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  no  100000  robotframework   no    400 Bad Request

TC009 specify targetPartner as minus integer
    [Tags]   targetPartner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  no  -10  robotframework   no    400 Bad Request

TC010 specify targetUser as unicode language
    [Tags]   targetUser
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  ทดสอบ  no  robotframework   no    201 Created

TC010 single notification without group_by (not a required field)
    [Tags]   group_by
    ...      targetUser
    ...      targetParner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  no   no   no    201 Created

TC011 single notification with href = internal url (portal)
    [Tags]   href
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  no   no   https://admintest.acommercedev.com/notifications/    201 Created

TC012 single notification with href = url path
    [Tags]   href
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  no   no   /notifications/    201 Created

TC013 single notification with href = unknown
    [Tags]   href
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  no   no   unknown    201 Created

TC014 single notification with href = null
    [Tags]   href
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  no   no   null    400 Bad Request

TC015 event can not be null
    [Tags]   event
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  null  qa_platform  nattapol  no   robotframework   no    400 Bad Request

TC016 event can not be empty string
    [Tags]   event
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  ${EMPTY}  qa_platform  nattapol  no   robotframework   no    400 Bad Request

TC017 event can not be unknown event id
    [Tags]   event
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  UNKNOWN  qa_platform  nattapol  no   robotframework   no    400 Bad Request

TC018 event is a required field
    [Tags]   event
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  no  qa_platform  nattapol  no   robotframework   no    400 Bad Request

TC019 publisherId can not be empty string
    [Tags]   publisherId
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  ${EMPTY}  nattapol  no   robotframework   no    400 Bad Request

TC020 publisherId can not be null
    [Tags]   publisherId
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  null  nattapol  no   robotframework   no    400 Bad Request

TC021 publisherId is a required field
    [Tags]   publisherId
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  no  nattapol  no   robotframework   no    400 Bad Request

TC022 either targetUser or targetPartner is a required field
    [Tags]   targetUser
    ...      targetPartner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  no  no   robotframework   no    400 Bad Request

TC023 targetUser and targetPartner can not send together
    [Tags]   targetUser
    ...      targetPartner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  31   robotframework   no    400 Bad Request

TC024 targetUser and targetPartner can not send together
    [Tags]   targetUser
    ...      targetPartner
    Comment   ${event}  ${publisherId}  ${targetUser}  ${targetPartner}  ${group_by}  ${href}  ${ExpectedResults}
    POST User Notification  AUTOMATION  qa_platform  nattapol  31   robotframework   no    400 Bad Request
