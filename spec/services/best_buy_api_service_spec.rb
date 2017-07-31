require 'rails_helper'

describe BestBuyApiService do
  attr_reader :service
  before(:each) do
    @service = BestBuyApiService
  end
  it "searches" do
    VCR.use_cassette("services/best_buy_search") do
      search = service.search({zip: 80202})
      expect(search.count).to eq(17)
    end
  end
end
