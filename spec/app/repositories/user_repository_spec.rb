require 'integration_spec_helper'

describe UserRepository do
  let(:repository) { described_class.new }
  let(:user) do
    User.new(name: 'Test', email: 'test@test.com', crypted_password: 'secure_pwd')
  end

  describe '' do
    it 'should not be valid to register an user with existing email' do
      repository.save(user)
      user_copy = User.new(name: 'Test1', email: 'test@test.com', crypted_password: 'secure_pwd')
      expect do
        repository.save(user_copy)
      end.to raise_error 'This user email has an account associated'
    end
  end
end
