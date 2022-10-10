class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

  def applicants_amount?(job_offer)
    dataset.where(job_offer_id: job_offer.id).count
  end

  def changeset(application)
    {
      applicant_email: application.applicant_email,
      job_offer_id: application.job_offer&.id
    }
  end
end
