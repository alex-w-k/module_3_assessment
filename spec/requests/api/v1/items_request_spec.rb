require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/items' do
    it 'sends all items' do
      create_list(:item, 5)
      get '/api/v1/items'

      expect(response).to be_success

      items = JSON.parse(response.body)
      item = items.first

      expect(items.count).to eq(5)
      expect(item).to have_key('id')
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('image_url')
      expect(item).to_not have_key('created_at')
      expect(item).to_not have_key('updated_at')
    end
  end

  context 'GET /api/v1/items/:id' do
    it 'sends one item' do
      create(:item)
      get '/api/v1/items/1'

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item).to have_key('id')
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('image_url')
      expect(item).to_not have_key('created_at')
      expect(item).to_not have_key('updated_at')
    end
  end

  context 'DELETE /api/v1/items/:id' do
    it 'deletes the item requested' do
      item = create(:item)

      delete "/api/v1/items/#{item.id}"

      response.code.should eql('204')
    end
  end
  context 'POST /api/v1/items' do
    it 'adds the items and returns the json of the new item' do

      params = {item: {name: 'new name', description: 'new description', image_url: 'images.network/1.jpg'}}
      post '/api/v1/items', params.to_json, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_success
      
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item[:name]).to eq('new name')
      expect(item[:description]).to eq('new description')
      expect(item[:image_url]).to eq('images.network/1.jpg')

    end
  end
end
