def sign_up
  visit('/')
  fill_in('email', with: 'test@test.com')
  fill_in('password', with: 'test12')
  click_button('submit')
end

def sign_in(email:, password:)
  visit('/sign_in')
  fill_in('email', with: email)
  fill_in('password', with: password)
  click_button('submit')
end
