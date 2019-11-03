Sequel.migration do
  up do
    add_column :job_offers, :users_notified, TrueClass, null: true
  end

  down do
    drop_column :job_offers, :users_notified
  end
end
