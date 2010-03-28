
fields         = [[tags = {}
abstract = {}
creator = {}
license = {}
lua_versions = {}
languages = {}
website = {}
releases = {}


]]
title          = "@Project"
category="projects"
actions        = [[show = "luaforge.show_project"

]]
config         = ""
markup_module  = ""
templates      = ""
translations   = ""
permissions    = ""
html_main      = ""
html_head      = ""
html_menu      = ""
html_logo      = ""
html_page      = ""
html_content   = [=[





<table class="project_info">
 <tr>
  <td rowspan="6" style="background:#f6f6ff;border-right:none;">
   <p style="font-size:120%"><b>$abstract</b></p>

   <p><a style="font-size:120%" href="$website">$website</a></p>


   <p>by: $do_authors[[<a href="">$id</a> ]]</p>
  </td>
</tr>
<td width="20%" style="border-bottom:none">
  $do_license[[$id license ]]
</td>
<tr><td style="border-bottom:none">★★★</td></tr>
<tr><td style="border-bottom:none">$do_languages[[$id]]</td></tr>
<tr><td style="border-bottom:none">LR: n/a</td></tr>
<tr><td style="font-size:90%">$do_tags[[$id]]</td></tr>
</table>

<h2>Archived Releases</h2>

<ul>
$do_releases[[<li>$id</li>]]
</ul>

<h2>Mailing Lists</h2>

<ul>
 <li>luajava-commits</li>
 <li>luajava-developers</li>
</ul>

]=]
html_body      = ""
html_header    = ""
html_footer    = ""
html_sidebar   = ""
html_meta_keywords= ""
html_meta_description= ""
redirect_destination= ""
xssfilter_allowed_tags= ""
http_cache_control= ""
http_expires   = ""
content        = ""
edit_ui        = [[tags = {1.4, "text_field"}
abstract = {1.5, "textarea"}
creator = {1.6, "text_field"}
license = {1.7, "text_field"}
lua_versions = {1.8, "text_field"}
languages = {1.81, "text_field"}
releases = {1.82, "textarea"}
website = {1.83, "text_field"}

]]
admin_edit_ui  = ""
breadcrumb     = ""
save_hook      = ""
