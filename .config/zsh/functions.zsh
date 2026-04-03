# env:
# export MAGIC_KEYBOARD="..."
# export MAGIC_TRACKPAD="..."

function pair() {
	blueutil --pair $MAGIC_KEYBOARD
	blueutil --pair $MAGIC_TRACKPAD
	blueutil --connect $MAGIC_KEYBOARD
	blueutil --connect $MAGIC_TRACKPAD
}

function unpair() {
	blueutil --disconnect $MAGIC_KEYBOARD
	blueutil --disconnect $MAGIC_TRACKPAD
	blueutil --unpair $MAGIC_KEYBOARD
	blueutil --unpair $MAGIC_TRACKPAD
}

function squash() {
	local n=2
	local message=""
	while [[ $# -gt 0 ]]; do
		case $1 in
		-m | --message)
			message="$2"
			shift 2
			;;
		*)
			n="$1"
			shift
			;;
		esac
	done
	if [[ -z "$message" ]]; then
		message=$(git log -1 --pretty=%B)
	fi
	git reset --soft HEAD~$n
	git commit -m "$message"
}
