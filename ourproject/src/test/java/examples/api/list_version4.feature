Feature: Verify List Api Version 4

  Background:

    * def api_baseurl = themoviedburl
    * def api_version = api_version_new
    * def api_key = api_access_key
    * def api_token = api_token
    * def list_id = 1
    * call read('../common/common.feature')


    * def req_headers = {Content-Type: 'application/json;charset=utf-8', Authorization: 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNzVmMGZhNTk3YWFhMWNiMjY3NWRmYzM3YmRjMjk4YSIsInN1YiI6IjVjODQzNTgzMGUwYTI2NDMxNDYzNmU2NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IeZVUT_NknohlhysU6tZypWjLVPmYCQTSNVlUPKK5HU'}

    * def req_invalid_headers = {Content-Type: 'application/json;charset=utf-8', Authorization: 'Bearer 3480f47d4051fb3a4d193f5c417fce51c580157f'}


    * def req_invalid_json_headers = {Content-Type: 'application/json;charset=utf-8', Authorization: 'Bearer eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNzVmMGZhNTk3YWFhMWNiMjY3NWRmYzM3YmRjMjk4YSIsInN1YiI6IjVjODQzNTgzMGUwYTI2NDMxNDYzNmU2NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IeZVUT_NknohlhysU6tZypWjLVPmYCQTSNVlUPKK5HU'}


  Scenario: GET List for list_id = 1

     #url 'https://api.themoviedb.org/4/list/1?page=1&api_key=f75f0fa597aaa1cb2675dfc37bdc298a'
    Given headers req_headers
    And url api_baseurl
    And path api_version
    And path 'list'
    And path list_id
    And param page = 1
    And param api_key = api_key
    When method get
    Then status 200
    And match response contains
    """
  {
     total_results: 49,
     total_pages:3,
     name:The Marvel Universe,
     public:true,
  }
    """
    * assert responseTime < max_list_response_time()


  Scenario: Create List with valid token

    #url 'https://api.themoviedb.org/4/list'
    Given headers req_headers
    And url api_baseurl
    And path api_version
    And path 'list'
    And request {  "name": "My Cool List", "iso_639_1": "en" }
    When method post
    Then status 401
    And match response ==
    """
      {
        "status_code": 36,
        "status_message": "This token hasn't been granted write permission by the user.",
        "success": false,
        "error_message": "No matching scope found."
      }
    """
    * assert responseTime < max_list_response_time()



  Scenario: Create List with invalid token

    #url 'https://api.themoviedb.org/4/list'
    Given headers req_invalid_headers
    And url api_baseurl
    And path api_version
    And path 'list'
    And request {  "name": "My Cool List", "iso_639_1": "en" }
    When method post
    Then status 401
    And match response ==
    """
      {
        "status_code": 36,
        "status_message": "This token hasn't been granted write permission by the user.",
        "success": false,
        "error_message": "Invalid token"
      }
    """
    * assert responseTime < max_list_response_time()



  Scenario: Create List with invalid token

    #url 'https://api.themoviedb.org/4/list'
    Given headers req_invalid_json_headers
    And url api_baseurl
    And path api_version
    And path 'list'
    And request {  "name": "My Cool List", "iso_639_1": "en" }
    When method post
    Then status 401
    And match response ==
    """
      {
        "status_code": 36,
        "status_message": "This token hasn't been granted write permission by the user.",
        "success": false,
        "error_message": "Invalid json "
      }
    """
    * assert responseTime < max_list_response_time()

