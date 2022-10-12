Sequel.migration do
  up do
    add_column :job_applications, :personal_bio, String
  end

  down do
    drop_column :job_applications, :personal_bio
  end
end
