Sequel.migration do
  up do
    add_column :users, :short_bio, String
  end

  down do
    drop_column :users, :short_bio
  end
end
