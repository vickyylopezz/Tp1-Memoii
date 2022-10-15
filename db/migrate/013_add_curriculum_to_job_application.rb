Sequel.migration do
  up do
    add_column :job_applications, :curriculum, String
  end

  down do
    drop_column :job_applications, :curriculum
  end
end
