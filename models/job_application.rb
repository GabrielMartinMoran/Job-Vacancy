class JobApplication
  attr_accessor :id, :applicant_email, :job_offer, :expected_remuneration

  def initialize(data = {})
    @id = data[:id]
    @applicant_email = data[:applicant_email]
    @job_offer = data[:job_offer]
    @expected_remuneration = obtain_expected_remuneration(data[:expected_remuneration])
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

  private

  def obtain_expected_remuneration(expected_remuneration)
    if expected_remuneration.nil?
      'Not specified'
    else
      unless (expected_remuneration.is_a? Numeric) && expected_remuneration.positive?
        raise StandardError, 'Expected remuneration must be a number greater than zero'
      end

      expected_remuneration
    end
  end
end
