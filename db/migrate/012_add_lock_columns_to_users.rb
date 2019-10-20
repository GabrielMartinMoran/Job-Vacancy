Sequel.migration do
  up do
    add_column :users, :login_failed_attempts, Integer
    add_column :users, :last_lock_date, Date, null: true
  end

  down do
    drop_column :users, :login_failed_attempts
    drop_column :users, :last_lock_date
  end
end
