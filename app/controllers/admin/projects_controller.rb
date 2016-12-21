module Admin
  class ProjectsController < Admin::DashboardController
    before_action :set_project, only: [:destroy, :edit, :update, :show]

    def index
      @projects = Project.all
    end

    def new
      @project = Project.new
      @html_page = @project.html_pages.build
    end

    def destroy
      @project.destroy if @project
      redirect_to admin_projects_path
    end

    def delete_html
      HtmlPage.find(params[:id]).destroy
      respond_to do |format|
        format.json { render :json => 'Success' }
      end
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        project_folder_changes
        redirect_to [:admin, @project]
      else
        render 'new'
      end
    end

    def edit
      @html_pages = @project.html_pages
    end

    def update
      if params[:project][:replace] == 'true'
        replace_project
      else
        add_to_project
      end
      redirect_to [:admin, @project]
    end

    def show

    end

      private

    def project_folder_changes
      2.times do |step|
        begin
          case step
            when 0 then upload_zip
            when 1 then unzip_zip
          end
        rescue
        end
      end
    end

    def upload_zip
      NoActiveRecordUploader.new(@project.title, params[:project][:file]).save
    end

    def replace_project
      @project.html_pages.destroy_all
      FileUtils.rm_rf("public/projects/#{ title }")
      @project.update_attributes(project_params)
      project_folder_changes
    end

    def add_to_project
      html_pages = html_pages_params
      update_title(params_title) if title != params_title
      html_pages.count.times do |index|
        html_page = HtmlPage.new(html: html_pages[index][:html], title: params_title, main: html_pages[index][:main])
        html_page.save
      end
      project_folder_changes
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def update_title(new_title)
      FileUtils.mv("public/projects/#{ title }","public/projects/#{ new_title }")
      HtmlPage.where(title: title).update_all(title: new_title)
      @project.update_attributes(title: new_title)
    end

    def unzip_zip(path = nil)
      path ||= 'public/projects/' + @project.title + '/' +  params[:project][:file].original_filename
      ZipService.new(path, @project).unzip
    end

    def html_pages_params
      html_pages = project_params[:html_pages_attributes]
      html_pages.select do |elem|
         !elem[:html].blank?
      end
    end

    def project_params
      params.require(:project).permit(:title, :add,  :html_pages_attributes => [:html, :main] )
    end

    def title
      @project.title
    end

    def params_title
      params[:project][:title]
    end
  end
end