Feature: Verify Api Verion: 3 , GET /tv/top_rated


  Background:

    # get config values

    * def api_baseurl = themoviedburl
    * def api_version = api_version_old
    * def api_key = api_access_key

    # common steps for each scenario

    Given url api_baseurl
    And path api_version
    And path 'tv'
    And path 'top_rated'
    And param api_key = api_key
    And param language = 'en-US'
    And param page = '1'
    When method get

  Scenario: Verify '3/tv/top_rated' end point for successful response code (200) and response time under limit (1000 ms)

    # url 'https://api.themoviedb.org/3/tv/top_rated'
    # check response code and time

    Then status 200
    And assert responseTime < 1000



  Scenario: Verify schema of the response

    Then match response contains {results: '#array'}
    And match response ==
    """
      {
        total_results: '#notnull',
        total_pages: '#notnull',
        results: '#notnull',
        page: '#notnull',
        page: '#number',
        total_results: '#number',
        total_pages: '#number',
        results: '#array'
      }
    """


    ## store results , to verify detail results schema

    * def api_results = response.results
    * def first_genre = response.results[0]
    #* print 'Result is: ' + api_results
    #* print 'First genre: ' + first_genre


    # verify results schema

    Then match first_genre contains { "original_name": '#string', genre_ids: '#array', name: '#string', popularity: '#number', origin_country: '#array', vote_count: '#number', original_language: '#string', first_air_date: '#string', backdrop_path: '#notnull', id: '#number', vote_average: '#number', overview: '#string', poster_path: '#string' }


    # Verify results array size for first genre

    Then match api_results == '#[20]'


  Scenario Outline: Check values of first genre in results

    Then match response contains {results: '#array'}
    And match response.results[0] contains
    """
  {
    original_name: '#string',
    name: '#string',
    overview: '#string'
  }
    """

    Examples:
      | 'I Am Not an Animal' |
      | 'I Am Not an Animal' |
      | 'I Am Not An Animal is an animated comedy series about the only six talking animals in the world, whose cosseted existence in a vivisection unit is turned upside down when they are liberated by animal rights activists.' |


