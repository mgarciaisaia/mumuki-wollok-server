require_relative './spec_helper'

describe QueryHook do
  let(:hook) { QueryHook.new('wollok_command' => 'wdk/bin/winterpreter.sh') }
  let(:file) { hook.compile(request) }
  let(:result) { hook.run!(file) }

  describe 'should pass on ok request' do
    let(:okCode) { 'object pepita { method energia() = 2 }' }
    let(:okQuery) { 'pepita.energia()' }

    let(:request) { qreq(okCode, okQuery) }
    it { expect(result).to eq ["=> 2\n", :passed] }
  end

  describe 'should pass on ok request with query dependent on extra' do
    let(:okCode) { 'object entrenador { method entrenada() = pepita }' }
    let(:okQuery) { 'entrenador.entrenada() == pepita' }
    let(:okExtra) { 'object pepita {}' }

    let(:request) { qreq(okCode, okQuery, okExtra) }
    it { expect(result).to eq ["=> true\n", :passed] }
  end
end
