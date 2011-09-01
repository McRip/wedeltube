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

        adjustments = calculate_video_adjustments width, height
        if (adjustments[:adjustment] == :horizontal)
          @size = adjustments[:dest_size].to_s+"x"+height.to_s
          padding_string = "-vf pad="+width.to_s+":"+height.to_s+":"+(adjustments[:padding]/2).to_s+":0:black"
        else
          @size = height.to_s+"x"+adjustments[:dest_size].to_s
          padding_string = "-vf pad="+width.to_s+":"+height.to_s+":0:"+(adjustments[:padding]/2).to_s+":black"
        end

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
          -er 4 -y -i #{File.expand_path(@file.path)} -acodec #{audio_codec} -ar 48000 -ab #{audio_bitrate} -s #{@size} -vcodec #{video_codec} -b #{video_bitrate} -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -subq 5 -trellis 1 -refs 1 -coder 0 -me_range 16 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt #{video_bitrate} -maxrate #{video_bitrate} -bufsize #{video_bitrate} -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -level 30 -aspect #{@aspect} #{padding_string} -g 30 -ss 0 -t 90 -async 2 #{File.expand_path(dst.path)}
        command

      elsif @thumbnail
        time_offset = -(@index*(@inspector.duration/5)/1000)
        size = @size.split('x')
        adjustments = calculate_video_adjustments size[0].to_i, size[1].to_i
        if (adjustments[:adjustment] == :horizontal)
          @size = adjustments[:dest_size].to_s+"x"+size[1].to_i
          padding_string = "-vf pad="+width.to_s+":"+height.to_s+":"+(adjustments[:padding]/2).to_s+":0:black"
        else
          @size = size[0].to_i+"x"+adjustments[:dest_size].to_s
          padding_string = "-vf pad="+width.to_s+":"+height.to_s+":0:"+(adjustments[:padding]/2).to_s+":black"
        end
        
        command = <<-command
          -itsoffset #{time_offset} -i #{File.expand_path(@file.path)} -y -vcodec mjpeg -vframes 1 -an -f rawvideo -s #{@size} #{File.expand_path(dst.path)}
        command
      end
      begin
        success = Paperclip.run('ffmpeg', command)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the thumbnail for #{@basename}" if whiny
      end
      dst
    end

    private

    def size_adjustment_factor src_height, dest_height
      dest_height.to_f/src_height.to_f
    end

    def calculate_video_adjustments width, height
      adjustment = :horizontal
      dest_size = (@inspector.width*size_adjustment_factor(@inspector.height, height)).floor
      padding = width - dest_size

      if dest_size > width
        adjustment = :vertical
        dest_size = (@inspector.height*size_adjustment_factor(@inspector.width, width)).floor
        padding = height - dest_size
      end
      
      {:adjustment => adjustment, :dest_size => dest_size, :padding => padding}
    end
  end
end