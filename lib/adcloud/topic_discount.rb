module Adcloud
  class TopicDiscount
    include Virtus

    attribute :country_id, Integer
    attribute :country_code, String
    attribute :discount, Float
    attribute :reach, Float
    attribute :min_price_cpc, Float
    attribute :price_cpc, Float
    attribute :max_price_cpc, Float
    attribute :min_price_cpm, Float
    attribute :price_cpm, Float
    attribute :max_price_cpm, Float
  end
end