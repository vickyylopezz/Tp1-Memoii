Given(/^only a "([^"]*)" offer exists owned by "([^"]*)" in the offers list$/) do |offer_title, offerer_email|
  @job_offer = JobOffer.new(title: offer_title, location: 'a nice job', description: 'a nice job')
  @offerer = User.new(email: offerer_email, name: 'Offerer', password: 'Passw0rd!')
  UserRepository.new.save(@offerer)
  @job_offer.owner = @offerer
  @job_offer.is_active = true

  JobOfferRepository.new.save @job_offer
end

Given(/^an applicant who fills the application form$/) do
  visit '/job_offers'
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application_form[personal_bio]', with: 'Test bio')
end

When(/^the applicant applies$/) do
  click_button('Apply')
end

Then(/^I should receive an email with the applicant information$/) do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/#{@offerer.email}", 'r')
  content = file.read
  content.include?('applicant@test.com').should be true
  content.include?('Test bio').should be true
  content.include?(@job_offer.title).should be true
end

Given(/^an applicant who fills the application form and applies$/) do
  step 'an applicant who fills the application form'
  step 'the applicant applies'
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/#{@offerer.email}", 'r')
  @file_length = file.size
end

When(/^the applicant applies to the same job offer again using the same email$/) do
  step 'an applicant who fills the application form'
  step 'the applicant applies'
end

Then(/^I should not receive a second email$/) do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/#{@offerer.email}", 'r')
  file.size.should == @file_length
end
