require 'rails_helper'

describe 'Users' do
  let :user do
    build :user
  end

  subject do
    user
  end

  context 'is invalid' do
    it 'when required #full_name is not given' do
      user.full_name = ''
      should_not be_valid
    end

    it 'when #email is not given' do
      user.email = ''
      should_not be_valid
    end

    it 'when #email format is not valid' do
      user.email = 'incorrect@format'
      should_not be_valid
    end

    it 'when required #password is not given' do
      user.password = ''
      should_not be_valid
    end
     
    it 'when #email is not unique' do
      user.save
      user1 = build(:user)
      user1.save

      user1.should_not be_valid
      expect(user1.errors.full_messages[0]).to  match(/Email has already been taken/)
    end
  end

  context 'GET /users/new' do
    it 'displays the create new user page' do
      visit new_user_path

      expect(page).to have_content('Full Name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Confirm Password')

      expect(page).to have_field('user_full_name')
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_field('user_password_confirmation')
      expect(page).to have_selector(:link_or_button, 'Sign Up')
    end
  end

  context 'GET /signup' do
    it 'displays the signup page' do
      visit signup_path

      expect(page).to have_content('Full Name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Confirm Password')

      expect(page).to have_field('user_full_name')
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_field('user_password_confirmation')
      expect(page).to have_selector(:link_or_button, 'Sign Up')
    end
  end

  context 'POST /users' do
    it 'creates and saves the valid user' do
      visit new_user_path

      fill_in 'Full Name', with: 'Joe Java'
      fill_in 'Email', with: 'joe@java.com'
      fill_in 'Password', with: 'x1234567'
      fill_in 'Confirm Password', with: 'x1234567'
      click_button 'Sign Up'

      expect(current_path).to equal(signup_path)
      expect(page).to have_content('The User is successfully saved!')
    end

    context 'not saving invalid user' do
      it 'when passwords do not match' do
        visit new_user_path

        fill_in 'Full Name', with: 'Joe Java'
        fill_in 'Email', with: 'joe@java.com'
        fill_in 'Password', with: 'x1234567'
        fill_in 'Confirm Password', with: 'x123'
        click_button 'Sign Up'

        expect(current_path).to equal(signup_path)
        expect(page).to have_content('The User is successfully saved!')
      end
    end
  end
end
