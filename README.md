Introduction
============

A modern, multi-profile neovim setup.

If you want to just quickly testdrive it, jump to the section *Quickstart* below.

If you want to use it as it's meant to be used (with all flexibility), read
through all the following contents.

You are currently looking at the master branch, which doesn't have any
configuration in it.

As a neovim user, you might work on different projects, with different stacks,
languages or systems. The goal of this project is to allow you to use neovim in
specific situations called profiles. More precisely:

* separate setups
* allow combining profiles by leveraging git
* foster a community of changes and ideas

There is no perfect universal setup for everyone, since every one of us has
specific needs, at any given point in time. The goal is to create a framework
of exchanging and combining bits and pieces from different users by creating an
ecosystem of configurations.

The profiles are in different branches, one branch per configuration. This might
raise some eye brows, but I'll explain, bear with me.

At the top is the branch `minimal`. This contains the most minimalistic profile
which I consider modern (and stable). You might think differently, in that
case, fork this project and make your adaptations in your own fork. If you
think the community at large will benefit from it, then also open a PR against
my repo.

The `minimal` branch is an orphan branch, meaning it has no further history.
If there is a need for further minimal branches, they will also be created as
orphan.

Derived from the `minimal` branch, there is also the `minimal-python` branch.

Among the network of this repositories and its forks, it's important to
maintain the names of these branches and their intent. The intent must be
clearly documented. A new intent (or a target audience) requires a new name.

If an intent is a refinement of an existing intent, then the name of the branch
should be prefixed with `previous-intent-`.

There are two main ways to use and manage this profile.

1. Based on the `NVIM_APPNAME` environment variable
2. By merging multiple branches
3. You can, of course, mix these two approaches

Option 1: multiple profiles and leveraging `NVIM_APPNAME`
=========================================================


WIP

Option 2: merging multiple branches
===================================

WIP

Key points:

* using remotes


Option 3: mix and match Option 1 and 2
======================================

WIP

Quickstart
==========

WIP


Setup
=====

In case you have followed the quickstart instructions, remove the files created
there, then proceed with these instructions from scratch.

WIP

Contributing
============

WIP
