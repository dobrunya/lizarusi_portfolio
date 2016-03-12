class NoActiveRecordUploader
  def initialize(title, file)
    @title = title
    @file = file
  end
  def save
    name = @file.original_filename
    directory = "public/projects/" + @title
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(@file.read) }
  end
end