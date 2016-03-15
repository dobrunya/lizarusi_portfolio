require 'nokogiri'
require 'uri'

module ProjectsProcessor



  def self.included(base)

    base.send(:before_filter, :load_newsletter, :only => :show)
  end
  def html_name(path_name) #TODO
    if !path_name
      'index.html'
    else
      if path_name.split('.').last == 'html'
        path_name
      else
        path_name + '.html'
      end
    end
  end
  def show
    if params[:format] == "html"
      redirect_to portfolioo_path(params[:title], params[:name])
      return
    end
    if params[:name] == "index"
      redirect_to portfolioo_path(params[:title])+'/'
      return
    end
    @template_dir = "projects/#{params[:title]}"
    @template_path = "public/#{@template_dir}/#{html_name(params[:name])}"
    content = render_to_string(:file => @template_path)
    @content = TemplateParser.new(request, params[:title]).parse(content)
    p '------------------------------------------------------------------------------------'
    render :text => @content, :layout => false
  end

  private

  def load_newsletter
    # @newsletter = Projects.find(params[:title])
    p 'roar'
  end

  class TemplateParser
    cattr_accessor :request
    cattr_accessor :params

    def initialize(request, title)
      self.request = request
      self.params = {}
      self.params[:title] = title
    end

    def parse(content)
      content = Nokogiri::HTML(content)
      return parse_content(parse_assets_url(content))
    end

    private

    def parse_assets_url(content)
      #Parse Image URL
      content.css("img").each do |img|
        update_asset_attribute(img, "src")
      end

      #Parse Stylesheet URL
      content.css("link").each do |link|
        update_asset_attribute(link, "href")
      end

      return content
    end

    def parse_content(content)
      content = content.to_s
      content.gsub!(/\{(.*)\}/) do |exp|
        replace_attribute_value(exp)
      end

      return content
    end

    def replace_attribute_value(exp, attributes = self.params)
      key = exp.delete('{}').downcase.to_sym
      attributes.has_key?(key) ? attributes[key] : exp
    end

    def update_asset_attribute(ele, key)
      path = ele.attributes[key].value
      ele.attributes[key].value = full_url(path)
    end

    def full_url(path)
      url = URI.parse(path)
      return !url.scheme ? "#{self.request.scheme}://#{self.request.host_with_port}/projects/#{params[:title]}/#{url.path}" : path
    end
  end
end