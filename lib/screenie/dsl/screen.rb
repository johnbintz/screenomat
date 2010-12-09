module Screenie
  module DSL
    class Screen
      attr_accessor :screen_id

      def initialize(*options)
        @options = options
        @screen_id = nil

        if @options.first.kind_of?(::Fixnum)
          @screen_id = @options.shift
        end
      end

      def stuff
        output = [ %{-p #{@screen_id || 0} stuff} ]

        if @options.first.kind_of?(::String)
          output << %{"#{@options.first}\n"}
        end

        output * ' '
      end

      def screen
        title = nil
        if @options.last.kind_of?(::Hash)
          opts = @options.last
          title = opts[:title]
        end

        if @screen_id == 0
          output = []
          output << %{-p 0 title "#{title}"} if title
        else
          output = %w{screen}

          output << %{-t "#{title}"} if title

          output << (@screen_id || 0)
        end

        output * ' '
      end
    end
  end
end
