Sequel.migration do
  up do
    add_column :job_offers, :tags, String
  end

  down do
    drop_column :job_offers, :tags
  end
end
