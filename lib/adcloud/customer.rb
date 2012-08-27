module Adcloud
  class Customer < Adcloud::Entity
    attribute :_meta, Hash
    attribute :id, Integer
    attribute :name, Boolean
    attribute :modified, DateTime
    attribute :created, DateTime
  end
end