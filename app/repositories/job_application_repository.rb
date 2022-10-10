class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

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

  def changeset(application)
    {
      applicant_email: application.applicant_email,
      job_offer_id: application.job_offer&.id,
      personal_bio: application.personal_bio
    }
  end
end
