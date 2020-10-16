require 'spec_helper'

feature 'Updating bookmarks' do
  before { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC') }
  before { Bookmark.create(url: 'https://www.google.co.uk', title: 'google') }

  scenario 'can update a bookmark' do
    bookmarks = Bookmark.all
    first_bookmark, second_bookmark = bookmarks[0], bookmarks[1]

    visit('/bookmarks')
    expect(page).to have_link(first_bookmark.title, href: first_bookmark.url)
    expect(page).to have_link(second_bookmark.title, href: second_bookmark.url)

    within("div##{first_bookmark.id}") do
      click_link('Edit')
    end
    expect(page.current_path).to eq("/bookmarks/#{first_bookmark.id}/edit")

    fill_in(:bookmark_url, with: 'https://www.reddit.com')
    fill_in(:bookmark_title, with: 'reddit')
    click_button('Update')

    expect(page).to have_content('Bookmark updated')
    expect(page).not_to have_link(first_bookmark.title, href: first_bookmark.url)
    expect(page).to have_link('reddit', href: 'https://www.reddit.com')
    expect(page).to have_link(second_bookmark.title, href: second_bookmark.url)
    expect(page.current_path).to eq('/bookmarks')
  end

  scenario 'sees error with invalid bookmark url' do
    bookmarks = Bookmark.all
    first_bookmark, second_bookmark = bookmarks[0], bookmarks[1]

    visit('/bookmarks')
    expect(page).to have_link(first_bookmark.title, href: first_bookmark.url)
    expect(page).to have_link(second_bookmark.title, href: second_bookmark.url)

    within("div##{first_bookmark.id}") do
      click_link('Edit')
    end
    expect(page.current_path).to eq("/bookmarks/#{first_bookmark.id}/edit")

    fill_in(:bookmark_url, with: 'reddit.com')
    fill_in(:bookmark_title, with: 'reddit')
    click_button('Update')

    expect(page).to have_content('reddit.com is an invalid URL')
    expect(page).to have_link(first_bookmark.title, href: first_bookmark.url)
    expect(page).to have_link(second_bookmark.title, href: second_bookmark.url)
    expect(page.current_path).to eq('/bookmarks')
  end
end
