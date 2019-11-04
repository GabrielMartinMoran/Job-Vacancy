Sequel.migration do
  up do
    add_column :job_offers, :max_valid_date, DateTime, null: true
  end

  down do
    drop_column :job_offers, :max_valid_date
  end
end
