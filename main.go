package main

import (
	"log"

	"github.com/Kong/go-pdk"
	"github.com/Kong/go-pdk/server"
)

const (
	Version    = "v0.1.0"
	Priority   = 1000
	PluginName = "kong-plugin-golang-demo"
)

type Config struct {
	// config fields here
}

func New() interface{} {
	return &Config{}
}

func (c Config) Rewrite(kong *pdk.PDK) {
	// rewrite/redirect
	// kong.Response.Exit(301, []byte("Moved Permanently"), nil)
}

func (c Config) Access(kong *pdk.PDK) {
	// reject/auth/rate-limit/ip-restriction
	// kong.Response.Exit(404, []byte("Not Found"), nil)
	// kong.Response.Exit(401, []byte("Unauthorized"), nil)
	// kong.Response.Exit(429, []byte("Too Many Requests"), nil)
}

func main() {
	err := server.StartServer(New, Version, Priority)
	if err != nil {
		log.Fatalf("failed to start server: %v", err)
	}
}
