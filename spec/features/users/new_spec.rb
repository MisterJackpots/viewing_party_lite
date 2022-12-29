require 'rails_helper'

RSpec.describe 'The User registration' do
  describe 'As a User' do
    describe 'When I visit the User Registration Page' do
      before(:each) do
        @user1 = User.create!(name: 'Mary', email: 'mary@gmail.com', password: 'password123', password_confirmation: 'password123')
        @user2 = User.create!(name: 'Larry', email: 'larry@hotmail.com', password: 'password123', password_confirmation: 'password123')
        @user3 = User.create!(name: 'Sherri', email: 'sherri@aol.com', password: 'password123', password_confirmation: 'password123')
      end
      it 'I see a link to create a new user' do
        visit root_path
        click_button('Create User')
        expect(current_path).to eq(register_path)

        fill_in 'Name', with: 'Martin'
        fill_in 'Email', with: 'martin31@gmail.com'
        fill_in 'Password', with: 'password123'
        fill_in 'Password confirmation', with: 'password123'
        click_on 'Create Account'

        expect(current_path).to eq("/users/#{User.last.id}")
        expect(page).to have_content("Martin")
        expect(page).to_not have_content("Larry")
        expect(page).to_not have_content("Mary")
        expect(page).to_not have_content("Sherri")
      end

      it "checks for unique email address" do
        visit root_path

        click_button('Create User')

        fill_in 'Name', with: "Mary"
        fill_in 'Email', with: "Mary@gmail.com"
        fill_in 'Password', with: 'password123'
        fill_in 'Password confirmation', with: 'password123'
        click_on 'Create Account'

        expect(current_path).to eq(register_path)
        expect(page).to have_content("Error: Email already linked with an account")
      end

      it "checks for matching passwords" do
        visit root_path

        click_button('Create User')

        fill_in 'Name', with: "NewName"
        fill_in 'Email', with: "newemail@gmail.com"
        fill_in 'Password', with: 'password123'
        fill_in 'Password confirmation', with: 'notsamepassword'
        click_on 'Create Account'

        expect(current_path).to eq(register_path)
        expect(page).to have_content("Error: Password and confirmation must match")
      end
    end
  end
end
