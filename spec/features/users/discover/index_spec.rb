require 'rails_helper'

RSpec.describe 'The Discover Movies Page' do
  describe 'As a User' do
    describe 'When I visit the Discover Movies Page' do
      before(:each) do
        @user1 = User.create!(name: 'Mary', email: 'mary@gmail.com', password: 'password123', password_confirmation: 'password123')
        @user2 = User.create!(name: 'Larry', email: 'larry@hotmail.com', password: 'password123', password_confirmation: 'password123')
        @user3 = User.create!(name: 'Sherri', email: 'sherri@aol.com', password: 'password123', password_confirmation: 'password123')
      end

      it "displays a button to 'Find Top Rated Movies'" do
        visit user_discover_index_path(@user1)

        expect(page).to have_button('Find Top Rated Movies')

        click_button('Find Top Rated Movies')

        expect(current_path).to eq(user_movies_path(@user1))
      end

      it 'displays a search field and submit button to find movies by keyword' do
        visit user_discover_index_path(@user1)

        expect(page).to have_field('Search by Movie Title')

        fill_in 'Search by Movie Title', with: 'Boogie Nights'
        click_button('Find Movies')

        expect(current_path).to eq(user_movies_path(@user1))
      end
    end
  end

end
