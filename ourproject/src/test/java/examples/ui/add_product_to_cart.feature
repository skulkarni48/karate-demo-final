Feature: Add 2 products to cart

  ## FIXME: Split single scenario into multiple scenarios
  ## 1. Verify just login functionality
  ## 2. Verify can navigate to product details page
  ## 3. Verify Adding product displays to cart with number of products added
  ## 4. Verify reloading page, does not affect number of products in cart
  ## 5. Add scenarios for Desktop, mobile and table view
  ## 6. Check for browser compatibility
  
  ## I Tried implementing above way, but Karate UI support still flaky and is in progress, once its stable,
  ## we should refactor below script as abobe  


  Background:
    #* configure driver = { type: 'chrome' }
    #* configure retry = { count: 10, interval: 5000 }
    * def baseurl = SauceBaseUrl
    * def username = sauceuser
    * def password = saucepassword
    * def view_size = desktop_view

    #* print 'username : ' + username
    #* print 'password : ' + password
    #* print 'view : ' + view_size
    #* print 'base url :' + baseurl


  Scenario: For desktop view login to sauce demo and add 2 products to cart

    #Given driver 'https://www.saucedemo.com/'

    Given driver baseurl
    #And driver.dimensions = view_size

    # provide login credentials
    And driver.input('#user-name', username)
    And driver.input('#password', password)

    # when  customer clicks submit and if login successful, should see 'Swag Labs'
    When driver.submit("input[type=submit]")
    Then match driver.text('.header_label') == 'Swag Labs'

    # Add 'Sauce Labs Onesie' to cart
    #When driver.refresh()
    And driver.click('#item_2_title_link')
    Then match driver.text('.inventory_details_name') == 'Sauce Labs Onesie'
    And driver.click('.add-to-cart-button')
    And driver.refresh()

    #verify cart shows 1 product added
    And match driver.text('.fa-layers-counter.shopping_cart_badge') contains '1'

    # Go back to main menu and add 'Sauce Labs Bike Light'
    When driver.click('.inventory_details_back_button')
    Then match driver.text('.header_label') == 'Swag Labs'

    When driver.click('#item_0_title_link')
    Then match driver.text('.inventory_details_name') == 'Sauce Labs Bike Light'
    And driver.click('.add-to-cart-button')
    And driver.refresh()

    # Verify 2 product added to cart
    And match driver.text('.fa-layers-counter.shopping_cart_badge') contains '2'

    # As a proof of 2 product added take screenshot and for manual testing
    * def bytes = driver.screenshot()
    * eval karate.embed(bytes, 'image/png')
