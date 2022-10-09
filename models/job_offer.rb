class JobOffer
  include ActiveModel::Validations

  INITIAL_APPLICANTS_AMOUNT = 0
  attr_accessor :id, :user, :user_id, :title,
                :location, :description, :is_active,
                :updated_on, :created_on, :salary, :applicants_amount

  validates :title, presence: true
  # validates :salary, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 0 }

  def initialize(data = {})
    @id = data[:id]
    @title = data[:title]
    @location = data[:location]
    @description = data[:description]
    @is_active = data[:is_active]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @user_id = data[:user_id]
    @salary = data[:salary].blank? ? nil : Integer(data[:salary])
    @applicants_amount = INITIAL_APPLICANTS_AMOUNT
    validate!
  end

  def owner
    user
  end

  def owner=(a_user)
    self.user = a_user
  end

  def activate
    self.is_active = true
  end

  def deactivate
    self.is_active = false
  end

  def old_offer?
    (Date.today - updated_on) >= 30
  end

  def salary_valid?
    return false if salary.nil?

    salary.positive?
  end
end
