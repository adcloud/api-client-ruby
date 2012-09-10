module Adcloud
  class Topic < Entity
    attribute :id, Integer
    attribute :start_prio, Integer
    attribute :modified, DateTime
    attribute :created, DateTime
    attribute :discounts, Array[TopicDiscount]
    attribute :names, Array[Hash]

    # @return [Hash<String, String>] Locale as key and name as value
    def names=(data)
      @names = data.reduce({}) do |hash, item|
        hash[item['locale']] = item['content']
        hash
      end
    end
  end
end