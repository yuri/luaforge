module(..., package.seeall)
actions = {}

local wiki = require("sputnik.actions.wiki")
local cosmo = require("cosmo")
local util = require("sputnik.util")

DEFAULT_ICON = "http://sputnik.freewisdom.org/en/icons/user.png"

function actions.show_project(node, request, sputnik)
   
   local split = function(value, sep)
      sep = sep or ", *"
      return ipairs({util.split(value or "", sep)})
   end

   local auth = sputnik.auth
   local function get_icon(id)
      if auth:user_exists(id) then
         local icon = auth:get_metadata(id, "twitter_icon")
         if icon then return icon end
      end
      return DEFAULT_ICON
   end

   local lists = node.markup.transform(node.lists or "")
   local releases = node.markup.transform(node.releases or "")
   node.inner_html = cosmo.f(node.html_content){
                               abstract = node.abstract,
                               website = node.website,
                               if_lists = cosmo.c(string.len(node.lists or "") > 0){lists=lists},
                               if_releases = cosmo.c(string.len(node.releases or "") > 0){releases = releases},
                               do_authors = function() for i,v in split(node.creator) do cosmo.yield{id=v, icon=get_icon(v)} end end,
                               if_single_author = cosmo.c(not node.creator:match(",")){id=node.creator},
                               do_license = function() for i,v in split(node.license) do cosmo.yield{id=v} end end,
                               do_languages = function() for i,v in split(node.languages) do cosmo.yield{id=v} end end,
                               do_tags = function() for i,v in split(node.tags) do cosmo.yield{id=v} end end,
                               --do_releases = function() for i,v in split(node.releases, "\n") do cosmo.yield{id=v} end end,
                             }

   return node.wrappers.default(node, request, sputnik)
end

function actions.show_project_list(node, request, sputnik)
   local node_hash, node_ids, num_hidden = node:get_visible_children(request.user or "Anonymous")
   local non_proto_nodes = {}
   for i, id in ipairs(node_ids) do
      n = node_hash[id]
      if n.id ~= node.id .. "/@Child" then
         table.insert(non_proto_nodes, n)
      end
   end

   local template = node.translator.translate(node.html_content)

   local nodes_by_first_letter = {}
   local letters = {}
   for i, node in ipairs(non_proto_nodes) do
      local id = node.id:sub(10)
      local prefix = ""
      local luafreeid = id
      if id:sub(0,4)=="lua-" then
         prefix = id:sub(0,4)
         luafreeid = id:sub(5)
      elseif id:sub(0,3) == "lua" then
         prefix = id:sub(0,3)
         luafreeid = id:sub(4)
      end
      local first_letter = luafreeid:sub(1,1)
      if first_letter:match("%d") then
         first_letter = "0-9"
      end
      if not nodes_by_first_letter[first_letter] then
         table.insert(letters, first_letter)
         nodes_by_first_letter[first_letter] = {}
      end
      table.insert(nodes_by_first_letter[first_letter], {node, prefix, luafreeid})
   end
   table.sort(letters)

   local values = {
      new_id  = node.id .. "/new",
      new_url = sputnik:make_url(node.id.."/new", "edit"),
      id      = node.id,
      content = node.content,
      markup = function(params)
         return node.markup.transform(params[1], node)
      end,

      do_sample_projects = function()


         for i=1,3 do

            local rand = math.ceil(math.random()*(#non_proto_nodes))
            local node = non_proto_nodes[rand]
            cosmo.yield{
               short_id = node.id:sub(10),
               abstract = node.abstract,
               url = sputnik:make_url(node.id),
            }
         end

      end,

      do_letters = function()

         for i,letter in ipairs(letters) do

            local nodes = nodes_by_first_letter[letter]

            table.sort(nodes, function(x,y) return x[3] < y[3] end)


            local num_cols = 5
            local step = math.ceil(#nodes / num_cols)

            cosmo.yield {
               letter = letter:upper(),
               do_columns = function()
                  for col=1,num_cols do
                     cosmo.yield{
                        do_nodes = function()
                           for i=step*(col-1)+1,step*col do --node_record in ipairs(nodes) do
                              local node_record = nodes[i]
                              if node_record then
                                 local node, prefix, luafreeid = unpack(node_record)
                                  cosmo.yield{
                                     short_id = id,
                                     prefix = prefix,
                                     luafreeid = luafreeid,
                                     abstract = node.abstract,
                                     url = sputnik:make_url(node.id)
                                  }
                              end
                           end
                        end
                     }
                  end
               end  
            }
         end
      end,
   }

   for k,v in pairs(node.template_helpers or {}) do
      values[k] = v
   end

   for k,v in pairs(node.fields) do
      if not values[k] then
         values[k] = tostring(node[k])
      end
   end

   
   for action_name in pairs(node.actions) do
      if node:check_permissions(request.user, action_name) then
         sputnik.logger:debug("Action: " .. tostring(action_name))
         values[action_name .. "_link"] = sputnik:make_url(node.id, action_name)
         values["if_user_can_" .. action_name] = cosmo.c(true){}
      else
         values["if_user_can_" .. action_name] = cosmo.c(false){}
      end
   end

   node.inner_html = cosmo.fill(template, values)
   return node.wrappers.default(node, request, sputnik)
end


