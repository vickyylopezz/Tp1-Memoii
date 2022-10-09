class PasswordError < RuntimeError
  def initialize(msg = 'invalid password')
    super(msg)
  end
end
