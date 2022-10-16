require 'spec_helper'

describe JobOffer do
  describe 'valid?' do
    it 'should be invalid when title is blank' do
      date = Date.new(2022, 10, 16)
      check_validation(:title, "Title can't be blank") do
        described_class.new(location: 'a location', expired_date: date)
      end
    end

    it 'should be valid when title is not blank' do
      date = Date.new(2022, 10, 16)
      job_offer = described_class.new(title: 'a title', expired_date: date)
      expect(job_offer).to be_valid
    end

    it 'salary should be valid when is 1000' do
      date = Date.new(2022, 10, 16)
      job_offer = described_class.new(title: 'a title', salary: 1000, expired_date: date)
      expect(job_offer.salary_valid?).to eq true
    end

    it 'salary should be not valid when is blank' do
      date = Date.new(2022, 10, 16)
      job_offer = described_class.new(title: 'a title', salary: '', expired_date: date)
      expect(job_offer.salary_valid?).to eq false
    end

    it 'should be valid when expired date is not blank' do
      date = Date.new(2022, 10, 16)
      job_offer = described_class.new(title: 'a title', salary: 1000, expired_date: date)
      expect(job_offer).to be_valid
    end
  end
end
