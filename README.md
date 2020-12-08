# Alloapp Assist

This is a "curl-able bash script" that initializes a new Alloverse
app for you in your current directory. Please read the
[getting started with alloapp development](https://alloverse.com/develop-apps/)
guide to understand how to use it.

In short:

```
$ mkdir myproj
$ cd myproj
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alloverse/alloapp-assist/master/setup.bash)"
...
$ ./allo/assist help
```

## Developing

Before committing, you must `bash build.bash` to generate the compiled `setup.bash`,
which is the script that is actually executed by users. This script packs
together the `setup-script.bash` with the template files.

* `template/allo/` is the template folder for all allo-provided tools and libraries. It
  also includes the `allo/assist` script which the user uses to perform
  other tasks after the project is created (like booting their app, etc).
* `template/lua/` contains the basic app stub, the skeleton for an alloapp that the user
  can later expand on. Edit this to edit the standard skeleton that all users
  start with.