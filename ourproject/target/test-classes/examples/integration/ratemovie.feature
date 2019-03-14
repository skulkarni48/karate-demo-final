Feature: End to End Integration test to validate add/delete Rating of a given movie

  #  Add and delete rating for given movie
  # 1. Assuming customer has api_key and for given movie id has no rating for this guest session id and api_key
  # 2. first get Guest Session id
  # 3. Add rating for the movie by, posting request to 'movie/<<movie id>>/rating' end point, with ratings
  # 4. Verify rating added for that movie and guest session using this end point 'guest_session/<<guest session id>>/rated/movies'
  # 5. Now delete rating for that movie and guest session id
  # 6. Verify rating removed for that movie

  Background:

    * def api_baseurl = themoviedburl
    * def api_version = api_version_old
    * def api_key = api_access_key

    * url 'https://api.themoviedb.org/3'
    * def movie_id = 11
    * configure retry = { count: 3, interval: 5000 }

  Scenario: Get Guest session

    # Step 2: Get Guest session and verify response time
    # url:  https://api.themoviedb.org/3/authentication/guest_session/new
    Given url api_baseurl
    And path api_version
    And path 'authentication'
    And path 'guest_session'
    And path 'new'
    And param api_key = api_key
    When method get
    Then status 200
    And assert responseTime < 1000
    And match response contains { "guest_session_id":'#notnull'}

    * def guest_session_id = response.guest_session_id
    * print 'guest session id : ' + guest_session_id


    # url: https://api.themoviedb.org/3/guest_session/<<guest session id>>/rated/movies
    # Validate our assumption, Check currently for this guest session no movie rated
    Given url api_baseurl
    And path api_version
    And path 'guest_session'
    And path guest_session_id
    And path 'rated'
    And path 'movies'
    And param api_key = api_key
    And param language = 'en-US'
    And param sort_by = 'created_at.desc'
    When method get
    Then status 200
    And  match response ==
    """
      {
        "page": 1,
        "results": [],
        "total_pages": 0,
        "total_results": 0
      }
    """


    # url: https://api.themoviedb.org/3/movie/<movie_id>/rating?api_key=<api_key>&guest_session_id=<guest_session_id>
    # Step 3, post rating for movie id 11 with value 8.5

    Given url api_baseurl
    And path api_version
    And path 'movie'
    And path movie_id
    And path 'rating'
    And param api_key = api_key
    And param guest_session_id = guest_session_id
    And request {'value': 8.5}
    When method post
    Then status 201


    # url: https://api.themoviedb.org/3/guest_session/<<guest session id>>/rated/movies
    # step 4, verify for this guest session movie id 11 rating added

    Given url api_baseurl
    And path api_version
    Given path 'guest_session'
    And path guest_session_id
    And path 'rated'
    And path 'movies'
    And param api_key = api_key
    And param language = 'en-US'
    And param sort_by = 'created_at.desc'
    And retry until responseStatus == 200 && response.results[0].id == 11
    When method get
    Then status 200
    And match response.results[0] contains
    """
  {
    id : 11,
    original_title : "Star Wars",
    title : "Star Wars",
  }
    """

    # https://api.themoviedb.org/3/movie/{movie_id}/rating?api_key=<api_key>
    # Step 5, delete rating for that movie

    Given url api_baseurl
    And path api_version
    And path 'movie'
    And path movie_id
    And path 'rating'
    And param api_key = api_key
    And param guest_session_id = guest_session_id
    When method delete
    Then status 200


    # url: https://api.themoviedb.org/3/guest_session/<<guest session id>>/rated/movies
    # step 6, verify for this guest session movie id 11 rating deleted

    Given url api_baseurl
    And path api_version
    And path 'guest_session'
    And path guest_session_id
    And path 'rated'
    And path 'movies'
    And param api_key = api_key
    And param language = 'en-US'
    And param sort_by = 'created_at.desc'
    When method get
    Then status 200
    And  match response ==
    """
      {
        "page": 1,
        "results": [],
        "total_pages": 0,
        "total_results": 0
      }
    """



