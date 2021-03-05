*** Settings ***
Resource  resource.robot
Resource  login_resource.robot
Suite Setup  Open And Configure Browser
Suite Teardown  Close Browser
Test Setup  Create User And Go To Register Page

*** Test Cases ***
Register With Valid Username And Password
    Set Username  palle
    Set Password  palle123
    Set Password Confirmation  palle123
    Submit Register Credentials
    Register Should Succeed

Register With Too Short Username And Valid Password
    Set Username  gg
    Set Password  palle123
    Set Password Confirmation  palle123
    Submit Register Credentials
    Register Should Fail With Message  Username too short (min 3)

Register With Valid Username And Too Short Password
    Set Username  palle
    Set Password  i234567
    Set Password Confirmation  i234567
    Submit Register Credentials
    Register Should Fail With Message  Password too short (min 8)

Register With Nonmatching Password And Password Confirmation
    Set Username  palle
    Set Password  juuboldi123
    Set Password Confirmation  jaaboldi123
    Submit Register Credentials
    Register Should Fail With Message  Password and password confirmation do not match    

Login After Successful Registration 
    Set Username  palle
    Set Password  palle123
    Set Password Confirmation  palle123
    Submit Register Credentials
    Register Should Succeed

    Logout

    Go To Login Page
    Set Username  palle
    Set Password  palle123
    Submit Login Credentials
    Login Should Succeed

Login After Failed Registration
    Set Username  palle
    Set Password  juuboldi123
    Set Password Confirmation  jaaboldi123
    Submit Register Credentials
    Register Should Fail With Message  Password and password confirmation do not match  

    Logout

    Go To Login Page
    Set Username  palle
    Set Password  juuboldi123
    Submit Login Credentials
    Login Should Fail With Message  Invalid username or password
  
*** Keywords ***
Create User And Go To Register Page
    Create User  kalle  kalle123
    Go To Register Page
    Register Page Should Be Open

Set Username
    [Arguments]  ${username}
    Input Text  username  ${username}

Set Password
    [Arguments]  ${password}
    Input Password  password  ${password}

Set Password Confirmation
    [Arguments]  ${password}
    Input Password  password_confirmation  ${password}

Submit Register Credentials
    Click Button  Register

Register Should Succeed
    Welcome Page Should Be Open

Register Should Fail With Message
    [Arguments]  ${message}
    Register Page Should Be Open
    Page Should Contain  ${message}