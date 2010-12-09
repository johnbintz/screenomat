require 'screenie/dsl/screen'

module Screenie
  module DSL
    class Session
      attr_accessor :name

      def initialize(name = '', code = '', &block)
        @name = name
        @screens = []
        @start_screen = 0

        @start_screen_to_use = nil

        if !code.empty?
          instance_eval(code)
        else
          instance_eval(&block)
        end
      end

      def screen(*opts)
        @screens << Screen.new(*opts)
      end

      def screen!(*opts)
        @start_screen_to_use = Screen.new(*opts)
        @screens << @start_screen_to_use
      end

      def to_cmd
        output = [ %{screen -dmS "#{@name}"} ]

        available_screen_ids = (0..9).to_a

        output += @screens.collect { |screen|
          if !screen.screen_id
            screen.screen_id = available_screen_ids.shift
          end

          commands = []
          commands << %{screen -X -S "#{@name}" #{screen.screen}} if !screen.screen.empty?
          commands << %{screen -X -S "#{@name}" #{screen.stuff}}
        }.flatten

        @start_screen = @start_screen_to_use.screen_id if @start_screen_to_use

        output << %{screen -x "#{@name}" -p #{@start_screen}}

        output
      end
    end
  end
end