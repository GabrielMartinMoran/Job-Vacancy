# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do
  def job_offer_params
    params[:job_offer].to_h.symbolize_keys
  end

  def parse_expected_remuneration
    return nil if params[:job_application][:expected_remuneration].empty?

    params[:job_application][:expected_remuneration].to_f
  end

  def parse_max_valid_date
    return nil if job_offer_params[:max_valid_date].nil? || job_offer_params[:max_valid_date].empty?

    Date.parse(job_offer_params[:max_valid_date])
  end
end
