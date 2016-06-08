require File.join(File.dirname(__FILE__), 'helper')

class Startup_test < Test::Unit::TestCase

  def test_startup
    # constructor needs 3 arguments
    assert_raise ArgumentError Supportconfig::Supportconfig.new
  end

end
