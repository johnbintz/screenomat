require 'spec_helper'
require 'screenie/dsl/session'

describe Screenie::DSL::Session do
  describe '#to_cmd' do
    context 'one screen' do
      subject {
        Screenie::DSL::Session.new("my-session") { screen "test" }.to_cmd
      }

      it { should == [
        %{screen -dmS "my-session"},
        %{screen -X -S "my-session" -p 0 stuff "test
"},
        %{screen -x "my-session" -p 0}
      ] }
    end

    context 'two screens' do
      subject {
        Screenie::DSL::Session.new("my-session") { screen "test"; screen "test2" }.to_cmd
      }

      it { should == [
        %{screen -dmS "my-session"},
        %{screen -X -S "my-session" -p 0 stuff "test
"},
        %{screen -X -S "my-session" screen 1},
        %{screen -X -S "my-session" -p 1 stuff "test2
"},
        %{screen -x "my-session" -p 0}
      ] }
    end
  end

  describe 'from string' do
    subject {
      Screenie::DSL::Session.new("my-session", <<-EOR).to_cmd
screen "test"
      EOR
    }

    it { should == [
      %{screen -dmS "my-session"},
      %{screen -X -S "my-session" -p 0 stuff "test
"},
      %{screen -x "my-session" -p 0}
    ] }
  end

  describe 'screen!' do
    subject {
      Screenie::DSL::Session.new("my-session") { screen "test"; screen! "test2" }.to_cmd
    }

    it { should == [
      %{screen -dmS "my-session"},
      %{screen -X -S "my-session" -p 0 stuff "test
"},
      %{screen -X -S "my-session" screen 1},
      %{screen -X -S "my-session" -p 1 stuff "test2
"},
      %{screen -x "my-session" -p 1}
    ] }
  end
end
