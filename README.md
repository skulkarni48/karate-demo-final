# karate-demo

## Demo of Web API testing using Karate Framework 

### Objective

    1. Whole team should be able to contribute (Technical and Business People)
    2. Support Continuous integration  
    3. Able to maintain it, expand it easily and fast
    4. Small learning curve 
    5. Tool should support all requirements and support advance technologies 
    6. Produce reports, test coverage
    7. Give meaningful detail info when test failed and easy to debug
    8. Open source 
    9. Performance testing 
    10. Easy to add mock/stubs 
    11. Able to configure automation suite as per environment (staging/integration/prod)
    12. Configure to run tests in parallel
    13. Able to cover majority positive, negative and boundary conditions

Reference : <a href="https://github.com/intuit/karate">Karate-framework</a> 

### Example test covers 

    1. Verify HTTP response codes 
    2. Verifying performance of API
    3. Verify schema of API response
    4. Verify value in json response 
    5. Generate report after test execution
    6. Dynamically constructed next requests from response data (yes our tests should be independent but at at same time need to balance how many API requests you want to send, because as your suite expand and team grows it might slow down/overload whole testing system or suite might take longer time to finish, so this features helps solving that issue)  
    7. Failing one scenario does not stop the execution of a script
    8. Building mock server and writing tests using that mock server.
    9. Setup common environment variable
    10. Use common helper methods, across scripts
    11. Take screenshot for UI tests
    12. add tag to ignore script
    13. Add easy configuration to adjust driver for UI test
    14. Add easy configuartion to adjust resolution for mobile/tablet/desktop view
    
    
 # Getting Started
Karate requires [Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html) 8 (at least version 1.8.0_112 or greater) and then either [Maven](http://maven.apache.org), [Gradle](https://gradle.org) or [Eclipse](#eclipse-quickstart) to be installed.

## Maven


Clone this repo and import project as maven project. 

Karate is designed so that you can choose between the [Apache](https://hc.apache.org/index.html) or [Jersey](https://jersey.java.net) HTTP client implementations.


So you need two `<dependencies>`:

```xml
<dependency>
    <groupId>com.intuit.karate</groupId>
    <artifactId>karate-apache</artifactId>
    <version>0.9.1</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>com.intuit.karate</groupId>
    <artifactId>karate-junit4</artifactId>
    <version>0.9.1</version>
    <scope>test</scope>
</dependency>
```

And if you run into class-loading conflicts, for example if an older version of the Apache libraries are being used within your project - then use `karate-jersey` instead of `karate-apache`.

If you want to use [JUnit 5](#junit-5), use `karate-junit5` instead of `karate-junit4`.


You can use Eclipse or IntelliJ to run script, need to add cucumber plugin to run scripts. (Assumption JAVA_HOME path/environment variable is setup and pointing to jdk 1.8, similarly MAVEN_HOME path is setup. )


# Folder structure 

All tests are kept under "ourproject/src/test/java/examples/" folder
There are 4 folders

    1. api         : Which covers api test for tv top rated api with positive and netagive test cases, here we are actually hitting their server
    2. integration :  It gives example of End to End API Integration test to validate add/delete Rating of a given movie
    3. mock        : Its example covering mock response for creating guest session end point, in this example script is heating mock server end point. 
    4. ui          : Its browser integration test, currently its configured to use chrome driver. 
    
    
# api, integration and mock folder cover first assignment problem. 
# add_product_to_cart.feature from UI folder, covers second assignment problem.


# All common configuartions stored at karate-config.js file

    themoviedburl: 'https://api.themoviedb.org',
    api_version_old: 3,
    api_version_new: 4,
    api_access_key: '',
    SauceBaseUrl: 'https://www.saucedemo.com/',
    sauceuser: 'standard_user',
    saucepassword: 'secret_sauce',
    desktop_view: { left: 0, top: 0, width: 800, height: 700 },
    tablet_view: { left: 0, top: 0, width: 600, height: 600 }
    
    
    To run api scripts, please provide api_access_key from themoviedb in this file. You can control api version in this file. 
    
    Also for suace demo website you can provide username and password redentials here. Similarly for browser tests, you can control resolution by editing desktop view and tablet view. 
    
    
## You can run api, ui and integration as regular script using intellij and eclipse ide. For browser test assumes location of chrome on mac : /Applications/Google Chrome.app/Contents/MacOS/Google Chrome , or on windows: C:/Program Files (x86)/Google/Chrome/Application/chrome.exe. If you dont have please have it. For more details you can refere here: https://github.com/intuit/karate/tree/master/karate-core


## Run Mock server and scripts

* Either download the latest version of the JAR file from [Bintray](https://dl.bintray.com/ptrthomas/karate/), and it will have the name: `karate-<version>.jar`. Rename it to karate.jar. Or you can used from mock folder. 
* cd into mock directory, start the mock server with the command:
  * `java -jar karate.jar -m guestsession-mock.feature -p 8080`
* To see how this is capable of backing an HTML front-end, download this file: 'guestsession.html. Open it in a browser and you will be able to `POST` data. Browse to [`http://localhost:8080/guestsession`](http://localhost:8080/guestsession) - to see the saved data (state).
* To run test creating guest session creation end point using mock server, run the command (in a separate console / terminal):
  * `java -jar karate.jar guestsession-test.feature`
* You will see HTML reports in the `target/cucumber-html-reports` directory

## Usage
### Help
You can view the command line help with the `-h` option:
```
java -jar karate.jar -h
```

### Mock Server
To start a mock server, the 2 mandatory arguments are the path of the feature file 'mock' `-m` and the port `-p`

```
java -jar karate.jar -m my-mock.feature -p 8080
```

### Report

After script execution reports are created in HTML format file. You can get logs and readable results under "ourproject/target/surefire-reports/" folder with script name. 
