require 'screenomat/dsl/session'

module Screenomat
  module DSL
    class Builder
      attr_reader :sessions

      def initialize(code = '', &block)
        @sessions = []

        if !code.empty?
          instance_eval(code)
        else
          instance_eval(&block)
        end
      end

      def session(name = nil, &block)
        name ||= "screenie-#{Time.now.to_i}"

        session = Session.new(name.to_sym, &block)

        @sessions << session
      end

      def first
        @sessions.first
      end

      def [](key)
        @sessions.find { |session| session.name == key }
      end
    end
  end
end
