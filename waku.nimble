mode = ScriptMode.Verbose

### Package
version = "0.1.0"
author = "Status Research & Development GmbH"
description = "Waku, Private P2P Messaging for Resource-Restricted Devices"
license = "MIT or Apache License 2.0"
#bin           = @["build/waku"]

### Dependencies
requires "nim >= 2.0.8",
  "chronicles",
  "confutils",
  "chronos",
  "eth",
  "json_rpc",
  "libbacktrace",
  "nimcrypto",
  "stew",
  "stint",
  "metrics",
  "libp2p", # Only for Waku v2
  "web3",
  "presto",
  "regex",
  "db_connector",
  "minilru",
  "quic"

proc buildMobileAndroid(params = "") =
  let outDir = "build/android"
  if not dirExists outDir:
    mkDir outDir

  exec "nim c" & " --out:" & outDir & "/hello hello.nim"

### Mobile Android
task libWakuAndroid, "Build the mobile bindings for Android":
  let extraParams = "-d:chronicles_log_level=ERROR"
  buildMobileAndroid extraParams
