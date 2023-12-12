require 'rails_helper'

RSpec.describe 'User Login', type: :feature do
  before :each do 
    @user = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
  end

  it 'does not log in with invalid credentials' do
    visit login_path

    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "wrongpassword"

    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid email or password")
  end

  it 'logs in with valid credentials' do
    visit login_path

    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "password"

    click_button "Log In"

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content("User One")
  end
end