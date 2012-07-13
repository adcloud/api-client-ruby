# adcloud_sdk

This is the official Adcloud API SDK. If you have any problems or requests please contact api@adcloud.com

# Authors

* Jan Kus
* Maximilian Schulz

# TODO

* OAuth authentication
* Create Customer
* Read Campaigns
* Create Campaign
* Update Campaign
* Create Ads
* Creat Attachments for Ads
* Read Reports
  * Not sure how the Reports are transported (Stream, File, ...)
*.must_equal => Create another engine for adklaus-push-updates
* Create gemspec
* Filtering
* All customers

# Configuration

    AdcloudSdk.configure do |c|
      c.port = 80
      c.protocol = 'https'
      c.host = 'api.adcloud.net'
      c.http_open_timeout = 5
      c.http_read_timeout = 10
      c.debug = true
      # Authentication stuff
      # c.app_key
      # c.app_secret
    end

# Authentication

... (just setup your keys.... see configuration)

# Customer

# Create a customer object

    Customer.create({:name => "AdKlaus"})

# Get a customer object

    Customer.find_by_id(42)

# Campaign

## Read all Campaign objects

    Campaign.all

## Read a Campaign object

    Campaign.find_by_id(42)

## Write a Campaign object

