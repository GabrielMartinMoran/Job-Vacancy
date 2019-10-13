class JobApplication
  attr_accessor :applicant_email, :job_offer, :expected_remuneration

  def self.create_for(email, offer, expected_remuneration = nil)
    app = JobApplication.new
    app.applicant_email = email
    app.job_offer = offer
    if expected_remuneration == '' || expected_remuneration.nil?
      app.expected_remuneration = 'Not specified'
    else
      unless (expected_remuneration.is_a? Numeric) && expected_remuneration.positive?
        raise StandardError, 'Expected remuneration must be a number greater than zero'
      end

      app.expected_remuneration = expected_remuneration
    end
    app
  end

  def process
    deliver_contact_info_email
    deliver_applicant_apply_email
  end

  def deliver_contact_info_email
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
  end

  def deliver_applicant_apply_email
    JobVacancy::App.deliver(:notification, :applicant_apply_email, self)
  end
end
