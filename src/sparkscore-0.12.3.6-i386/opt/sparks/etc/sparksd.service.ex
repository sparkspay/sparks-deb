[Unit]
Description=<COIN_NAME> service
After=network.target

[Service]
User=<USER>
Group=<GROUP>

Type=forking
#PIDFile=<CONFIG_FOLDER>/<COIN_NAME>.pid

ExecStart=<COIN_PATH>/<COIN_DAEMON> -daemon -conf=<CONFIG_FOLDER>/<CONFIG_FILE> -datadir=<CONFIG_FOLDER>
ExecStop=-<COIN_PATH>/<COIN_CLI> -conf=<CONFIG_FOLDER>/<CONFIG_FILE> -datadir=<CONFIG_FOLDER> stop

Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5

[Install]
WantedBy=multi-user.target
