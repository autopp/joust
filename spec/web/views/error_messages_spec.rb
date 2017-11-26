require_relative '../../../apps/web/views/error_messages'

RSpec.describe Web::Views::ErrorMessages do
  let(:exposures) { { errors: errors } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tournament/index.html.erb') }
  let(:view) do
    Class.new do
      include Web::View
      include Web::Views::ErrorMessages
    end.new(template, exposures)
  end

  describe '#error_messages' do
    subject { view.error_messages.to_s }

    context 'when error is not given' do
      let(:errors) { nil }

      it { is_expected.to eq('') }
    end

    context 'when errors are given' do
      let(:errors) { %w[foo bar] }

      it 'generates error contents' do
        expect(subject).to include('<ul>') & include('</ul>') & include('foo') & include('bar')
      end
    end
  end
end
