# feature tests for Pre

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TC_Pre < Test::Unit::TestCase
  
  def setup
    goto_page "pre.html"
  end
  
  def test_Pre_Count
    assert( browser.pres.length == 3 )
  end
  
  def test_Pre_Exists
    assert_false( browser.pre( :index, 33 ).exists? )
    assert( browser.pre( :index, 2 ).exists? )
    
    assert( browser.pre( :id, '1' ).exists? )
    assert( browser.pre( :id, /[3-9]/ ).exists? )
    assert_false( browser.pre( :id, /missing_pre/ ).exists? )
    assert_false( browser.pre( :id, 'missingPre' ).exists? )
        
    assert( browser.pre( :name, '3' ).exists? )
    assert_false( browser.pre( :name, "name_missing" ).exists? )
  end
    
  def test_simple_access
    pre = browser.pre( :index, 0 )
    assert( pre.text.include?( "simple pre space" ) )
    assert_false( pre.text.include?( "A second block" ) )
    
    pre = browser.pre( :index, 1 )
    assert( pre.text.include?( "A second block" ) )
    assert_false( pre.text.include?( "this is the last block" ) )
  end

  tag_method :test_embedded_spaces, :fails_on_firefox # http://jira.openqa.org/browse/WTR-267
  def test_embedded_spaces
    pre = browser.pre( :index, 2 )
    assert( pre.text.include?( "continue    to work" ) )
    assert_false( pre.text.include?( "Pre Tag Test" ) )
  end

  tag_method :test_html, :fails_on_firefox # http://jira.openqa.org/browse/WTR-260
  def test_html
    pre = browser.pre(:index, 0)
    assert( pre.html.gsub('"','').include?( "id=1 name=1" ) )
  end
  
end
