class PasswordError < RuntimeError
  DEFAULT_PASSWORD_ERROR_MESSAGE = 'invalid password'.freeze
  UPPERCASE_ERROR_MESSAGE_CONDITION = '1 uppercase'.freeze
  LOWERCASE_ERROR_MESSAGE_CONDITION = '1 lowercase'.freeze
  NUMBER_ERROR_MESSAGE_CONDITION = '1 number'.freeze
  LENGTH_ERROR_MESSAGE_CONDITION = '8 characters long'.freeze

  def initialize(msg = error_message)
    super(msg)
  end

  private

  def error_message
    condition_message = ': password must contain at least '
    message = DEFAULT_PASSWORD_ERROR_MESSAGE + condition_message
    message.concat(UPPERCASE_ERROR_MESSAGE_CONDITION)
    message.concat(", #{LOWERCASE_ERROR_MESSAGE_CONDITION}")
    message.concat(", #{NUMBER_ERROR_MESSAGE_CONDITION}")
    message.concat(" and #{LENGTH_ERROR_MESSAGE_CONDITION}")

    message
  end
end
