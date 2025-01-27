*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections

*** Keywords ***
Create a new user
    ${random_word}    Generate Random String    length=4    chars=[LETTERS]
    ${random_word}    Convert To Lower Case    ${random_word}
    Set Test Variable    ${email_test}    ${random_word}@emailtest.com
    Log    ${email_test}

Register the user on the ServeRest
    [Arguments]    ${email}    ${status_code}
    ${body}    Create Dictionary    
    ...    nome="Test Testt"    
    ...    email=${email}   
    ...    password=1234    
    ...    administrador=true

    Log    ${body}
    Create the session on the ServeRest
    ${response}    POST On Session 
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=${status_code}
    
    Log    ${response.json()}
    Set Test Variable    ${responsejson}    ${response.json()}

 Create the session on the ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
     Create Session    alias=ServeRest    url=https://serverest.dev/    headers=${headers}
    

Confirm if the user was created successfully
    Log     ${responsejson}
    Dictionary Should Contain Item    ${responsejson}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${responsejson}    _id

Repeate the creation of the user with the same e-mail
    Register the user on the ServeRest    email=${email_test}    status_code=400

Confirm if the API fails
    Dictionary Should Contain Item    ${responsejson}    message    Este email já está sendo usado