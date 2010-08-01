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
