Sequel.migration do
  up do
    drop_column :users, :last_lock_date
    add_column :users, :last_lock_date, DateTime, null: true
  end

  down do
    drop_column :users, :last_lock_date
    add_column :users, :last_lock_date, Date, null: true
  end
end
