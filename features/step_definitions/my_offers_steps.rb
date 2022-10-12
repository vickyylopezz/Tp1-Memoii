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

When(/^the user "([^"]*)" applies to the job offer$/) do |user_email|
  visit '/job_offers'
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: user_email)
  fill_in('job_application_form[personal_bio]', with: 'test')
  click_button('Apply')
end

Then(/^the applicants amount of the offer "([^"]*)" should be (\d+)$/) do |job_title, applicant_amount|
  visit '/job_offers/my'
  within('tr', text: job_title) do
    page.should have_content(applicant_amount)
  end
end

When(/^the user "([^"]*)" applies to the job offer again$/) do |user_email|
  visit '/job_offers'
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: user_email)
  fill_in('job_application_form[personal_bio]', with: 'test')
  click_button('Apply')
end

When(/^I try to delete the offer "([^"]*)"$/) do |_job_title|
  visit '/job_offers/my'
  click_button('Delete')
end

Then(/^the offer "([^"]*)" is successfully deleted$/) do |job_title|
  page.should_not have_content(job_title)
end

Given(/^there is an offer with title "([^"]*)" and with applicants$/) do |job_title|
  visit '/job_offers/new'
  fill_in('job_offer_form[title]', with: job_title)
  click_button('Create')
  click_button('Activate')
  visit '/job_offers'
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'test@test.com')
  fill_in('job_application_form[personal_bio]', with: 'test')
  click_button('Apply')
end

Then(/^the offer "([^"]*)" is not deleted and I get an error message$/) do |job_title|
  page.should have_content('You cant delete an offer with applicants')
  page.should have_content(job_title)
end
