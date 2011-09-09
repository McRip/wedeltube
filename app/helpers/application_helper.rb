module ApplicationHelper
  def getThumbUrl video, size
    if video.state == "converted"
      video.video.url(createThumbSymbol("thumb"+size.to_s, video.thumb_index))
    else
      case size
      when 128
        image_path("videos/converting128x72.png")
      when 266
        image_path("videos/converting266x150.png")
      when 640
        image_path("videos/converting640x360.png")
      when 854
        image_path("videos/converting854x480.png")
      end
    end
  end
  
  def createThumbSymbol name, index
    (name+index.to_s).to_sym
  end
end
