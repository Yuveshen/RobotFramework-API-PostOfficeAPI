*** Settings ***
Library  Collections
Library  RequestsLibrary
Resource  ../implementation/api_interaction.robot
Test Template  Post Code Search

*** Test Cases ***                   SUBURB               STATE         POSTCODE
North Rocks postcode is 2151         North Rocks          NSW           2151
Altona Meadows postcode is 3028      Altona Meadows       VIC           3028
Mount Colah postcode is 2079         Mount Colah          NSW           2079
Williamstown postcode is 3016        Williamstown         VIC           3016
Kensington postcode is 3031          Kensington           VIC           3031

*** Keywords ***
Post Code Search
    [Documentation]  This test suite uses a data driven approach to test the auspost postcode search API endpoint
    [Arguments]  ${Suburb}  ${State}  ${ExpectedPostcode}

    ${headers}=    create dictionary      AUTH-KEY=5d5dc400-9405-4f17-9f82-251b69ebbd10
    ${params}=    create dictionary  q=${Suburb}  state=${State}

    Given create api session  postcode_search  https://digitalapi.auspost.com.au/postcode
    When send get request  postcode_search  /search.json  ${headers}  ${params}
    Then json key exists  id
    And json key exists  latitude
    And json key exists  longitude
    And json key equals  postcode  ${ExpectedPostcode}
