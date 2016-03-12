require 'zip'
class ZipService
  attr_accessor :file, :project

  SAVE_PATH = "#{Rails.root}/public/test"

  def initialize(file_path, project)
    @file = file_path
    @project = project
  end

  def unzip
    p "Removing directory: #{prepare_dir}"
    p "Creating directory: #{create_dir}"
    p 'Starting unzip'
    Zip::File.open(file) do |zip_file|
      zip_file.each do |entry|
        puts "Extracting file #{entry.name}"
        zip_file.extract(entry, "#{extract_path}/#{entry}") { true }
      end
    end
    remove_zip
    p 'Unzip ended.'
  end

  def extract_path
    SAVE_PATH + "/#{project.title}/"
  end

  def remove_zip
    FileUtils.rm_rf(file)
  end

  def create_dir
    FileUtils.mkdir_p(extract_path) unless File.directory?(extract_path)
  end

  def prepare_dir
    FileUtils.rm_rf(extract_path)
  end
end