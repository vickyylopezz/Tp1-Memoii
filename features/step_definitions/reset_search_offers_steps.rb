Given('{string} job offer exist in the offers list') do |title1|
  @job_offer = JobOffer.new(title: title1, location: 'a nice job', description: 'a nice job')
  @job_offer.owner = UserRepository.new.first
  @job_offer.is_active = true
  JobOfferRepository.new.save @job_offer

  visit '/job_offers/latest'
end

Given('I search for {string} offers') do |title|
  fill_in('q', with: title)
  click_button('search-button')
end

Given('only {string} offer exists in the offers list') do |content|
  page.should have_content(content)
end

When('I reset the search of job offers') do
  click_link 'clean'
end

Then('{string} and {string} job offers exist in the offers list') do |title1, title2|
  page.should have_content(title1)
  page.should have_content(title2)
end
