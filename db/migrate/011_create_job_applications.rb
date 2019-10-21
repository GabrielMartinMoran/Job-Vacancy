Sequel.migration do
  up do
    create_table(:job_applications) do
      primary_key :id
      String :applicant_email
      Float :expected_remuneration, null: true
      foreign_key :job_offer_id, :job_offers
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:job_applications)
  end
end
