all:
	rm npm-shrinkwrap.json
	npm install --no-optional
	npm shrinkwrap --dev
	npm install -g grunt
	grunt -f

install:
	mkdir -p /app/share/keeweb

	mv binary-keeweb /app/bin/keeweb
	chmod +x /app/bin/keeweb

	mkdir -p /app/share/applications
	mv keeweb.desktop /app/share/applications/info.keeweb.App.desktop
	mkdir -p /app/share/icons/hicolor/256x256/apps
	#cp app/favicon.png /app/share/icons/hicolor/256x256/apps/info.keeweb.App.png

	cp -r * /app/share/keeweb

.PHONY: all install
