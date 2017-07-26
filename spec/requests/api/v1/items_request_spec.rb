# When I send a POST request to `/api/v1/items` with a name, description, and image_url
# I receive a 201 JSON  response if the record is successfully created
# And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at

# * Verify that your non-GET requests work using Postman or curl. (Hint: `ActionController::API`). Why doesn't the default `ApplicationController` support POST and PUT requests?

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
end
