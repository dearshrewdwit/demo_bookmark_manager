require 'spec_helper'

feature 'Registrations' do
  context 'Signing up' do
    scenario 'shows a welcome message' do
      sign_up
      expect(page).to have_content("Welcome, test@test.com!")
      expect(page.current_path).to eq('/bookmarks')
    end
  end
end
