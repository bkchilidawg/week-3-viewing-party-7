require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One' 
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User two', email: 'notunique@example.com', password: 'password', password_confirmation: 'password')

    visit register_path
    
    fill_in :user_name, with: 'User Two' 
    fill_in :user_email, with:'notunique@example.com'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  describe 'does not create a user if name, email, or passwords are not provided or passwords do not match' do
    it 'does not create a user if name is not provided' do
      visit register_path

      fill_in :user_email, with: 'user@example.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
    end

    it 'does not create if a email is already registered' do   
      visit register_path

      fill_in :user_name, with: 'User' 
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email can't be blank")
    end 

    it "does not create a user if password conformation doesn't match" do
      visit register_path

      fill_in :user_name, with: 'User' 
      fill_in :user_email, with: 'user@example.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'different_password'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end