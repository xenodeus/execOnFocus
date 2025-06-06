--[[
Copyright © 2025, Xenodeus
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of execOnFocus nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Xenodeus BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]--

_addon.name = "execOnFocus"
_addon.author = "Xenodeus"
_addon.version = "1.1"
_addon.commands = {"execOnFocus", "exof"}

require('tables')
require('functions')
require('strings')
require('chat')

function execute_command(msg)
    if msg:sub(1, 2) == '//' then
        windower.send_command(msg:sub(3))
    elseif msg:sub(1, 1) == '/' then
        windower.send_command('input '..msg)
    elseif msg:sub(1, 3) == 'atc' then
        windower.add_to_chat(55, msg:sub(5))
    else
        windower.send_command(msg)
    end
end

windower.register_event('addon command',function (...)
    if not ... then
        error('No command provided.')
        return
    end
    local command = T{...}:map(string.strip_format .. windower.convert_auto_trans):map(function(str)
        return str:find(' ', string.encoding.shift_jis, true) and str:enclose('"') or str
    end):sconcat():gsub('<(%a+)id>', function(target_string)
        local entity = windower.ffxi.get_mob_by_target(target_string)
        return entity and entity.id or '<' .. target_string .. 'id>'
    end)
    if windower.has_focus() then
        execute_command(command)
    end
end)
