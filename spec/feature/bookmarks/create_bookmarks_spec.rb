require 'spec_helper'

feature 'Creating bookmarks' do
  let!(:user) { User.create(email: 'test@test.com', password: 'test12') }
  before { sign_in(email: 'test@test.com', password: 'test12') }

  context 'valid bookmark' do
    scenario 'can add a bookmark and see it on the page' do
      visit('/bookmarks')
      fill_in('bookmark_url', with: 'http://www.test.com')
      fill_in('bookmark_title', with: 'test')
      fill_in('bookmark_tags', with: 'test_tag short')
      click_button('Save')
      expect(page).to have_content("Bookmark saved")
      expect(page).to have_link('test', href: 'http://www.test.com')
      expect(page).to have_link("test_tag")
      expect(page).to have_link("short")
      expect(page.current_path).to have_content('/bookmarks')
    end
  end

  context 'invalid bookmark url' do
    scenario 'user sees error message' do
      visit('/bookmarks')
      fill_in('bookmark_url', with: 'blaaa')
      fill_in('bookmark_title', with: 'test')
      click_button('Save')
      expect(page).to have_content("blaaa is an invalid URL")
      expect(page).not_to have_content("test")
      expect(page.current_path).to have_content('/bookmarks')
    end
  end
end
