class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

  def find_by_job_offer_id(job_offer_id)
    load_collection(dataset.where(job_offer_id: job_offer_id))
  end

  def find_by_applicant_id(applicant_id)
    collection = load_collection(dataset.where(applicant_id: applicant_id))

    collection.sort_by(&:created_on)
  end

  protected

  def load_object(a_record)
    job_application = super
    job_offer = JobOfferRepository.new.find(job_application.job_offer_id)
    job_application.job_offer = job_offer
    applicant = UserRepository.new.find(job_application.applicant_id)
    job_application.applicant = applicant
    job_application
  end

  def changeset(job_application)
    {
      job_offer_id: job_application.job_offer.id || job_application.job_offer_id,
      applicant_id: job_application.applicant.id || job_application.applicant_id,
      expected_remuneration: job_application.expected_remuneration
    }
  end
end
