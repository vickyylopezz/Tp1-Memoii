class JobApplication
  include ActiveModel::Validations

  attr_accessor :applicant_email, :job_offer, :id, :created_on, :updated_on, :personal_bio

  LIMIT = 500
  MINIMUM = 0
  validates :applicant_email, :job_offer, presence: true

  def initialize(email, offer, personal_bio)
    @applicant_email = email
    @job_offer = offer
    @personal_bio = personal_bio
    validate_personal_bio
    validate!
  end

  def validate_personal_bio
    raise PersonalBioBlankError if @personal_bio.nil?
    raise PersonalBioBlankError if @personal_bio.length == MINIMUM
    raise PersonalBioToLongError if @personal_bio.length > LIMIT
  end

  def self.create_for(email, offer, personal_bio)
    JobApplication.new(email, offer, personal_bio)
  end

  def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
