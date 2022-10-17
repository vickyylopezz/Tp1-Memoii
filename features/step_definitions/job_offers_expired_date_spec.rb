Given('I create a new job offer with {string} as the title and {int}\/{int}\/{int} as the expired date') do |title, day, month, year|
  visit '/job_offers/new'
  fill_in('job_offer_form[title]', with: title)
  fill_in('job_offer_form[expired_date]', with: Date.new(year, month, day))
  click_button('Create')
end

When('I visit my offers list on {int}\/{int}\/{int}') do |day, month, year|
  visit '/job_offers/my'
  @date = Date.new(year, month, day)
end

Then('^I should see "(.*?)" in my offers list$') do |title|
  visit '/job_offers/my'
  page.should have_content(title)
end

Then('I should not see {string} in the offers list') do |title|
  visit '/job_offers/latest'
  page.should_not have_content(title)
end
