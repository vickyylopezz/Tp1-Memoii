require 'spec_helper'

describe JobApplication do
  let(:job_offer) { JobOffer.new(title: 'a title') }

  describe 'valid?' do
    it 'should be invalid when email is blank' do
      check_validation(:applicant_email, "Applicant email can't be blank") do
        described_class.create_for(nil, job_offer, 'test')
      end
    end

    it 'should be invalid when offer is blank' do
      check_validation(:job_offer, "Job offer can't be blank") do
        described_class.create_for('applicant@test.com', nil, 'test')
      end
    end

    it 'should be invalid when personal bio is blank' do
      mail = 'applicant@test.com'
      expect { described_class.create_for(mail, :job_offer, nil) }.to raise_error(PersonalBioBlankError)
    end

    it 'should be invalid when personal bio has more than 500 characters' do
      big_bio = ''
      501.times { big_bio += 'a' }
      mail = 'applicant@test.com'
      expect { described_class.create_for(mail, :job_offer, big_bio) }.to raise_error(PersonalBioToLongError)
    end
  end

  describe 'create_for' do
    it 'should set applicant_email' do
      email = 'applicant@test.com'
      ja = described_class.create_for(email, job_offer, 'test')
      expect(ja.applicant_email).to eq(email)
    end

    it 'should set job_offer' do
      offer = job_offer
      ja = described_class.create_for('applicant@test.com', offer, 'test')
      expect(ja.job_offer).to eq(offer)
    end

    it 'should set personal bio' do
      personal_bio = 'This is a personal bio'
      ja = described_class.create_for('applicant@test.com', job_offer, personal_bio)
      expect(ja.personal_bio).to eq(personal_bio)
    end
  end

  describe 'process' do
    it 'should deliver contact info notification' do
      ja = described_class.create_for('applicant@test.com', job_offer, 'test')
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.process
    end
  end
end
