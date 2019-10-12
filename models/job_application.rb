class JobApplication
  attr_accessor :applicant_email
  attr_accessor :job_offer, :expected_remuneration

  def self.create_for(email, offer, expected_remuneration = nil)
    app = JobApplication.new
    app.applicant_email = email
    app.job_offer = offer
    unless expected_remuneration.nil? || (expected_remuneration.is_a? Numeric)
      raise StandardError, 'Expected remuneration must be a number greater than zero'
    end

    app.expected_remuneration = expected_remuneration
    app
  end

  def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end
end
