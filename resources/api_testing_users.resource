*** Settings ***
Library    RequestsLibrary
Library    String

*** Keywords ***
Create a new user
    ${random_word}    Generate Random String    length=4    chars=[LETTERS]
    ${random_word}    Convert To Lower Case    ${random_word}
    Set Test Variable    ${email_test}    ${random_word}@emailtest.com
    Log    ${email_test}

Register the user on the ServeRest
    ${body}    Create Dictionary    
    ...    nome="Test Testt"    
    ...    email=${email_test}    
    ...    password=1234    
    ...    administrador=true

    Log    ${body}
    Create the session on the ServeRest
    ${response}    POST On Session 
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    
    Log    ${response.json()}

 Create the session on the ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
     Create Session    alias=ServeRest    url=https://serverest.dev/    headers=${headers}