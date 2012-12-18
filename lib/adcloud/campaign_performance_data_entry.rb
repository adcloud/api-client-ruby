module Adcloud
  class CampaignPerformanceDataEntry
    include Virtus

    attribute :budget_delivered, Float
    attribute :budget_delivered_today, Float
    attribute :budget_limit_today, Float
    attribute :campaign_id, Integer
    attribute :clicks_delivered, Integer
    attribute :clicks_delivered_today, Integer
    attribute :impressions_delivered, Integer
    attribute :impressions_delivered_today, Integer
    attribute :conversions_delivered, Integer
    attribute :conversions_delivered_today, Integer
    attribute :performance, Float

  end
end