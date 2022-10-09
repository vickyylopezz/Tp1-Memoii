class PasswordError < RuntimeError
  PASSWORD_ERROR_MESSAGE = 'invalid password: password must contain at least 1 uppercase and 1 lowercase'.freeze
  def initialize(msg = PASSWORD_ERROR_MESSAGE)
    super(msg)
  end
end
