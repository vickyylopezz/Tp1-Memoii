require 'spec_helper'

describe User do
  subject(:user) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:crypted_password) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:job_offers) }
  end

  describe 'valid?' do
    it 'should be false when name is blank' do
      user = described_class.new(email: 'john.doe@someplace.com',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:name)
    end

    it 'should be false when email is not valid' do
      user = described_class.new(name: 'John Doe', email: 'john',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:email)
    end

    it 'should be false when password is blank' do
      user = described_class.new(name: 'John Doe', email: 'john')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:crypted_password)
    end

    it 'should be true when all field are valid' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq true
    end
  end

  describe 'has password?' do
    let(:password) { 'password' }
    let(:user) do
      described_class.new(password: password,
                          email: 'john.doe@someplace.com',
                          name: 'john doe')
    end

    xit 'should return false when password do not match' do
      expect(user).not_to have_password('invalid')
    end

    xit 'should return true when password do  match' do
      expect(user).to have_password(password)
    end
  end

  describe 'validate_password' do
    it 'it should raise an error when password did not contain at least one uppercase letter' do
      expect do
        described_class.new(name: 'John Doe', email: 'john@doe.com', password: 'testeando1')
      end.to raise_error 'invalid password: password must contain at least 1 uppercase and 1 lowercase'
    end

    it 'it should raise an error when password did not contain at least one lowercase letter' do
      expect do
        described_class.new(name: 'John Doe', email: 'john@doe.com', password: 'TESTEANDO1')
      end.to raise_error 'invalid password: password must contain at least 1 uppercase and 1 lowercase'
    end
  end
end
