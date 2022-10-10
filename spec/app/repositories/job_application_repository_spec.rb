require 'integration_spec_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
describe JobApplicationRepository do
  let(:repository) { described_class.new }
  let(:job_offer) do
    job_offer = JobOffer.new(title: 'a title', is_active: true)
    JobOfferRepository.new.save(job_offer)
    job_offer
  end
  let(:job_offer_two) do
    job_offer = JobOffer.new(title: 'a title2', is_active: true)
    JobOfferRepository.new.save(job_offer)
    job_offer
  end
  let(:job_application_one_offer_one) { JobApplication.new('test1@test.com', job_offer) }
  let(:job_application_two_offer_one) { JobApplication.new('test2@test.com', job_offer) }
  let(:job_application_three_offer_one) { JobApplication.new('test3@test.com', job_offer) }
  let(:job_application_one_offer_two) { JobApplication.new('test1@test.com', job_offer_two) }

  it 'applicants amount should be 0 when nobody has applied' do
    expect(repository.applicants_amount?(job_offer)).to eq 0
  end

  it 'applicants amount should be 1 when the first user applies' do
    job_application = JobApplication.new('test@test.com', job_offer)
    repository.save(job_application)
    expect(repository.applicants_amount?(job_offer)).to eq 1
  end

  it 'applicants amount should be 1 when the first user applies twice to the same offer' do
    job_application = JobApplication.new('test@test.com', job_offer)
    repository.save(job_application)
    repository.save(job_application)
    expect(repository.applicants_amount?(job_offer)).to eq 1
  end

  it 'applicants amount should be 2 when 2 applicants apply to the same offer' do
    repository.save(job_application_one_offer_one)
    repository.save(job_application_two_offer_one)
    expect(repository.applicants_amount?(job_offer)).to eq 2
  end

  it 'applicants amount should be 3 when 3 applicants apply to the same offer more than once' do
    repository.save(job_application_one_offer_one)
    repository.save(job_application_two_offer_one)
    repository.save(job_application_three_offer_one)
    repository.save(job_application_one_offer_one)
    expect(repository.applicants_amount?(job_offer)).to eq 3
  end

  it 'applicants amount should be 1 when 1 applicant apply to different offer' do
    repository.save(job_application_one_offer_one)
    repository.save(job_application_one_offer_two)
    expect(repository.applicants_amount?(job_offer)).to eq 1
    expect(repository.applicants_amount?(job_offer_two)).to eq 1
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
