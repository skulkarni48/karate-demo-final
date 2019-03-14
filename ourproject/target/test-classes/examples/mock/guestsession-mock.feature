Feature: stateful mock server

Background:
* configure cors = true
* def uuid = function(){ return java.util.UUID.randomUUID() + '' }
* def guestsession = {}
* def LocalDateTime = Java.type('java.time.LocalDateTime')	
* def ZoneOffset = Java.type('java.time.ZoneOffset') 
* def DateTimeFormatter = Java.type('java.time.format.DateTimeFormatter')
* def expiryDate = LocalDateTime.now(ZoneOffset.UTC).plusDays(1) + ''

	 
		 
Scenario: pathMatches('/guestsession/{api_key}') && pathParams.api_key == '7659e43c-2e09-475a-9d62-5916c91db7ce'
	 	 * def response = { success: true, guest_session_id: '#(uuid())', expires_at: '#(expiryDate)'  }		 
	 
	 
Scenario: pathMatches('/guestsession') && methodIs('post')
    * def guest = {}
    * def guest_session_id = uuid()
    * set guest.success = true
    * set guest.expires_at = expiryDate
    * set guest.guest_session_id = guest_session_id
    * eval guestsession[guest_session_id] = guest
    * def response = guest


Scenario: pathMatches('/guestsession/{guest_session_id}')
    * def response = guestsession[pathParams.guest_session_id]

	
Scenario: pathMatches('/guestsession')
    * def response = $guestsession.*	
	

Scenario: pathMatches('/guestsession/{guest_session_id}') && methodIs('delete')
    * eval karate.remove('guest', '$.' + pathParams.guest_session_id)
    * def response = ''
	
	
  
	
Scenario:
    # catch-all
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html; charset=utf-8' }
    * def response = <html><body>Not Found</body></html>