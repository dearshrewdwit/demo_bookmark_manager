require 'spec_helper'

feature 'Signing out' do
  let!(:user) { User.create(email: 'test@test.com', password: 'test12')}

  scenario 'shows a goodbye message' do
    visit('/')
    click_link('sign in')
    fill_in(:email, with: user.email)
    fill_in(:password, with: 'test12')
    click_button('submit')

    click_button('sign out')
    expect(page).to have_content('sign in')
    expect(page).to have_content('Goodbye, test@test.com!')
    expect(page.current_path).to eq '/'
  end
end
