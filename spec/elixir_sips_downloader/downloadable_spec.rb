require 'spec_helper'

describe ElixirSipsDownloader::Downloadable do
  subject(:downloadable) { downloadable_class.new }

  let(:downloadable_class) { Class.new ElixirSipsDownloader::Downloadable }

  describe 'contract' do
    specify('#download') {
      expect { downloadable.download }.to raise_error NotImplementedError
    }
  end
end
