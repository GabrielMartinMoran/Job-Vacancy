class JobApplication
  include ActiveModel::Validations

  attr_accessor :id, :job_offer, :expected_remuneration,
                :updated_on, :created_on, :job_offer_id, :applicant,
                :applicant_id

  def initialize(data = {})
    @id = data[:id]
    @job_offer = data[:job_offer]
    @job_offer_id = data[:job_offer_id]
    @applicant = data[:applicant]
    @applicant_id = data[:applicant_id]
    @expected_remuneration = obtain_expected_remuneration(data[:expected_remuneration])
    @created_on = data[:created_on]
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
    unless expected_remuneration.nil? ||
           ((expected_remuneration.is_a? Numeric) && expected_remuneration.positive?)
      raise StandardError, 'Expected remuneration must be a number greater than zero'
    end

    expected_remuneration
  end
end
