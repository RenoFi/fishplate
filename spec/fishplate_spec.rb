require './spec/app/app'

RSpec.describe Fishplate do
  it "has a version number" do
    expect(Fishplate::VERSION).not_to be nil
  end

  describe '.setup!' do
    subject { described_class.setup! }

    context 'when an app is configured correctly' do
      before { TestApp.new }

      it 'initializes without exception' do
        expect { subject }.not_to raise_exception
      end
    end
  end
end
