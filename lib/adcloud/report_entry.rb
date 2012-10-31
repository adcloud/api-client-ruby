module Adcloud
  class ReportEntry
    include Virtus

    attribute :date, Date
    attribute :website_id, Integer
    attribute :topic_id, Integer
    attribute :ad_placement_id, Integer
    attribute :product_id, Integer
    attribute :ad_id, Integer
    attribute :campaign_id, Integer
    attribute :page_type, Integer
    attribute :ad_position, Integer
    attribute :ad_count, Integer
    attribute :ad_impressions, Integer
    attribute :clicks, Integer
    attribute :clicks_overdelivered, Integer
    attribute :clicks_filtered, Integer
    attribute :clicks_image, Integer
    attribute :clicks_head, Integer
    attribute :clicks_txt, Integer
    attribute :clicks_link, Integer
    attribute :postview_conversions, Integer
    attribute :postview_conversions_overdelivered, Integer
    attribute :postview_conversions_filtered, Integer
    attribute :cancellations, Integer
    attribute :publisher, String
    attribute :website, String
    attribute :position, String
    attribute :design_id, Integer
    attribute :design, String
    attribute :topic, String
    attribute :ad, String
    attribute :campaign, String
    attribute :product, String
    attribute :ad_impressions_costs, Float
    attribute :clicks_costs, Float
    attribute :postclick_conversions, Integer
    attribute :postclick_conversions_overdelivered, Integer
    attribute :postclick_conversions_filtered, Integer
    attribute :postclick_conversions_costs, Float
    attribute :postview_conversions_costs, Float
    attribute :costs, Float
    attribute :language, String
    attribute :country, String
    attribute :currency, String
  end
end