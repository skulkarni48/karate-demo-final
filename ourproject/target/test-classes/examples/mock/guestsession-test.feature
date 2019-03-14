Feature: Mock guest session end point 'authentication/guest_session/new'


Background:

    ## FIXME move below configurations to karate-config.js

    * def port = 8080
    * url 'http://localhost:' + port + '/guestsession'
	

Scenario: create guest_session_id

    Given request { api_key : '1234'}
	When method post
    Then status 200    
    And match response contains { "success":true, guest_session_id: '#uuid', expires_at: '#notnull' }
    And def guest_session_id1 = response.guest_session_id

    # verify for given session id, we get only given guest session id record
    # url: http://localhost:8080/guestsession/<<guest_session_id>>
    Given path guest_session_id1
    When method get
    Then status 200
    And match response contains { "success":true, guest_session_id: '#uuid', expires_at: '#notnull' }


    # verify for guestsession, maintaining already inserted guest session id
    # url: http://localhost:8080/guestsession

    When method get
    Then status 200
  	And match response contains [{ "success":true, guest_session_id: '#(guest_session_id1)', expires_at: '#notnull' }]



    ## add one more guest session id

	Given request { api_key: '12345' }
    When method post
    Then status 200    
    And match response contains { "success":true, guest_session_id: '#uuid', expires_at: '#notnull' }
    And def guest_session_id2 = response.guest_session_id

    # verify second guest session id added
    Given path guest_session_id2
    When method get
    Then status 200
     And match response contains { "success":true, guest_session_id: '#uuid', expires_at: '#notnull' }


    # verify for guestsession, now returns 2 records of session id
    # url: http://localhost:8080/guestsession

    When method get
    Then status 200
    And match response contains [{ "success":true, guest_session_id: '#(guest_session_id1)', expires_at: '#notnull' },{ "success":true, guest_session_id: '#(guest_session_id2)', expires_at: '#notnull' }]


    # Delete guest session id

    Given request { guest_session_id: '#(guest_session_id2)' }
    When method delete
    Then status 200




   
   