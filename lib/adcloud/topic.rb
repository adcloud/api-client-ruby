module Adcloud
  class Topic < Entity
    attribute :id, Integer
    attribute :start_prio, Integer
    attribute :modified, DateTime
    attribute :created, DateTime
    attribute :discounts, Hash
    attribute :names, Array[Hash]

    def discounts=(data)
      @discounts = data.reduce({}) do |hash, raw_discount|
        discount = TopicDiscount.new(raw_discount)
        hash[discount.country_code] = discount
        hash
      end
    end

    # @return [Hash<String, String>] Locale as key and name as value
    def names=(data)
      @names = data.reduce({}) do |hash, item|
        hash[item['locale']] = item['content']
        hash
      end
    end
  end
end