class JobApplication
  include ActiveModel::Validations

  attr_accessor :applicant_email, :job_offer, :id, :created_on, :updated_on, :personal_bio

  validates :applicant_email, :job_offer, presence: true

  def initialize(email, offer, personal_bio = nil)
    @applicant_email = email
    @job_offer = offer
    @personal_bio = personal_bio
    validate!
  end

  def self.create_for(email, offer)
    JobApplication.new(email, offer)
  end

  def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
