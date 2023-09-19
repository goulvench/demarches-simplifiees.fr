module UninterlacePngConcern
  extend ActiveSupport::Concern

  private

  def uninterlace_png(uploaded_file)
    if uploaded_file&.content_type == 'image/png'
      chunky_img = ChunkyPNG::Image.from_io(uploaded_file.to_io)
      chunky_img.save(uploaded_file.tempfile.to_path, interlace: false)
      uploaded_file.tempfile.reopen(uploaded_file.tempfile.to_path, 'rb')
    end
    uploaded_file
  end
end
