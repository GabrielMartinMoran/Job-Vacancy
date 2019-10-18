Sequel.migration do
  up do
    add_index :users, [:short_bio], unique: true
  end

  down do
    drop_index :users, [:short_bio]
  end
end
