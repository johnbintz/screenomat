require 'spec_helper'
require 'screenie/dsl/builder'

describe Screenie::DSL::Builder do
  describe '#sessions' do
    context 'from block' do
      subject { Screenie::DSL::Builder.new { session("cats") {  } }}

      specify { subject[:cats].should_not be_nil }
    end

    context 'from code' do
      subject { Screenie::DSL::Builder.new(%{session("cats") {  } })}

      specify { subject[:cats].should_not be_nil }
    end
  end

  describe '#first' do
    subject { Screenie::DSL::Builder.new { session do; end }}

    its(:first) { should be_a_kind_of(Screenie::DSL::Session) }
  end
end
