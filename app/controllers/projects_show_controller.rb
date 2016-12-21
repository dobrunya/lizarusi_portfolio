require 'uri'
class ProjectsShowController < ApplicationController
  layout false
  include ProjectsProcessor
  skip_before_action :verify_authenticity_token
  def generate_image
    p '-'*100
    main_html = HtmlPage.where(title: URI.decode(params[:title]), main: true).first
    main_html.update_attributes(canvas: params[:canvasURL])
    respond_to do |format|
      format.json { render :json => 'Success' }
    end
  end

end
