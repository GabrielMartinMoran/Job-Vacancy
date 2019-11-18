Sequel.migration do
  up do
    add_column :users, :prefered_tags, String, null: true
  end

  down do
    drop_column :users, :prefered_tags
  end
end
