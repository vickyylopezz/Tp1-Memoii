require 'integration_spec_helper'

describe JobApplicationRepository do
  let(:repository) { described_class.new }

  let(:job_offer) do
    job_offer = JobOffer.new(title: 'a title', is_active: true)
    JobOfferRepository.new.save(job_offer)
    job_offer
  end

  it 'applicants amount should be 0 when nobody has applied' do
    expect(repository.applicants_amount?).to eq 0
  end
end
