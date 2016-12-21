module ProjectsHelper

  def prepare_canvas_link(project)
    canvas = HtmlPage.joins('inner join projects as p on p.title = html_pages.title')
                      .where('main = true').where('html_pages.title = ?', project.title).pluck(:canvas)
    canvas.first
  end
end
