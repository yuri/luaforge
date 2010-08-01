module(...)
NODE = {
title          = "The Project Catalogue",
prototype      = "@Collection",
actions        = [[
show = "luaforge.show_project_list"

]]
}
NODE.html_content   = [=[$markup{$content}

<h2>Random Selection</h2>
<dl>
$do_sample_projects[[
  <dd><a href="$url" style="font-size:120%;text-decoration:none" title="$abstract">$short_id</b></a></dd>
  <dt style="margin-left:2em;margin-bottom:1em;">$abstract</dt>
]]
</dl>

<h2>All Projects</h2>

<!--table class="sortable" width="100%">
 <thead>
  <tr>
   <th width="20%">name</th>
   <th>description</th>
  </tr>
 </thead-->
 $do_letters[====[
 <h3>$letter</h3>

 <table class="invisible" borders=0 width="100%"><tr>
 $do_columns[=====[
 <td width="20%">
   
 $do_nodes[[
  <a href="$url" style="font-size:150%; text-decoration:none" title="$abstract">$prefix<b>$luafreeid</b></a><br/>
 ]]
 </td>
 ]=====]
 </tr>
 </table>
 ]====]
]=]
NODE.content        = "  "
