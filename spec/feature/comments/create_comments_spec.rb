require 'spec_helper'

feature 'Creating comments' do
  let!(:user) { User.create(email: 'test@test.com', password: 'test12') }
  let!(:bookmark) { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC') }

  before { sign_in(email: 'test@test.com', password: 'test12') }
  
  context 'valid comment' do
    scenario 'can add a comment to a bookmark and see it on the page' do
      visit('/bookmarks')
      fill_in(:comment_text, with: "a test comment")
      click_button('submit')
      expect(page).to have_content("a test comment")
      expect(page.current_path).to have_content('/bookmarks')
    end
  end
end
