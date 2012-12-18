# -*- encoding : utf-8 -*-
require 'test_helper'

describe Adcloud::CampaignPerformanceData do
  subject { Adcloud::CampaignPerformanceData }

  let(:connection) { stub }

  describe ".find_by_campaign_ids" do
    let(:response_data) { { "_meta" => {"page" => 1, "per_page" => 2, "size" => 2, "sort" => {}, "total_count" => 2, "total_pages" => 1, "type" => "Array<CampaignPerformanceData>", "uuid" => "542fe08151374ceaf8e97dfbc22d480d"}, "items" => [{"budget_delivered" => 0.0, "budget_delivered_today" => 0.0, "budget_limit_today" => 100.0, "campaign_id" => 101, "clicks_delivered" => 0, "clicks_delivered_today" => 0, "impressions_delivered" => 0, "impressions_delivered_today" => 0, "conversions_delivered" => 0, "conversions_delivered_today" => 0, "performance" => 0.0 }, {"budget_delivered" => 0.0, "budget_delivered_today" => 0.0, "budget_limit_today" => 100.0, "campaign_id" => 102, "clicks_delivered" => 0, "clicks_delivered_today" => 0, "impressions_delivered" => 0, "impressions_delivered_today" => 0, "conversions_delivered" => 0, "conversions_delivered_today" => 0, "performance" => 0.0 } ] } }

    before do
      subject.stubs(:connection => connection)
      connection.stubs(:get).returns(response_data)
    end

    it 'access the api at the correct path' do
      subject.connection.expects(:get).with('campaign_performance_data', { campaign_ids: '101,102' })
      subject.find_by_campaign_ids([101, 102])
    end

    it 'returns a campaign performance data set' do
      subject.find_by_campaign_ids([101, 102]).must_be_instance_of(Adcloud::CampaignPerformanceData)
    end

    it 'creates report entries for all items' do
      subject.find_by_campaign_ids([101, 102]).items.first.must_be_instance_of(Adcloud::CampaignPerformanceDataEntry)
    end

    it 'parses the entry data correctly' do
      subject.find_by_campaign_ids([101, 102]).items.first[:budget_limit_today].must_equal 100.0
    end
  end
end