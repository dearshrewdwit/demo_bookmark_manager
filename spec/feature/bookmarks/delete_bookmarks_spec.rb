require 'spec_helper'

feature 'Deleting bookmarks' do
  let!(:user) { User.create(email: 'test@test.com', password: 'test12') }
  let!(:bookmark) { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC') }
  let!(:bookmark2) { Bookmark.create(url: 'https://www.google.co.uk', title: 'google') }
  let!(:comment) { Comment.create(text: 'a comment', bookmark_id: bookmark2.id) }

  before { sign_in(email: 'test@test.com', password: 'test12') }
  
  scenario 'can delete a bookmark' do
    visit('/bookmarks')
    expect(page).to have_link(bookmark.title, href: bookmark.url)
    expect(page).to have_link(bookmark2.title, href: bookmark2.url)

    within("div##{bookmark.id}") do
      click_button('Delete')
    end

    expect(page).not_to have_link(bookmark.title, href: bookmark.url)
    expect(page).to have_link(bookmark2.title, href: bookmark2.url)
    expect(page.current_path).to have_content('/bookmarks')
  end

  scenario 'can delete a bookmark with comments' do
    visit('/bookmarks')
    expect(page).to have_link(bookmark.title, href: bookmark.url)
    expect(page).to have_link(bookmark2.title, href: bookmark2.url)

    within("div##{bookmark2.id}") do
      click_button('Delete')
    end

    expect(page).to have_link(bookmark.title, href: bookmark.url)
    expect(page).not_to have_link(bookmark2.title, href: bookmark2.url)
    expect(page.current_path).to have_content('/bookmarks')
  end
end
