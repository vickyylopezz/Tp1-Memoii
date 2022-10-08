Given(/^my name is "(.*?)" and my email is "(.*?)"$/) do |name, email|
    visit '/register'
    fill_in('user[name]', with: name)
    fill_in('user[email]', with: email)
end

Given(/^I complete the password fields with "(.*?)"$/) do |password|
    fill_in('user[password]', with: password)
    fill_in('user[password_confirmation]', with: password)
end

When(/^I try to create the account$/) do
    click_button('Create')
end

Then(/^My account is not created and I get an error message$/) do
    page.should have_content('Invalid password')
end