require 'spec_helper'

feature 'Signing in' do
  let!(:user) { User.create(email: 'test@test.com', password: 'test12')}

  scenario 'shows a welcome message' do
    visit('/')
    click_link('sign in')
    fill_in(:email, with: user.email)
    fill_in(:password, with: 'test12')
    click_button('submit')

    expect(page).to have_content("Welcome back, #{user.email}!")
    expect(page.current_path).to have_content('/bookmarks')
  end

  scenario 'shows a message wrong email or password' do
    visit('/')
    click_link('sign in')
    fill_in(:email, with: user.email)
    fill_in(:password, with: "incorrect_password")
    click_button('submit')

    expect(page).to have_content("Your email or password is incorrect")
    expect(page.current_path).to have_content('/sign_in')
  end
end
