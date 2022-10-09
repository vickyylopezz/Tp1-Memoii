Given(/^I am logged in as job offerer "([^"]*)"$/) do |_oferrer|
  visit '/login'
  fill_in('user[email]', with: 'offerer@test.com')
  fill_in('user[password]', with: 'Passw0rd!')
  click_button('Login')
  page.should have_content('offerer@test.com')
end

Given(/^there is an offer with title "([^"]*)" and without any applicants$/) do |job_offer_title|
  visit '/job_offers/new'
  fill_in('job_offer_form[title]', with: job_offer_title)
  click_button('Create')
  click_button('Activate')
end

When(/^the user "([^"]*)" applicates to the job offer$/) do |user_email|
  visit '/job_offers'
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: user_email)
  click_button('Apply')
end

Then(/^the applicants amount of the offer "([^"]*)" should be (\d+)$/) do |job_title, applicant_amount|
  visit '/job_offers/my'
  within('tr', text: job_title) do
    page.should have_content(applicant_amount)
  end
end
