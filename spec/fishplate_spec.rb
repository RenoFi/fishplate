require './spec/app/app'

RSpec.describe Fishplate do
  it "has a version number" do
    expect(Fishplate::VERSION).not_to be nil
  end

  describe '.setup!' do
    subject { Fishplate.setup! }

    context 'when an app is configured correctly' do
      before { TestApp.new }

      it 'initializes without exception' do
        expect { subject }.to_not raise_exception
      end
    end
  end
end
