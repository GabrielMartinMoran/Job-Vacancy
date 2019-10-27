Sequel.migration do
  up do
    alter_table(:job_applications) { add_foreign_key :applicant_id, :users }
  end

  down do
    drop_column :job_applications, :applicant_id
  end
end
