JobVacancy::App.controllers :job_offers do
  get :my do
    @offers = JobOfferRepository.new.find_by_owner(current_user)
    ja_repository = JobApplicationRepository.new
    @offers.each do |job_offer|
      job_offer.applications_quantity =
        ja_repository.find_by_job_offer_id(job_offer.id).length
    end
    render 'job_offers/my_offers'
  end

  get :index do
    @offers = JobOfferRepository.new.all_active
    render 'job_offers/list'
  end

  get :new do
    @job_offer = JobOffer.new
    render 'job_offers/new'
  end

  get :latest do
    @offers = JobOfferRepository.new.all_showable
    render 'job_offers/list'
  end

  get :edit, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    # TODO: validate the current user is the owner of the offer
    render 'job_offers/edit'
  end

  get :apply, with: :offer_id do
    return redirect "/login?redirect_to=/job_offers/apply/#{params[:offer_id]}" unless signed_in?

    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    if @job_offer.expired?
      flash.now[:error] = 'This Job Offer has expired'
      @offers = JobOfferRepository.new.all_active
      return render 'job_offers/list'
    end
    @job_application = JobApplication.new
    so = SuggestedOffers.new(@job_offer)
    so.add(JobOfferRepository.new.search_by_tags(@job_offer.tags_list))
    @suggested_offers = so.obtain
    # TODO: validate the current user is the owner of the offer
    render 'job_offers/apply'
  end

  post :search do
    @offers = JobOfferRepository.new.search_by_title(params[:q])
    render 'job_offers/list'
  end

  post :apply, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    expected_remuneration = parse_expected_remuneration
    @suggested_offers = []
    begin
      @job_application = JobApplication.new(job_offer: @job_offer,
                                            expected_remuneration: expected_remuneration,
                                            applicant: current_user)
      JobApplicationRepository.new.save(@job_application)
    rescue StandardError => exception
      @job_application = JobApplication.new(job_offer: @job_offer)
      flash.now[:error] = exception.message
      return render 'job_offers/apply'
    end
    @job_application.process
    flash[:success] = 'Contact information sent.'
    redirect '/job_offers'
  end

  post :create do
    @job_offer = JobOffer.new(job_offer_params.merge(max_valid_date: parse_max_valid_date))
    @job_offer.owner = current_user
    if JobOfferRepository.new.save(@job_offer)
      TwitterClient.publish(@job_offer) if params['create_and_twit']
      flash[:success] = 'Offer created'
      redirect '/job_offers/my'
    else
      flash.now[:error] = (@job_offer.errors.messages.map { |_key, value| value }).join(', ')
      render 'job_offers/new'
    end
  end

  post :update, with: :offer_id do
    @job_offer = JobOffer.new(job_offer_params.merge(id: params[:offer_id], max_valid_date: parse_max_valid_date))
    @job_offer.owner = current_user

    @job_offer.users_notified = JobOfferRepository.new.find(@job_offer.id).users_notified

    if JobOfferRepository.new.save(@job_offer)
      flash[:success] = 'Offer updated'
      redirect '/job_offers/my'
    else
      flash.now[:error] = (@job_offer.errors.messages.map { |_key, value| value }).join(', ')
      render 'job_offers/edit'
    end
  end

  put :activate, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    @job_offer.activate(UserRepository.new.find_by_matching_tags(@job_offer.tags_list))
    if JobOfferRepository.new.save(@job_offer)
      flash[:success] = 'Offer activated'
    else
      flash.now[:error] = 'Operation failed'
    end

    redirect '/job_offers/my'
  end

  delete :destroy do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    if JobOfferRepository.new.destroy(@job_offer)
      flash[:success] = 'Offer deleted'
    else
      flash.now[:error] = 'Title is mandatory'
    end
    redirect 'job_offers/my'
  end
end
