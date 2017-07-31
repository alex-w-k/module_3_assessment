require 'rails_helper'

describe 'Store PORO' do
  before(:each) do
    VCR.use_cassette('best_buy_model') do
      @store = Store.new("longName"=>"Cherry Creek Shopping Center",
                "city"=>"Denver",
                "distance"=>3.45,
                "phone"=>"303-270-9189",
                "storeType"=>"Mobile SAS")
    end
  end
  it 'has a type' do
    expect(@store.type).to eq('Mobile SAS')
  end

  it 'has a name' do
    expect(@store.name).to eq('Cherry Creek Shopping Center')
  end

  it 'has a distance' do
    expect(@store.distance).to eq(3.45)
  end

  it 'has a phone number' do
    expect(@store.phone).to eq('303-270-9189')
  end

  it 'can search' do
    VCR.use_cassette('best_buy_model') do
      stores = Store.search({zip: 80202})

      expect(stores.length).to eq(17)
    end
  end
end
