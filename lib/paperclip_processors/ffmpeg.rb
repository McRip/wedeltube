require File.join(File.expand_path(Rails.root), "lib", "inspector.rb")

module Paperclip
  class Ffmpeg < Processor
    attr_accessor :video, :thumbnail, :size, :format, :basename, :current_format, :file, :video_codec, :audio_codec, :video_bitrate, :audio_bitrate, :index, :time_offset

    def initialize(file, options = {}, attachment = nil)
      super

      #set options
      @basename       = File.basename(file.path)
      @current_format = File.extname(file.path)
      @file           = file

      @video          = options[:video]
      @thumbnail      = options[:thumbnail]
      
      if @video
        puts "================== VIDEO ================="
        puts file
        puts options

        @aspect         = options[:size].gsub(/x/, ':')   || "480:320"
        @size           = options[:size]                  || "480x320"
        @format         = options[:format]                || "ogg"

        case @size
        when "320x240"
          @video_bitrate = 400
          @audio_bitrate = 96
        when "480x320"
          @video_bitrate = 800
          @audio_bitrate = 128
        when "1280x720"
          @video_bitrate = 2500
          @audio_bitrate = 192
        end

        @video_bitrate *= 1024          #ffmpeg uses bits not kbits
        @audio_bitrate *= 1024          #ffmpeg uses bits not kbits

        case @format
        when "ogv"
          @video_codec = "libtheora"
          @audio_codec = "libvorbis"
        when "mp4"
          @video_codec = "libx264"
          @audio_codec = "libfaac"
        when "webm"
          @video_codec = "libvpx"
          @audio_codec = "libvorbis"
        end
      elsif @thumbnail
        puts "================== THUMB ================="
        puts file
        puts options

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

     puts "temp Path: "+dst.path
     puts "basename: "+@basename
     puts "format: "+@format


      if @video
        command = <<-command
          -er 4 -y -i #{File.expand_path(@file.path)} -acodec #{@audio_codec} -ar 48000 -ab #{@audio_bitrate} -s #{@size} -vcodec #{@video_codec} -b #{@video_bitrate} -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -subq 5 -trellis 1 -refs 1 -coder 0 -me_range 16 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt #{@video_bitrate} -maxrate #{@video_bitrate} -bufsize #{@video_bitrate} -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -level 30 -aspect #{@aspect} -g 30 -ss 0 -t 90 -async 2 #{File.expand_path(dst.path)}
        command

      elsif @thumbnail
        inspector = RVideo::Inspector.new({:file => File.expand_path(@file.path)})
        duration = inspector.duration

        time_offset = -(@index*(duration/5)/1000)

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
  end
end