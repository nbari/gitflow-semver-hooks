# gitflow-semver-hooks
Semantic Versioning hooks for gitflow [AVH Edition][1]

What does it do?
================

- Automatically bump versions when starting a release or hotfix.
- Automatically specify tag messages.

Activate
--------

Initialize git-flow.

```sh
git flow init
```

It will ask you some questions, the last will be `Hooks and filters directory?`, which you can answer with `/path/to/git-flow-hooks`.

If you've already initialized git-flow, you can still set/change the path manually.

```sh
git config gitflow.path.hooks /path/to/git-flow-hooks
```

Starting releases and hotfixes
------------------------------

If `git flow release start` and `git flow hotfix start` are run without a
version, the version will be bumped automatically.  Releases will be bumped at
the minor level (`1.2.3` becomes `1.3.0`), hotfixes at the patch level (`1.2.3`
becomes `1.2.4`).

The hooks will look at the git tags to find the version to bump.
If no tags are found, defaults to `0.1.0`.

Alternatively you may use `patch`, `minor` and `major` as version.
A bump of that level will take place, example:

```sh
git flow release start patch # (0.1.1 --> 0.1.2)
git flow release start minor # (0.1.1 --> 0.2.0)
git flow release start major # (0.1.1 --> 1.0.0)
```

If the commands are run with version, that version will be used (no bumping),
example:

```sh
git flow release start 0.1.3
```

Automatic tag messages
----------------------

If you want tag messages to be automated (you won't be bothered with your editor
to specify it), use the following configuration options:

```sh
git config gitflow.hotfix.finish.message "Hotfix %tag%"
git config gitflow.release.finish.message "Release %tag%"
```

If you like, you can change the tag-placeholder (`%tag%` in the example above)
in the git-flow-hooks configuration.

Based on [jaspernbrouwer/git-flow-hooks][2]


* Fixed to work in all *nix (FreeBSD, Linux, Mac) no need to have ``bash``
* Versions remain in tags, No ``VERSION`` file.

[1]: https://github.com/petervanderdoes/gitflow
[2]: https://github.com/jaspernbrouwer/git-flow-hooks
