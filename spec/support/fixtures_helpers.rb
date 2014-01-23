module FixturesHelpers

  def fixture(path='')
    File.join(::RSpec.configuration.spec_root, 'fixtures', path)
  end

end
