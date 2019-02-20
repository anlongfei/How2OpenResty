local args = ngx.req.get_uri_args()
ngx.say(args.a + args.b)
ngx.say(ngx.var.remote_addr)
ngx.say(ngx.var.hostname)
