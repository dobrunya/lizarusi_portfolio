class Admin::HtmlsController < Admin::AdminController

  def index
    p @htmls = HtmlPage.all
  end

  def new
    @html = HtmlPage.create(html_params)
    redirect_to admin_htmls_path
  end

  def create

  end

  private

  def html_params
    params.permit(:html)
  end
end
