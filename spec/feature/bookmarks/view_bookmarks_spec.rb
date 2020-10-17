require 'spec_helper'

feature 'viewing bookmarks' do
  let!(:user) { User.create(email: 'test@test.com', password: 'test12') }
  before { sign_in(email: 'test@test.com', password: 'test12') }
  before { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC') }

  scenario 'are on the page' do
    visit '/bookmarks'
    expect(page).to have_link('BBC', href: 'https://www.bbc.co.uk')
  end
end
