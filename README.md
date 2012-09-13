adcloud-api
===========

A little wrapper for the adcloud API. It provides all the required classes and
configuration options to access the adcloud API and interact with it. Moreover,
you can use it to post-process incoming callbacks (implemented via http webhooks).

This is the official ruby gem for the adcloud API. If you have any problems or
requests please contact api@adcloud.com

__Warning__

* API does not yet support Campaign Updates
* API might change until it goes public, so expect changes!


Installation
------------

In order to install the gem, run

    gem install adcloud-api

or if you are using bundler, add the following to your Gemfile

    gem 'adcloud-api'


Configuration
-------------

You always need to provide your adcloud client id and secret. Contact
info@adcloud.com to get an account and credentials.

    Adcloud.configure do |c|
      c.client_id = '1234567890'
      c.client_secret = '09876543'
    end

Enable debug mode to log http requests and setup logging

    Adcloud.configure do |c|
      c.debug = true # default false
      c.logger = Logger.new # defaults to STDOUT or Rails.logger if available
    end

Authentication
--------------

Usually you wont need to do this, as the gem authenticates against the api by
itself. But if you wanna play with the API yourself, this might come in handy to
get a valid auth token.

    adcloud_auth = Adcloud::Authentication.new(
      :client_id => Adcloud.config.client_id,
      :client_secret => Adcloud.config.client_secret)
    adcloud_auth.authenticate!
    adcloud_auth.token # returns an oauth access_token

Advertisement
-------------

Read all advertisement objects

    Adcloud::Advertisement.all

Filtering

    Adcloud::Advertisement.all({ active: true })

Available filter keys are:

* campaign
* product
* active

Pagination

    Adcloud::Advertisement.all(nil, 2, 10)

Read/Find a advertisement

    Adcloud::Advertisement.find_by_id(42)

Create/Write a new advertisement

    advertisement = Adcloud::Advertisement.new({ your: 'attributes' })
    advertisement.create

Campaign
--------

### Fetch campaigns list

Read all campaigns which belong to your account

    Adcloud::Campaign.all

If the list gets too long, you can paginate and filter it. Provide a hash of
filter criteria as the first parameter:

    Adcloud::Campaign.all({ filter_key: 'filter value' })

Available filter keys are:

    company, country, customer, delivery_type, destination, managed, name,
    product, status, type

Optionally set the page and page size as second and third parameter

    Adcloud::Campaign.all({ status: 'online' })
    Adcloud::Campaign.all({ status: 'online' }, 2, 10)

Creating a New Campaign Object

    campaign = Adcloud::Campaign.new({ your: 'attributes' })

### Read a single campaign

    Adcloud::Campaign.find_by_id(42)

### Validate a campaign

    campaign = Adcloud::Campaign.new({ your: 'attributes' })
    campaign.valid? # returns true/false

### Create a new campaign

Create a campaign by calling ```create``` on an initialized object. It will
return true when the campaign was created successfully and sets the id on the
object. Otherwise ```errors``` would provide you with the reason why it failed.

    campaign = Adcloud::Campaign.new({ your: 'attributes' })
    campaign.create # returns a boolean
    campaign.errors

Alternatively, you could use the static method

    campaign = Adcloud::Campaign.create({ your: 'attributes' })

Customer
--------

Get all customers

    Customer.all

Get a customer object

    Customer.find(42)

Create a customer object

    Customer.create({ name: 'AdKlaus' })

Media Files
-----------

Create a new media file with

    Adcloud::MediaFile.create(
      uploaded_file: 'http://yourhost.com/yourfile.ext'
      product_id: 123,
      ad_id: 456,
      flash: false,
      display: false
    end

where ```uploaded_file``` is a publicly accessible url to an image file.

Product
-------

Get all products

    Adcloud::Product.all

Get a single product

    Adcloud::Product.find(123)

Create a new product

    product = Adcloud::Product.create(name: 'Product name', customer_id: 123)
    # or
    product = Adcloud::Product.new(name: 'Product name', customer_id: 123)
    if product.create
        # ...
    else
        puts product.errors.inspect
    end


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

Authors
-------

[Jan Kus](http://github.com/koos),
[Maximilian Schulz](http://github.com/namxam),
[Michael Bumann](http://github.com/bumi)