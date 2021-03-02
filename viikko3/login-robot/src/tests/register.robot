*** Settings ***
Resource  resource.robot
Test Setup  Input New Command And Create User

*** Test Cases ***
Register With Valid Username And Password
  Input Credentials  koo  i2345678
  Output Should Contain  New user registered

Register With Already Taken Username And Valid Password
  Input Credentials  kalle  kalle123
  Output Should Contain  User with username kalle already exists

Register With Username With Invalid Characters And Valid Password
  Input Credentials  kalle666  kalle123
  Output Should Contain  Username should only contain letters a-z

Register With Too Short Username And Valid Password
  Input Credentials  ka  kalle123
  Output Should Contain  Username too short (min 3)

Register With Valid Username And Too Short Password
  Input Credentials  validuser  kalle12
  Output Should Contain  Password too short (min 8)

Register With Valid Username And Long Enough Password Containing Only Letters
  Input Credentials  validuser  thiscontainsonlyletters
  Output Should Contain  Password shouldn't contain only letters

*** Keywords ***
Input New Command And Create User
  Input New Command
  Create User  kalle  kalle123
