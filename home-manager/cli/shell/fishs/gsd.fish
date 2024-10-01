# git switch develop の略
# $ gsd -> git switch develop && git pull origin develop && git fetch --prune
# $ gsd stg -> git switch stg && git fetch stg && git fetch --prune
function gsd
	if test "$argv[1]" = ""
		git switch develop && git pull origin develop && git fetch --prune
	else
		git switch $argv[1] && git pull origin $argv[1] && git fetch --prune
	end
end
