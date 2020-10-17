require 'spec_helper'

feature 'viewing bookmarks by tag' do
  let!(:user) { User.create(email: 'test@test.com', password: 'test12') }
  let!(:bookmark1) { Bookmark.create(url: 'https://www.google.co.uk', title: 'google') }
  let!(:bookmark2) { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC') }
  let!(:bookmark3) { Bookmark.create(url: 'https://www.nyt.com', title: 'nyt') }
  let!(:bookmark4) { Bookmark.create(url: 'https://www.reddit.co.uk', title: 'reddit') }
  let!(:tag1) { Tag.find_or_create(content: 'news') }
  let!(:bookmark_tag) { BookmarksTags.create(bookmark_id: bookmark2.id, tag_id: tag1.id) }
  let!(:bookmark_tag2) { BookmarksTags.create(bookmark_id: bookmark3.id, tag_id: tag1.id) }

  before { sign_in(email: 'test@test.com', password: 'test12') }

  scenario 'are on the page' do
    visit '/bookmarks'
    within("div##{bookmark2.id}") do
      click_link('news')
    end
    expect(page).to have_link('BBC', href: 'https://www.bbc.co.uk')
    expect(page).to have_link('nyt', href: 'https://www.nyt.com')
    expect(page).not_to have_link('google', href: 'https://www.google.co.uk')
    expect(page).not_to have_link('reddit', href: 'https://www.reddit.co.uk')
  end
end
