module Admin
  class ProjectsController < Admin::DashboardController

    def index
      @projects = Project.all
    end

    def new
      @project = Project.new
    end

    def destroy
      @project = Project.find(params[:id])
      if @project
        @project.destroy
      end
      redirect_to admin_projects_path
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        path_to_html = "#{Rails.root}/public/projects/" + @project.title + '/' + params[:project][:html_pages_attributes][0][:html].original_filename
        path_to_zip = 'public/projects/' + @project.title + '/' +  params[:project][:file].original_filename
        NoActiveRecordUploader.new(@project.title, params[:project][:file]).save
        ZipService.new(path_to_zip, @project).unzip
        HardWorker.perform_async(path_to_html)
        redirect_to [:admin, @project]
      else
        render 'new'
      end
    end

    def edit
      @project = Project.find(params[:id])
    end
    def update
      project = Project.find(params[:id])
      # project.update_attributes(project_params)
      if project.update_attributes(project_params)
        redirect_to [:admin, project]
      else
        rendirect_to edit_admin_project_path("#{project.id}")
      end

    end
    def show
      @project = Project.find(params[:id])
    end

    private

    def project_params
      params.require(:project).permit(:title, html_pages_attributes: [:html])
    end

    def unzip  #TODO

    end

    def make_image #TODO


    end
  end
end