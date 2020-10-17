require 'spec_helper'

feature 'Deleting bookmarks' do
  before { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC') }
  before { Bookmark.create(url: 'https://www.google.co.uk', title: 'google') }

  scenario 'can delete a bookmark' do
    bookmarks = Bookmark.all
    first_bookmark, second_bookmark = bookmarks[0], bookmarks[1]

    visit('/bookmarks')
    expect(page).to have_link(first_bookmark.title, href: first_bookmark.url)
    expect(page).to have_link(second_bookmark.title, href: second_bookmark.url)

    within("div##{first_bookmark.id}") do
      click_button('Delete')
    end

    expect(page).not_to have_link(first_bookmark.title, href: first_bookmark.url)
    expect(page).to have_link(second_bookmark.title, href: second_bookmark.url)
    expect(page.current_path).to have_content('/bookmarks')
  end
end
