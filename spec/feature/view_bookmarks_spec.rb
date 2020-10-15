require 'spec_helper'

feature 'viewing bookmarks' do
  before { Bookmark.create(url: 'test_url') }

  scenario 'are on the page' do
    visit '/bookmarks'
    expect(page).to have_content('test_url')
  end
end
