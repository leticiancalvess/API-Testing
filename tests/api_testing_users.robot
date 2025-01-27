*** Settings ***
Resource    ../resources/api_testing_users.resource

*** Variables ***

*** Test Cases ***
Scenario 1: Register a new user (ServeRest)
    Create a new user
    Register the user on the ServeRest    ${email_test}     status_code=201
    Create the session on the ServeRest
    Confirm if the user was created successfully

Scenario 2: Try to register an existing user
    Create a new user
    Register the user on the ServeRest    ${email_test}    status_code=201 
    Repeate the creation of the user with the same e-mail 
    Confirm if the API fails
