function g --wraps git --description 'git with default status'
	if test (count $argv) -eq 0
		git status;
	else
		git $argv;
	end
end
