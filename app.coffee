
###
	@see http://rowanmanning.com/posts/node-cluster-and-express/
	Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
app = express()
cluster = require "cluster"

if cluster.isMaster

	# count the cores / cpus
	cpus = require("os").cpus().length

	# create a new fork for each of the cores that exist
	cluster.fork() for cpu in [0..cpus] 

else
	
	app = do express
	app.get "/", (req, res)->
		res.send "HELLO FROM WORKER #{cluster.worker.id}"

	app.listen 3000	
	console.log "#{cluster.worker.id} booted up"	
