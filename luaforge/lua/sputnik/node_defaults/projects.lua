module(...)
NODE = {
title          = "projects",
prototype      = "@Collection"
}
NODE.html_content   = [=[$markup{$content}

<br/><br/>

<table class="sortable" width="100%">
 <thead>
  <tr>
   <th width="20%">name</th>
   <th>description</th>
  </tr>
 </thead>
 $do_nodes[[
  <tr>
   <td><a href="$url" style="font-size:120%;text-decoration:none">$title</a></td>
   <td>$abstract</td>
  </tr>
 ]]
 </table>
]=]
NODE.content        = "Projects blah blah blah blah email blah blah blah."
