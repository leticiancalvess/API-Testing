*** Settings ***
Resource    ../resources/api_testing_users.resource

*** Variables ***

*** Test Cases ***
Scenario 1: Register a new user (ServeRest)
    Create a new user
    Register the user on the ServeRest 
    Create the session on the ServeRest
    Confirm if the user was created successfully
