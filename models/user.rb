class User
  include ActiveModel::Validations

  attr_accessor :id, :name, :email, :crypted_password, :job_offers, :updated_on, :created_on

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  UPPERCASE_PRESENCE_REGEX = /(?=.*?[A-Z])/.freeze
  LOWERCASE_PRESENCE_REGEX = /(?=.*?[a-z])/.freeze

  validates :name, :crypted_password, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX,
                                              message: 'invalid email' }

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    validate_password(data[:password])
    @crypted_password = if data[:password].nil?
                          data[:crypted_password]
                        else
                          Crypto.encrypt(data[:password])
                        end
    @job_offers = data[:job_offers]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end

  def has_password?(password)
    Crypto.decrypt(crypted_password) == password
  end

  protected

  def validate_password(password)
    return if password.nil?
    raise PasswordError unless UPPERCASE_PRESENCE_REGEX.match?(password)
    raise PasswordError unless LOWERCASE_PRESENCE_REGEX.match?(password)
  end
end
