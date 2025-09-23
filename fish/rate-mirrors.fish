export TMPFILE="$(mktemp)"; \
	sudo true; \
	rate-mirrors --save=$TMPFILE arch \
	sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
	sudo mv $TMPFILE /etc/pacman.d/mirrorlist
	rate-mirrors --save=$TMPFILE arch \
	sudo mv /etc/pacman.d/chaotic-mirrorlist /etc/pacman.d/chaotic-mirrorlist-backup \
	sudo mv $TMPFILE /etc/pacman.d/chaotic-mirrorlist
	rate-mirrors --save=$TMPFILE arch \
	sudo mv /etc/pacman.d/cachyos-mirrorlist /etc/pacman.d/cachyos-mirrorlist-backup \
	sudo mv $TMPFILE /etc/pacman.d/cachyos-mirrorlist
