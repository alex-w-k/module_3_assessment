### 1. Create an API

# For this challenge clone [Storedom](https://github.com/turingschool-examples/storedom).

# We need an API for the application that can both read and write data. Start by focusing on functionality for items. All of this should happen in a dedicated, versioned controller.

# When I send a GET request to `/api/v1/items`
# I receive a 200 JSON response containing all items
# And each item has an id, name, description, and image_url but not the created_at or updated_at

# When I send a GET request to `/api/v1/items/1`
# I receive a 200 JSON response containing the id, name, description, and image_url but not the created_at or updated_at

# When I send a DELETE request to `/api/v1/items/1`
# I receive a 204 JSON response if the record is successfully deleted

# When I send a POST request to `/api/v1/items` with a name, description, and image_url
# I receive a 201 JSON  response if the record is successfully created
# And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at

# * Verify that your non-GET requests work using Postman or curl. (Hint: `ActionController::API`). Why doesn't the default `ApplicationController` support POST and PUT requests?

require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/items' do
    get '/api/v1/items'
    create_list(:item, 5)

    expect(response).to be_success

    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(5)
    expect(item).to have_key('id')
    expect(item).to have_key('name')
    expect(item).to have_key('description')
    expect(item).to have_key('image_url')
    expect(item).to not_have_key('created_at')
    expect(item).to not_have_key('updated_at')
  end

  context 'GET /api/v1/items/1' do
    get '/api/v1/items/1'

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item).to have_key('id')
    expect(item).to have_key('name')
    expect(item).to have_key('description')
    expect(item).to have_key('image_url')
    expect(item).to not_have_key('created_at')
    expect(item).to not_have_key('updated_at')
  end

  context 'DELETE /api/v1/items/1' do
    response.code.should eql(204)
  end
end
