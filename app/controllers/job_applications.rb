JobVacancy::App.controllers :job_applications do
  get :my_applications, map: '/my_applications' do
    @job_applications = []
    render 'job_applications/my_applications'
  end
end
