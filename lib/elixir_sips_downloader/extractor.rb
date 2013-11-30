# The contract for Extractors.
class ElixirSipsDownloader::Extractor
  # Should be implemented by children.
  def extract
    fail NotImplementedError
  end
end
