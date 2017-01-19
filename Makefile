all: install-deps build prune install-repo
	flatpak update --user im.riot.App

install-deps:
	flatpak --user remote-add --if-not-exists --from gnome-nightly https://sdk.gnome.org/gnome.flatpakrepo
	flatpak --user install gnome-nightly org.freedesktop.Platform/x86_64/1.4 org.freedesktop.Sdk/x86_64/1.4 || true

build-electron-base:
	cd electron-flatpak-base-app;\
	make;\
    flatpak build-update-repo --prune --prune-depth=20 ./repo;\
    flatpak --user remote-add --no-gpg-verify local-electron ./repo || true;\
    flatpak --user -v install local-electron io.atom.electron.BaseApp || true;\
    flatpak update --user io.atom.electron.BaseApp;\
    cd ..

build: build-electron-base
	flatpak-builder --force-clean --ccache --require-changes --repo=repo \
		--subject="Nightly build of Riot, `date`" \
		${EXPORT_ARGS} app im.riot.App.json

prune:
	flatpak build-update-repo --prune --prune-depth=20 repo

install-repo:
	flatpak --user remote-add --if-not-exists --no-gpg-verify nightly-riot ./repo
	flatpak --user -v install nightly-riot im.riot.App || true
