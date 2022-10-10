require 'spec_helper'

describe JobOffer do
  describe 'valid?' do
    it 'should be invalid when title is blank' do
      check_validation(:title, "Title can't be blank") do
        described_class.new(location: 'a location')
      end
    end

    it 'should be valid when title is not blank' do
      job_offer = described_class.new(title: 'a title')
      expect(job_offer).to be_valid
    end

    it 'salary should be valid when is 1000' do
      job_offer = described_class.new(title: 'a title', salary: 1000)
      expect(job_offer.salary_valid?).to eq true
    end

    it 'salary should be not valid when is blank' do
      job_offer = described_class.new(title: 'a title', salary: '')
      expect(job_offer.salary_valid?).to eq false
    end
  end
end
