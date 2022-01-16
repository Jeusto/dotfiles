ls -d -- */ | xargs -I {} stow -vt ~ {}
stow -v . 
