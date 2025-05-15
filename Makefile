clean: 
	stow -D .

stow: clean 
	stow .

push:
	git add . && git commit -m 'update' && git push