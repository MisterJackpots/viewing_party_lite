require 'rails_helper'

RSpec.describe 'The Movies Index Page' do
  describe 'As a User' do
    describe 'When I visit the Discover Movies Index Page' do
      describe "And click on the 'Find Top Rated Movies' button" do
        before(:each) do
          @user1 = User.create!(name: 'Mary', email: 'mary@gmail.com', password: 'password123', password_confirmation: 'password123')
          visit user_discover_index_path(@user1)
          click_button('Find Top Rated Movies')
        end
        it 'redirects to the Movies Index Page' do
          expect(current_path).to eq(user_movies_path(@user1))
        end

        it 'displays 20 top rated movies' do
          expect(page).to have_content('Parasite')
          expect(page).to have_content('Shawshank Redemption')
          expect(page).to_not have_content('Boogie Nights')
        end

        it "has the 'Vote Average' next to each movie title" do
          parasite_id = 496243

          within "#voting_average_#{parasite_id}" do
            expect(page).to have_content("Vote Average: 8.5")
          end
        end

        it 'has each movie title as a link to its show page' do
          expect(page).to have_link('Parasite')

          click_link('Parasite')

          expect(current_path).to eq(user_movie_path(@user1, 496243))
        end
      end

      describe "And use the 'Find Movies' search function" do
        before(:each) do
          @user1 = User.create!(name: 'Mary', email: 'mary@gmail.com', password: 'password123', password_confirmation: 'password123')
          visit user_discover_index_path(@user1)

          fill_in 'Search by Movie Title', with: 'jojo'
          click_button('Find Movies')
        end
        it 'redirects to the Movies Index Page' do
          expect(current_path).to eq(user_movies_path(@user1))
        end

        it 'displays 20 movie search results' do
          expect(page).to have_content('Jojo Rabbit')
          expect(page).to have_content('Jojo in the Stars')
          # expect(page).to have_content('On Dolphin Terms: The Story of Dean & JoJo')
        end

        it 'has each movie title as a link to its show page' do
          expect(page).to have_link('Jojo Rabbit')

          click_link('Jojo Rabbit')

          expect(current_path).to eq(user_movie_path(@user1, 515001))
        end

        it "has the 'Vote Average' next to each movie title" do
          jojo_id = 515001

          within "#voting_average_#{jojo_id}" do
            expect(page).to have_content("Vote Average: 8.1")
          end
        end
      end
    end
  end
end
