#!/usr/bin/env nix-shell
#! nix-shell -p curl -p jq -i bash

# Notifies discord according to DISCORD_WEBHOOK_URL when issues are detected with a ZFS pool
set +e

if [[ ! $DISCORD_WEBHOOK_URL ]]; then
	echo "DISCORD_WEBHOOK_URL environment variable must be defined"
	exit 1
fi

status="$(zpool status)"
notify="$(zpool status | grep -E 'FAULTED|DEGRADED|OFFLINE')"

function send_discord() {
	content="$(jq -n --arg content "**zpool error:**\`\`\`$status\`\`\`" '{content: $content}')"
	curl -s -X POST -H "content-type: application/json" -d "$content" "$DISCORD_WEBHOOK_URL"
}

if [[ notify ]]; then
	echo "Notifying"
	echo "$status"
	send_discord
fi
