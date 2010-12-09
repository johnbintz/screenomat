require 'spec_helper'
require 'screenomat/dsl/screen'

describe Screenomat::DSL::Screen do
  describe '#to_cmd' do
    let(:screen) { Screenomat::DSL::Screen.new(*params) }

    subject { screen }

    context 'blank' do
      let(:params) { [] }

      its(:screen) { should == 'screen 0' }
    end

    context 'with command' do
      let(:params) { ["command"] }

      its(:screen) { should == 'screen 0' }
      its(:stuff) { should == %{-p 0 stuff "command
"} }
    end

    context 'with number id' do
      let(:params) { [ 1 ] }

      its(:screen) { should == "screen 1" }

      specify { screen.screen_id.should == 1 }
    end

    context 'with number id and command' do
      let(:params) { [ 1, "command" ] }

      its(:screen) { should == "screen 1" }
      its(:stuff) { should == %{-p 1 stuff "command
"} }
      specify { screen.screen_id.should == 1 }
    end

    context 'with title' do
      let(:params) { [ { :title => 'My title' } ] }

      its(:screen) { should == %{screen -t "My title" 0} }
      specify { screen.screen_id.should == nil }
    end
  end
end
