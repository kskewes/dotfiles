# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
#[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
#	-o "nospace" \
#	-W "$(grep "^Host" ~/.ssh/config | \
#	grep -v "[?*]" | cut -d " " -f2 | \
#	tr ' ' '\n')" scp sftp ssh

# source kubectl bash completion
if hash kubectl 2>/dev/null; then
	# shellcheck source=/dev/null
	source <(kubectl completion bash)
fi

# IBM Cloud CLI
if [[ -d /usr/local/ibmcloud ]]; then
	# shellcheck source=/dev/null
	source /usr/local/ibmcloud/autocomplete/bash_autocomplete
fi

# Helm bash completion
if hash helm 2>/dev/null; then
	# shellcheck source=/dev/null
	source <(helm completion bash)
fi

# kube-ps1
kubeps1=${GOPATH}/src/github.com/kube-ps1/kube-ps1.sh
if [[ -r "$kubeps1" ]] && [[ -f "$kubeps1" ]]; then
	# shellcheck source=/dev/null
	source "$kubeps1"
fi

# kubectx and kubens
if [[ -d ~/.kubectx ]]; then
	export PATH=~/.kubectx:$PATH
	# shellcheck source=/dev/null
	source ~/.kubectx/completion/kubectx.bash
	# shellcheck source=/dev/null
	source ~/.kubectx/completion/kubens.bash
fi

# for file in ~/.{bash_prompt,aliases,functions,path,dockerfunc,extra,exports}; do
for file in ~/.{bash_prompt,aliases,functions,path,extra,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

