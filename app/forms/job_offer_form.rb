class JobOfferForm
  attr_accessor :id, :title, :location, :description, :salary, :expired_date

  def self.from(a_job_offer)
    form = JobOfferForm.new
    form.id = a_job_offer.id
    form.title = a_job_offer.title
    form.location = a_job_offer.location
    form.description = a_job_offer.description
    form.salary = a_job_offer.salary
    form.expired_date = a_job_offer.expired_date
    form
  end
end
