require 'rails_helper'

RSpec.describe 'landing Page', type: :feature do
  describe 'As a User' do
    describe 'When I visit the Landing Page' do
      before(:each) do
        @user1 = User.create!(name: 'Mary', email: 'mary@gmail.com', password: 'password123', password_confirmation: 'password123')
        @user2 = User.create!(name: 'Larry', email: 'larry@hotmail.com', password: 'password123', password_confirmation: 'password123')
        @user3 = User.create!(name: 'Sherri', email: 'sherri@aol.com', password: 'password123', password_confirmation: 'password123')

        visit root_path
      end

      it 'I see the title of the applications' do
        within('#app_title') do
          expect(page).to have_content 'Viewing Party'
        end
      end

      it 'I see a button to create a new user' do
        within('#user_creation') do
          expect(page).to have_button('Create User')
        end
      end

      it 'I see a list of existing users, as a link to each users dashboards' do
        within('#existing_users') do
          within("#user-#{@user1.id}") do
            expect(page).to have_link("#{@user1.email}'s Dashboard")
            expect(page).to_not have_link("#{@user2.email}'s Dashboard")
            expect(page).to_not have_link("#{@user3.email}'s Dashboard")
          end
          within("#user-#{@user2.id}") do
            expect(page).to have_link("#{@user2.email}'s Dashboard")
            expect(page).to_not have_link("#{@user1.email}'s Dashboard")
            expect(page).to_not have_link("#{@user3.email}'s Dashboard")
          end
          within("#user-#{@user3.id}") do
            expect(page).to have_link("#{@user3.email}'s Dashboard")
            expect(page).to_not have_link("#{@user1.email}'s Dashboard")
            expect(page).to_not have_link("#{@user2.email}'s Dashboard")
          end
        end
      end

      it 'I see a link back to the home page' do
        expect(page).to have_link('Home')
        click_link 'Home'
        expect(page.current_path).to eq root_path
      end
    end
  end
end
