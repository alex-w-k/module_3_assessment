require 'rails_helper'

# As a user
# When I visit "/"
# And I fill in a search box with "80202" and click "search"
# Then my current path should be "/search" (ignoring params)
# And I should see stores within 25 miles of 80202
# And I should see a message that says "17 Total Stores"
# And I should see exactly 10 results (There are 17 stores within 25 miles. We want to display 10 on this page and 7 on the next. Get the first page to work first from start to finish and worry about pagination later.)
# And I should see the long name, city, distance, phone number and store type for each of the 10 results
#
describe 'searching by zipcode' do
  context 'When I visit /' do
    context 'and I fill in a searchox with "80202" and click "search"' do
      it 'should redirect to "/search?zip=80202" and I should see 17 total stores within 25 miles of 80202 and 10 on the first page' do
        VCR.use_cassette('best_buy_feature_search_v2') do
          visit root_path

          within('.search') do
            fill_in "zip", with: '80202'
            click_on 'Search'
          end

          expect(current_path).to eq('/search')
          
          expect(page).to have_selector('.result', count: 10)
          expect(page).to have_content('Name:')
          expect(page).to have_content('Type:')
          expect(page).to have_content('Distance:')
          expect(page).to have_content('Phone:')
          click_on 'Next →'
          expect(page).to have_selector('.result', count: 7)
        end
      end
    end
  end
end
