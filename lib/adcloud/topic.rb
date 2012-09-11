module Adcloud
  class Topic < Entity
    attribute :id, Integer
    attribute :start_prio, Integer
    attribute :modified, DateTime
    attribute :created, DateTime
    attribute :discounts, Hash
    attribute :names, Hash

    def discounts=(data)
      @discounts = data.reduce({}) do |hash, raw_discount|
        discount = TopicDiscount.new(raw_discount)
        hash[discount.country_code] = discount
        hash
      end
    end

  end
end