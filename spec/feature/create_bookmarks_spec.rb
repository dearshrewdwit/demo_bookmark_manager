require 'spec_helper'

feature 'Creating bookmarks' do
  scenario 'can add a bookmark and see it on the page' do
    visit('/bookmarks')
    fill_in('bookmark_url', with: 'www.test.com')
    fill_in('bookmark_title', with: 'test')
    click_button('Save')
    expect(page).to have_link('test', href: 'www.test.com')
    expect(page.current_path).to have_content('/bookmarks')
  end
end
