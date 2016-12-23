# Mighty dotfiles for superior UX

Just a bunch of configuration files for quick setup and backup. Developed mainly
on Arch Linux, but intended to be reasonably portable. They even come with a
funky installation script for rapid deployment.

## Features
- Vim plugins to turn it into fairly helpful IDE (on master branch, see below)
- Fish swag (You should be using fish. Seriously, check it out [here](http://fishshell.com).)
- [Installation script](install.sh) (with all the goodies, like automated backups, selective
  installation and user-defined destination directory)
- More to come shortly (I hope)

## Installation
```bash
git clone https://github.com/matlagp/dotfiles.git
cd dotfiles
./install.sh <switch>
```

You can control the installation process by using different switches. Be sure to run
`./install.sh -h` for super useful usage summary. It should look like this:

```bash
OPTIONS:
            -a: install everything
            -v: install vim files
            -f: install fish files
            -d DEST: install in DEST
            -F: force installation, overwrite backups
            -h: print this message
```

Now, in the perfect world that would be the end. Unfortunately, depending on what you
want to install, some things might require you to do a bit of manual setup. If that's
the case, the script will point you in the right direction. 

## Branches
So, this repo comes in two branches (so far) - one for full experience and all 
the features (main), and one for 'no shinies, no hassle' type of deal
(minimal). Right now I basically contribute to main and cherry-pick into
minimal. This approach has it's drawbacks and it can quickly become a mess,
but for now it works well. Let me know if you have any thoughts on it or any
idea to make it better.

## License
This code is available under the [MIT License](LICENSE.md). Feel free to fork,
share and play. Oh, and let me know if you come up with anything interesting.
Sharing is caring!
