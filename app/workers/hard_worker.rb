require 'sidekiq'
class HardWorker
  include Sidekiq::Worker
  def perform(path_to_html)
    kit = IMGKit.new(File.new(path_to_html))
    file_path = path_to_html.split('/')
    file_path[-1] = 'main_image.png'
    kit.to_file(file_path.join('/'))

  end
end