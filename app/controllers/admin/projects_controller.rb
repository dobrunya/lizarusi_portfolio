class Admin::ProjectsController < Admin::DashboardController
  def index
    @projects = Project.all
  end
  def new
    @project = Project.new
  end

  def destroy
    @project = Project.find(params[:id])
    if @project
      @project.delete

    end
    redirect_to admin_projects_path
  end

  def create
    p project_params
    @project = Project.new(project_params)

    if @project.save
      # flash[:success] = "Welcome to the Sample App!"
      redirect_to [:admin, @project]
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end



  private

  def project_params

      params.require(:project)

  end
end
