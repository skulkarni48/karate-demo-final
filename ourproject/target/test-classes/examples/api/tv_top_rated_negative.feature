Feature: Verify Negative Scenarios for Api Verion: 3 , GET /tv/top_rated


  Background:

    # get config values

    * def api_baseurl = themoviedburl
    * def api_version = api_version_old
    * def api_key = api_access_key

    # common steps for each scenario


  Scenario: Invalid API Key, should return 401

    Given url api_baseurl
    And path api_version
    And path 'tv'
    And path 'top_rated'
    And param api_key = '1234'
    And param language = 'en-US'
    And param page = '1'
    When method get
    Then status 401
    And assert responseTime < 1000


  Scenario: Invalid Request Params

    Given url api_baseurl
    And path api_version
    And path 'tv'
    And path 'top_rated'
    And param api_key = api_key
    And param language = 'en-US'
    And param page = '100'
    When method get
    Then status 200
    And assert responseTime < 1000

    * def myresults2 = response.results
    * print 'myresults2: ' + myresults2


    # Invalid page number, returns results with empty array

    Given url api_baseurl
    And path api_version
    And path 'tv'
    And path 'top_rated'
    And param api_key = api_key
    And param language = 'en-US'
    And param page = '100'
    When method get
    Then match response ==
    """
      {"page":100,"total_results":696,"total_pages":35,"results":[]}
    """


  Scenario: Invalid URL, should return 404

    Given url api_baseurl
    And path api_version
    And path 'tv'
    And path 'my_top_rated'
    And param api_key = api_key
    And param language = 'en-US'
    And param page = '1'
    When method get
    Then status 404
    And assert responseTime < 1000