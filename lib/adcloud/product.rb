module Adcloud
  class Product < Adcloud::Entity
    attribute :id, Integer
    attribute :name, String
    attribute :customer_id, Integer
    attribute :default_prio, Integer
    attribute :modified, DateTime
    attribute :created, DateTime
  end
end