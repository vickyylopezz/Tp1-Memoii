Sequel.migration do
  up do
    create_table(:job_applications) do
      primary_key :id
      String :applicant_email
      Integer :job_offer_id
    end
  end

  down do
    drop_table(:job_applications)
  end
end
