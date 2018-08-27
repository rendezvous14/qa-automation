*** Settings ***
Documentation       PLAT-800 [Consumer Notification] Make notification service accept the recipientEmail and recipientSms = empty string
Resource            resource/global_resource_selenium.robot
Resource            resource/global_resource_api.robot

*** Variables ***
${domain}            ${noti_dev}

*** Test Cases ***
####=========================================================================================================
Configure partner template - notifyPreference = Email And Sms
  Configure Partner Template    65   IN_TRANSIT    ${EMPTY}  ${EMPTY}   Email And Sms

receipientEmail=YES, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   yes   201 Created

receipientEmail=empty_string, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   yes   201 Created

receipientEmail=no variable, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   yes   201 Created

receipientEmail=null, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   yes   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=YES, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   empty   201 Created

receipientEmail=YES, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   no   201 Created

receipientEmail=YES, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   null   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   empty   201 Created

receipientEmail=no variable, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   no   201 Created

receipientEmail=null, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   null   201 Created

###----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   no   201 Created

receipientEmail=null, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   no   201 Created

receipientEmail=empty_string, receipient=null, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   null   201 Created

receipientEmail=no variable, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   null   201 Created

receipientEmail=null, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   empty   201 Created

receipientEmail=no variable, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   empty   201 Created

####=========================================================================================================
Configure partner template - notifyPreference = Sms
  Configure Partner Template    65   IN_TRANSIT    ${EMPTY}  ${EMPTY}   Sms Only

receipientEmail=YES, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   yes   201 Created

receipientEmail=empty_string, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   yes   201 Created

receipientEmail=no variable, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   yes   201 Created

receipientEmail=null, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   yes   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=YES, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   empty   201 Created

receipientEmail=YES, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   no   201 Created

receipientEmail=YES, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   null   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   empty   201 Created

receipientEmail=no variable, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   no   201 Created

receipientEmail=null, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   null   201 Created

###----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   no   201 Created

receipientEmail=null, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   no   201 Created

receipientEmail=empty_string, receipient=null, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   null   201 Created

receipientEmail=no variable, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   null   201 Created

receipientEmail=null, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   empty   201 Created

receipientEmail=no variable, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   empty   201 Created

####=========================================================================================================
Configure partner template - notifyPreference = Email
  Configure Partner Template    65   IN_TRANSIT    ${EMPTY}  ${EMPTY}   Email Only

receipientEmail=YES, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   yes   201 Created

receipientEmail=empty_string, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   yes   201 Created

receipientEmail=no variable, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   yes   201 Created

receipientEmail=null, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   yes   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=YES, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   empty   201 Created

receipientEmail=YES, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   no   201 Created

receipientEmail=YES, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   null   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   empty   201 Created

receipientEmail=no variable, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   no   201 Created

receipientEmail=null, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   null   201 Created

###----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   no   201 Created

receipientEmail=null, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   no   201 Created

receipientEmail=empty_string, receipient=null, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   null   201 Created

receipientEmail=no variable, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   null   201 Created

receipientEmail=null, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   empty   201 Created

receipientEmail=no variable, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   empty   201 Created

####=========================================================================================================
Configure partner template - notifyPreference = Email Over Sms
  Configure Partner Template    65   IN_TRANSIT    ${EMPTY}  ${EMPTY}   Email Over Sms

receipientEmail=YES, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   yes   201 Created

receipientEmail=empty_string, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   yes   201 Created

receipientEmail=no variable, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   yes   201 Created

receipientEmail=null, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   yes   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=YES, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   empty   201 Created

receipientEmail=YES, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   no   201 Created

receipientEmail=YES, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   null   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   empty   201 Created

receipientEmail=no variable, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   no   201 Created

receipientEmail=null, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   null   201 Created

###----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   no   201 Created

receipientEmail=null, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   no   201 Created

receipientEmail=empty_string, receipient=null, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   null   201 Created

receipientEmail=no variable, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   null   201 Created

receipientEmail=null, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   empty   201 Created

receipientEmail=no variable, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   empty   201 Created
#
####=========================================================================================================
Configure partner template - notifyPreference = Sms Over Email
  Configure Partner Template    65   IN_TRANSIT    ${EMPTY}  ${EMPTY}   Sms Over Email

receipientEmail=YES, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   yes   201 Created

receipientEmail=empty_string, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   yes   201 Created

receipientEmail=no variable, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   yes   201 Created

receipientEmail=null, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   yes   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=YES, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   empty   201 Created

receipientEmail=YES, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   no   201 Created

receipientEmail=YES, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   null   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   empty   201 Created

receipientEmail=no variable, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   no   201 Created

receipientEmail=null, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   null   201 Created

###----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   no   201 Created

receipientEmail=null, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   no   201 Created

receipientEmail=empty_string, receipient=null, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   null   201 Created

receipientEmail=no variable, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   null   201 Created

receipientEmail=null, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   empty   201 Created

receipientEmail=no variable, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   empty   201 Created

####=========================================================================================================
Configure partner template - notifyPreference = None
  Configure Partner Template    65   IN_TRANSIT    ${EMPTY}  ${EMPTY}   None

receipientEmail=YES, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   yes   201 Created

receipientEmail=empty_string, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   yes   201 Created

receipientEmail=no variable, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   yes   201 Created

receipientEmail=null, receipient=YES, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   yes   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=YES, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   empty   201 Created

receipientEmail=YES, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   no   201 Created

receipientEmail=YES, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    yes   null   201 Created

####----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   empty   201 Created

receipientEmail=no variable, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   no   201 Created

receipientEmail=null, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   null   201 Created

###----------------------------------------------------------------------------------------------------------
receipientEmail=empty_string, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   no   201 Created

receipientEmail=null, receipient=no variable, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   no   201 Created

receipientEmail=empty_string, receipient=null, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    empty   null   201 Created

receipientEmail=no variable, receipient=null, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   null   201 Created

receipientEmail=null, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  ...     TBD
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    null   empty   201 Created

receipientEmail=no variable, receipient=empty_string, results=201 Created
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT    no   empty   201 Created

####=========================================================================================================
Configure partner template - notifyPreference = Email And Sms 1
  Configure Partner Template    65   IN_TRANSIT    ${EMPTY}  ${EMPTY}   Email And Sms

receipientEmail=wrong format, receipient=YES, results=400 Bad Request
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc.efg   yes   400 Bad Request

receipientEmail=YES, receipient=wrong format, results=400 Bad Request
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   084552   400 Bad Request

receipientEmail=wrong format, receipient=wrong format, results=400 Bad Request
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc.efg   084552   400 Bad Request

receipientEmail=empty string, receipient=String, results=400 Bad Request
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     empty   084552   400 Bad Request

receipientEmail=no variable, receipient=empty string, results=400 Bad Request
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     no   084552   400 Bad Request

receipientEmail=wrong format, receipient=empty string, results=400 Bad Request
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc.efg   empty   400 Bad Request

receipientEmail=wrong format, receipient=no variable, results=400 Bad Request
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc.efg   no   400 Bad Request
## add from previous version
TC004 got 400 Bad Request when recipientPhone contains no (+)
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    66839919341    400 Bad Request

TC005 got 400 Bad Request when recipientPhone contains any prefix text
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    abc+66839919341    400 Bad Request

TC006 got 400 Bad Request when recipientPhone contains any prefix number
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +668+66839919341    400 Bad Request

TC007 got 400 Bad Request when recipientPhone contains no country code
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    0801111111    400 Bad Request

TC008 got 400 Bad Request when recipientPhone contains multiple phone no
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +6689011011,+6689810111   400 Bad Request

TC009 got 201 Created when recipientPhone contains long length phone number (14 characters)
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +6689011011111101   201 Created

TC010 got 400 Bad Request when recipientPhone contains over length phone number (15 characters)
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +66890110111111011   400 Bad Request

TC011 got 400 Bad Request when recipientPhone contains -characters
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    -66800110111   400 Bad Request

TC012 got 400 Bad Request when recipientPhone contains ++ characters
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    ++66800110111   400 Bad Request

TC015 got 400 Bad Request when recipientEmail contains multiple email address
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc.a@abcdefg.com,abe.b@abcdefg.com    yes   400 Bad Request

TC016 got 400 Bad Request when recipientEmail contains incorrect format email address
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc#abcedfg..  yes   400 Bad Request

TC017 got 400 Bad Request when recipientEmail contains variable
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     {{partner.servicesSettings.CUSTOMER_SERVICE.email}}  yes   400 Bad Request

TC018 got 400 Bad Request when recipientPhone contains variable
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes  {{partner.servicesSettings.CUSTOMER_SERVICE.phone}}   400 Bad Request
