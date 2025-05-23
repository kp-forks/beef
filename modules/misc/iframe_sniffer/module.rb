#
# Copyright (c) 2006-2025 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - https://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
class Iframe_sniffer < BeEF::Core::Command
  def pre_send
    BeEF::Core::NetworkStack::Handlers::AssetHandler.instance.bind('/modules/misc/iframe_sniffer/leakyframe.js', '/leakyframe', 'js')
  end

  def self.options
    [
      { 'name' => 'inputUrl', 'ui_label' => 'input URL', 'type' => 'textarea', 'value' => 'http://en.wikipedia.org/wiki/Beef', 'width' => '400px', 'height' => '50px' },
      { 'name' => 'anchorsToCheck', 'ui_label' => 'anchors to check', 'value' => 'History,Exploit,Etymology,References,ABCDE', 'type' => 'textarea', 'width' => '400px',
        'height' => '100px' }
    ]
  end

  def post_execute
    content = {}
    content['resultList'] = @datastore['resultList']
    BeEF::Core::NetworkStack::Handlers::AssetHandler.instance.unbind('leakyframe.js')
    save content
  end
end
