require 'spec_helper'
require 'screenomat/dsl/builder'

describe Screenomat::DSL::Builder do
  describe '#sessions' do
    context 'from block' do
      subject { Screenomat::DSL::Builder.new { session("cats") {  } }}

      specify { subject[:cats].should_not be_nil }
    end

    context 'from code' do
      subject { Screenomat::DSL::Builder.new(%{session("cats") {  } })}

      specify { subject[:cats].should_not be_nil }
    end
  end

  describe '#first' do
    subject { Screenomat::DSL::Builder.new { session do; end }}

    its(:first) { should be_a_kind_of(Screenomat::DSL::Session) }
  end
end
