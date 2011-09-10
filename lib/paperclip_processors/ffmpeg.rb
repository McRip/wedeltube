require File.join(File.expand_path(Rails.root), "lib", "inspector.rb")

module Paperclip
  class Ffmpeg < Processor
    attr_accessor :video, :thumbnail, :size, :format, :basename, :current_format,
                  :file, :index, :time_offset, :inspector

    def initialize(file, options = {}, attachment = nil)
      super

      #set options
      @basename       = File.basename(file.path)
      @current_format = File.extname(file.path)
      @file           = file

      @video          = options[:video]
      @thumbnail      = options[:thumbnail]
      @inspector      = RVideo::Inspector.new({:file => File.expand_path(@file.path)})
      
      if @video
        @aspect         = "16:9"
        @size           = options[:size]                  || "640x360"
        @format         = options[:format]                || "ogg"

        

        
      elsif @thumbnail
        @size           = options[:size]                  || "300x300"
        @format         = options[:format]                || "jpg"
        @index          = options[:index]                 || 1
      end
    end

    def make
      Paperclip.options[:log_command] = true

      # Create temp file for output
      dst = Tempfile.new([@basename, "."+@format])
      dst.binmode

      if @video

        case @size
        when "640x360"
          video_bitrate = 400
          audio_bitrate = 96
          width = 640
          height = 360
        when "854x480"
          video_bitrate = 800
          audio_bitrate = 128
          width = 854
          height = 480
        when "1280x720"
          video_bitrate = 2500
          audio_bitrate = 192
          width = 1280
          height = 720
        end

        video_bitrate *= 1024          #ffmpeg uses bits not kbits
        audio_bitrate *= 1024          #ffmpeg uses bits not kbits

        video_size = calculate_video_size width, height
        @size = video_size[:width].to_s+"x"+video_size[:height].to_s
        padding_string = "-vf pad="+width.to_s+":"+height.to_s+":"+(video_size[:hPadding]/2).to_s+":"+(video_size[:vPadding]/2).to_s+":black"
        
        case @format
        when "ogv"
          video_codec = "libtheora"
          audio_codec = "libvorbis"
        when "mp4"
          video_codec = "libx264"
          audio_codec = "libfaac"
        when "webm"
          video_codec = "libvpx"
          audio_codec = "libvorbis"
        end
        
        command = <<-command
          -er 4 -y -i #{File.expand_path(@file.path)} -acodec #{audio_codec} -ar 48000 -ab #{audio_bitrate} -s #{@size} -vcodec #{video_codec} -b #{video_bitrate} -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -subq 5 -trellis 1 -refs 1 -coder 0 -me_range 16 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt #{video_bitrate} -maxrate #{video_bitrate} -bufsize #{video_bitrate} -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -level 30 -aspect #{@aspect} #{padding_string} -g 30 -ss 0 -async 2 #{File.expand_path(dst.path)}
        command

      elsif @thumbnail
        time_offset = -(@index*(@inspector.duration/5)/1000)
        
        size = @size.split('x')
        width = size[0].to_i
        height = size[1].to_i
        
        video_size = calculate_video_size width, height
        @size = video_size[:width].to_s+"x"+video_size[:height].to_s
        padding_string = "-vf pad="+width.to_s+":"+height.to_s+":"+(video_size[:hPadding]/2).to_s+":"+(video_size[:vPadding]/2).to_s+":black"
        
        command = <<-command
          -itsoffset #{time_offset} -i #{File.expand_path(@file.path)} -y -vcodec mjpeg -vframes 1 -an -f rawvideo -s #{@size} #{padding_string} #{File.expand_path(dst.path)}
        command
      end
      begin
        puts command
        success = Paperclip.run('ffmpeg', command)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the thumbnail for #{@basename}" if whiny
      end
      dst
    end

    private

    def size_adjustment_factor src, dest
      dest.to_f/src.to_f
    end

    def calculate_video_size width, height
      width_adjustment_factor = size_adjustment_factor(@inspector.height, height)
      height_adjustment_factor = size_adjustment_factor(@inspector.width, width)
      
      if (@inspector.width == width && @inspector.height == height)
        res_width = width
        res_height = height
        h_padding = 0
        v_padding = 0
      else
        res_width = (@inspector.width*width_adjustment_factor).floor
        res_height = height
        h_padding = width - res_width
        v_padding = 0
        if res_width > width
          res_width = width
          res_height = (@inspector.height*height_adjustment_factor).floor
          h_padding = 0
          v_padding = height - res_height
        end
      end
      
      {:width => res_width, :height => res_height, :hPadding => h_padding, :vPadding => v_padding}
    end
  end
end