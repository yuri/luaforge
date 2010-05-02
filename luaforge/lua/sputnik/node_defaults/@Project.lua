module(...)
NODE = {}

NODE.fields         = [[tags = {}
abstract = {}
creator = {}
license = {}
--lua_versions = {}
languages = {}
website = {}
releases = {}
lists = {}

]]
NODE.translations = "luaforge/translations"
NODE.title          = "@Project"
NODE.category="projects"
NODE.actions        = [[show = "luaforge.show_project"

]]

NODE.html_content   = [=[

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

$releases

<h2>Mailing Lists</h2>

$lists

]=]

NODE.edit_ui        = [[
content = nil
website = {1.4, "text_field"}
creator = {1.5, "text_field"}
license = {1.6, "text_field"}
abstract = {1.7, "textarea"}
abstract.editor_modules = {
                      "resizeable",
                      "markitup",
}
--lua_versions = {1.8, "text_field"}
languages = {1.8, "text_field"}
releases = {1.91, "textarea"}
releases.editor_modules = {
                      "resizeable",
                      "markitup",
}
lists = {1.92, "textarea"}
lists.editor_modules = {
                      "resizeable",
                      "markitup",
}
tags = {1.95, "text_field"}

]]
