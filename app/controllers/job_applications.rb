JobVacancy::App.controllers :job_applications do
  get :my_applications, map: '/my_applications' do
    @job_applications = JobApplicationRepository.new
                                                .find_by_applicant_id(current_user.id)
    render 'job_applications/my_applications'
  end
end
