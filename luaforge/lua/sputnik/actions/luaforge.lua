module(..., package.seeall)
actions = {}

local wiki = require("sputnik.actions.wiki")
local cosmo = require("cosmo")
local util = require("sputnik.util")


function actions.show_project(node, request, sputnik)
   
   local split = function(value, sep)
      sep = sep or ","
      return ipairs({util.split(value or "", sep)})
   end

   local lists = node.markup.transform(node.lists or "")
   local releases = node.markup.transform(node.releases or "")
   node.inner_html = cosmo.f(node.html_content){
                               abstract = node.abstract,
                               website = node.website,
                               lists = lists,
                               releases = releases,
                               do_authors = function() for i,v in split(node.creator) do cosmo.yield{id=v} end end,
                               do_license = function() for i,v in split(node.license) do cosmo.yield{id=v} end end,
                               do_languages = function() for i,v in split(node.languages) do cosmo.yield{id=v} end end,
                               do_tags = function() for i,v in split(node.tags) do cosmo.yield{id=v} end end,
                               --do_releases = function() for i,v in split(node.releases, "\n") do cosmo.yield{id=v} end end,
                             }

   return node.wrappers.default(node, request, sputnik)
end
