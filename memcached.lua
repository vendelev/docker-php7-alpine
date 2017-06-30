do
box.cfg{}
local memcached = require("memcached")
local instance = memcached.create('memname', '0.0.0.0:11311')
end