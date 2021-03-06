require_relative 'spec_helper'

describe TestHook do
  let(:runner) { TestHook.new('wollok_command' => 'wdk/bin/winterpreter.sh') }

  describe '#run' do
    context 'on failed submission' do
      let(:file) { File.new 'spec/data/failed/compilation.wtest' }
      let(:result) { runner.run!(file) }

      it { expect(result[1]).to eq :failed }
      it { expect(result[0]).to include 'wollok.lang.Exception: Expected [4] but found [1]' }
    end

    context 'on passed submission' do
      let(:file) { File.new 'spec/data/passed/compilation.wtest' }
      let(:result) { runner.run!(file) }

      it { expect(result[1]).to eq :passed }
    end
  end
end
