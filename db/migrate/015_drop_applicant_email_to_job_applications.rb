Sequel.migration do
  up do
    drop_column :job_applications, :applicant_email
  end

  down do
    add_column :job_applications, :applicant_email, String
  end
end
