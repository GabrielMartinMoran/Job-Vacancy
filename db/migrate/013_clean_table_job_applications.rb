Sequel.migration do
  up do
    from(:job_applications).delete
  end

  down do
  end
end
