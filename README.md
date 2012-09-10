adcloud_sdk
===========

This is the official Adcloud API SDK. If you have any problems or requests please contact api@adcloud.com

Configuration
-------------

    Adcloud.configure do |c|
      c.client_id = '1234567890'
      c.client_secret = '09876543'
    end

Enable debug mode to log requests

    Adcloud.configure do |c|
      c.debug = true
    end

Authentication
--------------

Usually you wont need to do this, as the gem authenticates against the api by
itself. But if you wanna play with the API yourself, this might come in handy to
get a valid auth token.

    adcloud_auth = Adcloud::Authentication.new(:client_id => Adcloud.config.client_id, :client_secret => Adcloud.config.client_secret)
    adcloud_auth.authenticate!
    adcloud_auth.token

Campaign
--------

### Fetch campaigns list

Read all campaigns which belong to your account

    Adcloud::Campaign.all

If the list gets too long, you can paginate and filter it. Provide a hash of
filter criteria as the first parameter:

    Adcloud::Campaign.all({:status => true})

Available filter keys are:

    company, country, customer, delivery_type, destination, managed, name,
    product, status, type

Optionally set the page and page size as second and third parameter

    Adcloud::Campaign.all({}, page, per_page)
    Adcloud::Campaign.all({:status => true}, 2, 10)

Creating a New Campaign Object

    campaign = Adcloud::Campaign.new({x=>x,y=>y,z=>z})

### Read a single campaign

    Adcloud::Campaign.find_by_id(42)

### Validate a campaign

    campaign = Adcloud::Campaign.new({ x: 1, y: 2, z: 3})
    campaign.valid? # returns true/false

### Create a new campaign

Create a campaign by calling ```create``` on an initialized object. It will
return true when the campaign was created successfully and sets the id on the
object. Otherwise ```errors``` would provide you with the reason why it failed.

    campaign = Adcloud::Campaign.new({ x: 1, y: 2, z: 3})
    campaign.create # returns a boolean
    campaign.errors

Alternatively, you could use the static method

    campaign = Adcloud::Campaign.create({ x: 1, y: 2, z: 3})


Customer
--------

Get all customers

    Customer.all

Get a customer object

    Customer.find(42)

Create a customer object

    Customer.create({:name => "AdKlaus"})


Advertisement
-------------

Read all advertisement objects

    Adcloud::Advertisement.all

Filtering

    Adcloud::Advertisement.all({:active => true})

Available filter keys are:

* campaign
* product
* active

Pagination

    Adcloud::Advertisement.all({}, page, per_page)
    Adcloud::Advertisement.all({:status => true}, 2, 10)

Read/Find a advertisement

    Adcloud::Advertisement.find_by_id(42)

Create/Write a new advertisement

    advertisement = Adcloud::Advertisement.new({x=>x,y=>y,z=>z})
    advertisement.create({x=>x,y=>y,z=>z})

Topic
-----

Read all topics

    topics = Adcloud::Topic.all

And a single topic

    topic = Adcloud::Topic.find(123)

Topics provide their name in various languages

    topic.names['en_gb'] # english name
    topic.names['de_de'] # german name
    ...

Prices, reach, discounts are provided for each country

    topic.discounts['gb'] # Values for England
    topic.discounts['de'] # Values for Germany


TODO
----

* Create Customer
* Update Campaign
* Create Ads
* Update Ads
* Create Attachments for Ads
* Update Attachments for Ads
* Read Reports
* Get Topics (Reach and Price)
  * Not sure how the Reports are transported (Stream, File, ...)
* Filtering
* All customers


Authors
-------

* Jan Kus
* Maximilian Schulz
* Michael Bumann