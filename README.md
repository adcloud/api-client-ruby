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
* Update Ads
* Create Attachments for Ads
* Update Attachments for Ads
* Read Reports
  * Not sure how the Reports are transported (Stream, File, ...)
*.must_equal => Create another engine for adklaus-push-updates
* Filtering
* All customers
* All campaigns
* Push to Campaign (e.g. update a status etc.)

# Configuration

    Adcloud.configure do |c|
      c.app_key = "mykey"
      c.app_secret = "mysecret"
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

