# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do
  def job_offer_params
    params[:job_offer_form].to_h.symbolize_keys
  end

  def applicants_amount(offer)
    JobApplicationRepository.new.applicants_amount?(offer)
  end
end
