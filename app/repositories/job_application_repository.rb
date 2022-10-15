class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

  def find_by_email_and_offer(email, job_offer)
    row = dataset.first(job_offer_id: job_offer&.id, applicant_email: email)
    load_object(row) unless row.nil?
  end

  def applicants_amount?(job_offer)
    dataset.where(job_offer_id: job_offer.id).count
  end

  def save(job_application)
    if dataset.where(job_offer_id: job_application.job_offer&.id,
                     applicant_email: job_application.applicant_email).count.positive?
      nil
    else
      !insert(job_application).id.nil?
    end
  end

  def load_object(a_record)
    job_offer = JobOfferRepository.new.find(a_record[:job_offer_id])
    JobApplication.new(a_record[:applicant_email], job_offer, a_record[:personal_bio], a_record[:curriculum])
  end

  def changeset(application)
    {
      applicant_email: application.applicant_email,
      job_offer_id: application.job_offer&.id,
      personal_bio: application.personal_bio,
      curriculum: application.curriculum
    }
  end
end
