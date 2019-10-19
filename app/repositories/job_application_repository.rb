class JobApplicationRepository < BaseRepository
  self.table_name = :job_applications
  self.model_class = 'JobApplication'

  protected

  def changeset(job_application)
    {
      applicant_email: job_application.applicant_email,
      job_offer_id: job_application.job_offer.id,
      expected_remuneration: job_application.expected_remuneration
    }
  end
end
