module Paperclip
  class Transcoder < Processor
    DEFAULT_OPTIONS = {
        vb: 1024,
        ab: 128,
        vcodec: 'theo',
        acodec: 'vorbis',
        style: 'ogg',
        width: '100',
        height: '75',
        format: 'jpg',
        style: :ogg,
        time: 10
    }

    def make
      src = @file.path
      opts = DEFAULT_OPTIONS.merge(@options)
      if opts[:style] == :ogg
        dst = Tempfile.new('')
        opts = opts.merge({vb: `mediainfo #{src} | head -n 24 | tail -n 1 | cut -c 44- | cut -f 1 -d " "`.to_i})
        `vlc -I dummy -q #{src} \
        --sout "#transcode{vcodec=#{opts[:vcodec]}, \
        vb=#{opts[:vb]},acodec=#{opts[:acodec]}, \
        ab=#{opts[:ab]}}:standard{mux=#{opts[:style]}, \
        dst=#{dst.path},access=file}" vlc://quit`
      else
        `vlc -I dummy #{src} --rate=1 \
        --video-filter=scene --vout=dummy \
        --start-time=#{opts[:time]} \
        --scene-width=#{opts[:width]} \
        --scene-width=#{opts[:height]} \
        --scene-replace \
        --scene-prefix=#{@attachment.hash.to_s} \
        --stop-time=#{opts[:time] + 1} \
        --scene-format=#{opts[:format]} \
        --scene-ratio=24 \
        --scene-path=#{'/tmp/'} vlc://quit`
        dst = File.open(File.join('/tmp', @attachment.hash.to_s + '.' + opts[:format]))
      end
      dst
    end
  end
end
