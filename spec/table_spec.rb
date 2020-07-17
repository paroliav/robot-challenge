require_relative "../lib/table"

RSpec.describe Table do
  context '#initiialize' do
    subject { described_class.new }
    it 'initializes x-axis of the table to a pre-configured value' do
      expect(subject.x).to eq(5)
    end

    it 'initializes y-axis of the table to a pre-configured value' do
      expect(subject.y).to eq(5)
    end
  end

  context '#valid?' do
    let(:table) { described_class.new }

    subject { table.valid?(coordinate) }

    context 'when outside the bounds of table' do
      context 'when x is below 0' do
        let(:coordinate) { {x: -1, y: 2} }
        it { is_expected.to be_falsey }
      end
      context 'when y is below 0' do
        let(:coordinate) { {x: 0, y: -1} }
        it { is_expected.to be_falsey }
      end
      context 'when x is above 4' do
        let(:coordinate) { {x: 5, y: 2} }
        it { is_expected.to be_falsey }
      end
      context 'when y is above 4' do
        let(:coordinate) { {x: 0, y: 6} }
        it { is_expected.to be_falsey }
      end
    end

    context 'when inside the bounds of table' do
      context 'when x and y is 4' do
        let(:coordinate) { {x: 4, y: 4} }
        it { is_expected.to be_truthy }
      end
      context 'when x and y is 0' do
        let(:coordinate) { {x: 0, y: 0} }
        it { is_expected.to be_truthy }
      end
      context 'when x is 2 and y is 1' do
        let(:coordinate) { {x: 2, y: 1} }
        it { is_expected.to be_truthy }
      end
    end
  end
end
