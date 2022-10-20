Given(/^there is no registered user with the email "([^"]*)"$/) do |user_email|
  UserRepository.new.find_by_email(user_email).should be nil
end

When(/^I try to register an user with the email "([^"]*)"$/) do |user_email|
  visit '/register'
  fill_in('user[name]', with: 'test')
  fill_in('user[email]', with: user_email)
  fill_in('user[password]', with: 'Passw0rd')
  fill_in('user[password_confirmation]', with: 'Passw0rd')
  click_button('Create')
end

Then(/^the account is successfully created$/) do
  page.should have_content('User created')
end

Given(/^there is an user already registered with the email "([^"]*)"$/) do |user_email|
  visit '/register'
  fill_in('user[name]', with: 'test')
  fill_in('user[email]', with: user_email)
  fill_in('user[password]', with: 'Passw0rd')
  fill_in('user[password_confirmation]', with: 'Passw0rd')
  click_button('Create')
end

Then(/^the account is not created and I get an error message$/) do
  page.should have_content('This user email has an account associated')
end
