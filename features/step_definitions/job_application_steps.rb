Given(/^only a "(.*?)" offer exists in the offers list$/) do |job_title|
  @job_offer = JobOffer.new(title: job_title, location: 'a nice job', description: 'a nice job',
                            expired_date: Date.today)
  @job_offer.owner = UserRepository.new.first
  @job_offer.is_active = true

  JobOfferRepository.new.save @job_offer
end

Given(/^I access the offers list page$/) do
  visit '/job_offers'
end

When(/^I apply$/) do
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
  click_button('Apply')
end

When('I apply with {string} as personal description') do |string|
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application_form[personal_bio]', with: string)
  click_button('Apply')
end

When('I apply with a 600 characters personal description') do
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
  big_bio = ''
  501.times { big_bio += 'a' }
  fill_in('job_application_form[personal_bio]', with: big_bio)
  click_button('Apply')
end

Then('I should get an error message') do
  page.should have_content('Field description cannot be longer than 500 chars')
end

Then('I should get an cannot be blank error message') do
  page.should have_content("Field description can't be blank")
end

Then(/^I should receive a mail with offerer info$/) do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/applicant@test.com", 'r')
  content = file.read
  content.include?(@job_offer.title).should be true
  content.include?(@job_offer.location).should be true
  content.include?(@job_offer.description).should be true
  content.include?(@job_offer.owner.email).should be true
  content.include?(@job_offer.owner.name).should be true
end

When(/^I fill in the form application$/) do
  click_link 'Apply'
  fill_in('job_application_form[curriculum]', with: 'my_curriculum.com')
end

Then(/^I have the chance to add a link to my cv$/) do
  page.should have_content('Curriculum link')
end

When(/^I apply with "([^"]*)" as my cv link$/) do |cv_link|
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application_form[personal_bio]', with: 'Test bio')
  fill_in('job_application_form[curriculum]', with: cv_link)
  click_button('Apply')
end

Then(/^the application is successfully submited$/) do
  page.should have_content('Contact information sent.')
end

When(/^I apply without a cv link$/) do
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application_form[personal_bio]', with: 'Test bio')
  click_button('Apply')
end
