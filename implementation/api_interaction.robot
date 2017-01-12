*** Settings ***
Library  Collections
Library  RequestsLibrary

*** Variables ***
${json}    None

*** Keywords ***
Create API Session
    [Documentation]  Creates a session to a supplied URL with headers and parameters
    [Arguments]  ${SESSION}  ${URL}
    create session  ${SESSION}  ${URL}

Send Get Request
    [Documentation]  Sends a get request to the opened session
    [Arguments]  ${SESSION}  ${URI}  ${HEADERS}  ${PARAMS}
    ${resp}=    get request  ${Session}  ${URI}  headers=${HEADERS}  params=${PARAMS}
    should be equal as strings  ${resp.status_code}  200
    ${output}=    To Json    ${resp.content}    pretty_print=True
    set test variable  ${json}  ${output}
    Log    ${json}

Json Key Exists
    [Documentation]  checks for the existence of a key in the returned json
    [Arguments]  ${key}
    dictionary should contain key  ${json}  ${key}

Json Key Equals
    [Documentation]  checks that a certain key in the returned json has an expected value
    [Arguments]  ${key}  ${value}
    Should Contain    ${json}    "${key}": ${value}
