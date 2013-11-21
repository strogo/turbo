--- Turbo.lua "The parrot". Repeats everything it is told.
--
-- Copyright 2013 John Abrahamsen
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.  

local turbo = require "turbo"

local Parrot = class("Parrot", turbo.tcpserver.TCPServer)

function Parrot:handle_stream(stream, addr)
    stream:read_until_close(
        function() 
            print("Socket closed!")
        end, nil,
        function(data)
            -- Streaming callback
            stream:write(data)
        end)
end

Parrot():listen(8888)

turbo.ioloop.instance():start()