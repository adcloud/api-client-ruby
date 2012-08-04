# adcloud_sdk

This is the official Adcloud API SDK. If you have any problems or requests please contact api@adcloud.com

# Authors

* Jan Kus
* Maximilian Schulz
* Michael Bumann

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
* Get Topics (Reach and Price)
  * Not sure how the Reports are transported (Stream, File, ...)
*.must_equal => Create another engine for adklaus-push-updates
* Filtering
* All customers
* All campaigns
* Push to Campaign (e.g. update a status etc.)

# Configuration

    Adcloud.configure do |c|
      c.client_id="1234567890"
      c.client_secret = "09876543"
    end

# Authentication

    adcloud_auth = Adcloud::Authentication.new(:client_id => Adcloud.config.client_id, :client_secret => Adcloud.config.client_secret)
    adcloud_auth.authenticate!
    adcloud_auth.token

# Customer

# Create a customer object

    Customer.create({:name => "AdKlaus"})

# Get a customer object

    Customer.find_by_id(42)

# Campaign

## Read all Campaign objects

    Adcloud::Campaign.all

### Filtering

    Adcloud::Campaign.all({:status => true})

Available filter keys are:

* status
* customer
* company
* name _Provide a search string_
* country
* product
* type
* destination
* delivery_type
* managed

### Pagination

    Adcloud::Campaign.all({}, page, per_page)
    Adcloud::Campaign.all({:status => true}, 2, 10)

## Creating a New Campaign Object

    campaign = Adcloud::Campaign.new({x=>x,y=>y,z=>z})

## Read/Find a campaign

    Adcloud::Campaign.find_by_id(42)

## Validating a campaign

    campaign = Adcloud::Campaign.new({x=>x,y=>y,z=>z})
    campaign.validate
    campaign.valid?

## Create/Write a new campaign

    campaign.create({x=>x,y=>y,z=>z})
    campaign.errors

# Advertisement

## Read all advertisement objects

    Adcloud::Advertisement.all

### Filtering

    Adcloud::Advertisement.all({:active => true})

Available filter keys are:

* campaign
* product
* active

### Pagination

    Adcloud::Advertisement.all({}, page, per_page)
    Adcloud::Advertisement.all({:status => true}, 2, 10)

## Read/Find a advertisement

    Adcloud::Advertisement.find_by_id(42)

## Create/Write a new advertisement

    advertisement = Adcloud::Advertisement.new({x=>x,y=>y,z=>z})
    advertisement.create({x=>x,y=>y,z=>z})