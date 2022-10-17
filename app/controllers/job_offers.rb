JobVacancy::App.controllers :job_offers do
  get :my do
    @offers = JobOfferRepository.new.find_by_owner(current_user)
    render 'job_offers/my_offers'
  end

  get :index do
    @offers = JobOfferRepository.new.all_active
    render 'job_offers/list'
  end

  get :new do
    @job_offer = JobOfferForm.new
    render 'job_offers/new'
  end

  get :latest do
    @offers = JobOfferRepository.new.all_active
    render 'job_offers/list'
  end

  get :edit, with: :offer_id do
    @job_offer = JobOfferForm.from(JobOfferRepository.new.find(params[:offer_id]))
    # TODO: validate the current user is the owner of the offer
    render 'job_offers/edit'
  end

  get :apply, with: :offer_id do
    @job_offer = JobOfferForm.from(JobOfferRepository.new.find(params[:offer_id]))
    @job_application = JobApplicationForm.new
    # TODO: validate the current user is the owner of the offer
    render 'job_offers/apply'
  end

  post :search do
    @search = params[:q]
    @offers = JobOfferRepository.new.search_by_title(@search)
    render 'job_offers/list'
  end

  post :apply, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    applicant_email = params[:job_application_form][:applicant_email]
    personal_bio = params[:job_application_form][:personal_bio]
    curriculum = params[:job_application_form][:curriculum]
    @job_application = JobApplication.create_for(applicant_email, @job_offer, personal_bio, curriculum)
    unless JobApplicationRepository.new.save(@job_application).nil?
      @job_application.process
      @job_application.process_to_offerer
      flash[:success] = 'Contact information sent.'
    end
    redirect '/job_offers'
  rescue StandardError => e
    @job_offer = JobOfferForm.from(JobOfferRepository.new.find(params[:offer_id]))
    @job_application = JobApplicationForm.new
    @errors = e
    flash.now[:error] = e.message
    render 'job_offers/apply'
  end

  post :create do
    job_offer = JobOffer.new(job_offer_params)
    job_offer.owner = current_user
    if JobOfferRepository.new.save(job_offer)
      TwitterClient.publish(job_offer) if params['create_and_twit']
      flash[:success] = 'Offer created'
      redirect '/job_offers/my'
    end
  rescue ActiveModel::ValidationError => e
    @job_offer = JobOfferForm.new
    @errors = e.model.errors
    flash.now[:error] = 'Please review the errors'
    render 'job_offers/new'
  end

  post :update, with: :offer_id do
    @job_offer = JobOffer.new(job_offer_params.merge(id: params[:offer_id]))
    @job_offer.owner = current_user

    if JobOfferRepository.new.save(@job_offer)
      flash[:success] = 'Offer updated'
      redirect '/job_offers/my'
    end
  rescue ActiveModel::ValidationError => e
    @job_offer = JobOfferForm.new
    @errors = e.model.errors
    flash.now[:error] = 'Please review the errors'
    render 'job_offers/edit'
  end

  put :activate, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    @job_offer.activate
    if JobOfferRepository.new.save(@job_offer)
      flash[:success] = 'Offer activated'
    else
      flash.now[:error] = 'Operation failed'
    end

    redirect '/job_offers/my'
  end

  delete :destroy do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    if !are_there_applicants?(@job_offer)
      if JobOfferRepository.new.destroy(@job_offer)
        flash[:success] = 'Offer deleted'
      else
        flash.now[:error] = 'Title is mandatory'
      end
    else
      flash[:error] = 'You cant delete an offer with applicants'
    end
    redirect 'job_offers/my'
  end
end
