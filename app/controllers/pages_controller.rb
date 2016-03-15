class PagesController < ApplicationController

  def home

  end

  def about

  end

  def portfolio
    @projects = Project.all
  end
  # def project
  #   title = params[:title]
  #   html_name = params[:name] + '.html'
  #   project = Project.find_by(title: title)
  #   if project
  #     html_path = project.html_pages.find_by(html: html_name).html.file.file
  #     render file: html_path, layout: false
  #   else
  #     redirect_to portfolio_path
  #   end
  #
  # end
end
