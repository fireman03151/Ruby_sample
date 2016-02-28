module Docs
  class NginxLuaModule < Github
    self.name = 'nginx / Lua Module'
    self.slug = 'nginx_lua_module'
    self.release = '0.10.0'
    self.base_url = 'https://github.com/openresty/lua-nginx-module/tree/v0.10.0/'

    html_filters.push 'nginx_lua_module/clean_html', 'nginx_lua_module/entries', 'title'

    options[:root_title] = 'ngx_http_lua_module'
    options[:container] = '#readme > article'

    options[:attribution] = <<-HTML
      &copy; 2009&ndash;2016 Xiaozhe Wang (chaoslawful)<br>
      &copy; 2009&ndash;2016 Yichun "agentzh" Zhang (章亦春), CloudFlare Inc.<br>
      Licensed under the BSD License.
    HTML
  end
end
