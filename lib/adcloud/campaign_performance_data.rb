module Adcloud
  class CampaignPerformanceData < Adcloud::Entity
    include Virtus

    attribute :_meta, Hash
    attribute :items, Array[Adcloud::CampaignPerformanceDataEntry]

    def self.find_by_campaign_ids(campaign_ids)
      result = connection.get(self.api_endpoint, { :campaign_ids => campaign_ids.join(',') })
      self.new(result)
    end

  end
end