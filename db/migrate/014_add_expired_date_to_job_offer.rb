Sequel.migration do
  up do
    add_column :job_offers, :expired_date, Date
  end

  down do
    drop_column :job_offers, :expired_date
  end
end
