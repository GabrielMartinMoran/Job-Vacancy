class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

  def find_by_job_offer_id(_job_offer_id)
    []
  end

  protected

  def load_object(a_record)
    job_application = super
    job_offer = JobOfferRepository.new.find(job_application.job_offer_id)
    job_application.job_offer = job_offer
    job_application
  end

  def changeset(job_application)
    {
      applicant_email: job_application.applicant_email,
      job_offer_id: job_application.job_offer.id || job_application.job_offer_id,
      expected_remuneration: job_application.expected_remuneration
    }
  end
end
