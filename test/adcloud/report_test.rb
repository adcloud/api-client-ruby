# -*- encoding : utf-8 -*-
require 'test_helper'

describe Adcloud::Report do
  subject { Adcloud::Report }

  let(:connection) { stub }

  describe ".find_by_date" do
    let(:response_data) { { '_meta' => {}, 'items' => [{date: "2012-06-21", website_id: 2369, topic_id: 100, ad_placement_id: 7979, product_id: 20426, ad_id: 44956, booking_id: 88352, page_type: 0, ad_position: 2, ad_count: 3, ad_impressions: 2, clicks: 0, clicks_overdelivered: 0, clicks_filtered: 0, clicks_image: 0, clicks_head: 0, clicks_txt: 0, clicks_link: 0, postview_conversions: 0, postview_conversions_overdelivered: 0, postview_conversions_filtered: 0, cancellations: 0, publisher: "OMS Online Marketing Service GmbH & Co. KG - Germany", website: "rmsi.radioeuskirchen.de", position: "", design_id: 32, design: "LB (728x90) | 3 IHC (90x68)", topic: "Unterhaltung", ad: "Pferdefutter - Bonn", booking: "GT: 176266_catdog_Bonn", product: "176266_catdog_GT", ad_impressions_costs: 0, clicks_costs: 0, postclick_conversions: 0, postclick_conversions_overdelivered: 0, postclick_conversions_filtered: 0, postclick_conversions_costs: 0, postview_conversions_costs: 0, costs: 0, language: "de", country: "DE", currency: "EUR"}] } }

    before do
      subject.stubs(:connection => connection)
      connection.stubs(:get).returns(response_data)
    end

    it 'access the api at the correct path' do
      subject.connection.expects(:get).with('reports/advertiser', { filter: { date: '1981-06-21' } })
      subject.find_by_date(Date.new(1981, 06, 21))
    end

    it 'returns a report' do
      subject.find_by_date(Date.new(1981, 06, 21)).must_be_instance_of(Adcloud::Report)
    end

    it 'creates report entries for all items' do
      subject.find_by_date(Date.new(1981, 06, 21)).items.first.must_be_instance_of(Adcloud::ReportEntry)
    end

    it 'parses the entry data correctly' do
      subject.find_by_date(Date.new(1981, 06, 21)).items.first[:website_id].must_equal 2369
    end
  end
end