require 'spec_helper'

describe JobOffer do
  describe 'valid?' do
    let(:today) { Date.new(2022, 10, 16) }

    it 'should be invalid when title is blank' do
      check_validation(:title, "Title can't be blank") do
        described_class.new(location: 'a location', expired_date: today)
      end
    end

    it 'should be valid when title is not blank' do
      job_offer = described_class.new(title: 'a title', expired_date: today)
      expect(job_offer).to be_valid
    end

    it 'salary should be valid when is 1000' do
      job_offer = described_class.new(title: 'a title', salary: 1000, expired_date: today)
      expect(job_offer.salary_valid?).to eq true
    end

    it 'salary should be not valid when is blank' do
      job_offer = described_class.new(title: 'a title', salary: '', expired_date: today)
      expect(job_offer.salary_valid?).to eq false
    end

    it 'should be valid when expired date is not blank' do
      job_offer = described_class.new(title: 'a title', salary: 1000, expired_date: today)
      expect(job_offer).to be_valid
    end
  end

  describe 'expired_offer?' do
    def init_date_provider_mock(expired, status)
      mock = instance_double('date_provider')
      allow(mock).to receive(:expired_offer).with(expired).and_return(status)

      mock
    end

    it 'should be expired when expired date is 10/10/22 and today is 16/10/22' do
      expired = Date.new(2022, 10, 10)
      job_offer = described_class.new(title: 'a title', salary: 1000, expired_date: expired)
      job_offer.date_provider = init_date_provider_mock(expired, true)
      expect(job_offer.expired_offer?).to eq true
    end

    it 'should not be expired when expired date is 17/10/22 and today is 16/10/22' do
      expired = Date.new(2022, 10, 17)
      job_offer = described_class.new(title: 'a title', salary: 1000, expired_date: expired)
      job_offer.date_provider = init_date_provider_mock(expired, false)
      expect(job_offer.expired_offer?).to eq false
    end
  end
end
