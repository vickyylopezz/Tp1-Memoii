require 'date'

class JobOffer
  include ActiveModel::Validations

  attr_accessor :id, :user, :user_id, :title,
                :location, :description, :is_active,
                :updated_on, :created_on, :salary,
                :expired_date

  validates :title, presence: true
  validates :expired_date, presence: true

  # rubocop:disable Metrics/AbcSize
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
    @expired_date = data[:expired_date]
    validate!
  end
  # rubocop:enable Metrics/AbcSize

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
