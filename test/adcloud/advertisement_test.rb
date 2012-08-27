# -*- encoding : utf-8 -*-
require 'test_helper'

describe Adcloud::Advertisement do

  it 'should set the correct api endpoint' do
    Adcloud::Advertisement.api_endpoint.must_equal 'advertisements'
  end

  # for more tests checkout entity tests
end
