# The contract for Downloadables.
class ElixirSipsDownloader::Downloadable
  # Should be implemented by children.
  def download
    fail NotImplementedError
  end
end
