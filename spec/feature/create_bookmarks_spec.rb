require 'spec_helper'

feature 'Creating bookmarks' do
  scenario 'can add a bookmark and see it on the page' do
    visit('/bookmarks')
    fill_in('bookmark_url', with: 'www.test.com')
    click_button('Save')
    expect(page).to have_content('www.test.com')
    expect(page.current_path).to have_content('/bookmarks')
  end
end
