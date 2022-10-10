class JobApplication
  include ActiveModel::Validations

  attr_accessor :applicant_email, :job_offer, :id, :created_on, :updated_on, :personal_bio

  validates :applicant_email, :job_offer, :personal_bio, presence: true
  validates :personal_bio, length: { maximum: 500, message: 'too long' }

  def initialize(email, offer, personal_bio)
    @applicant_email = email
    @job_offer = offer
    @personal_bio = personal_bio
    validate!
  end

  def self.create_for(email, offer, personal_bio)
    JobApplication.new(email, offer, personal_bio)
  end

  def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
