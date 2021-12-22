ls -d -- */ | xargs -I {} stow -Dvt ~ {}
stow -Dv . 
