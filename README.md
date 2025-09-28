# dotfiles

## Install

* Install Fedora (sway) https://fedoraproject.org/spins/sway
* run `install.sh`
* manually install 1password brave plugin

## TODO

* add git to install script
  * git config --global user.email "you@example.com"
  * git config --global user.name "Your Name"
  * git config pull.rebase true
* Figure out how to handle ssh keys (for example github authorization and ssh login)

## Folders and Files

Folder names and file names are meaningful

`./declarations` hold all declarations. Each is a folder with various declaration types
`./packages` hold custom packages that can be installed, removed, listed, and declared

Types may be

`rpm-packages` a list of rpm packages to install
`rpm-repos` a list of rpm repositories to add (should this be sysfiles? these go in /etc/yum.repos.d/<repo file>.repo)
`rpm-asc` a list of rpm ascs to import
`homefiles` a directory of stow packages to be stowed relative to $HOME
`sysfiles` a directory of stow packages to be stowed relative to /

*future work*

custom packages (for Go, Rust, etc.) will need to implement install, remove, list

# Dependency Evaluation Rubric

A framework for choosing tools, libraries, and ecosystems that solve problems without creating new ones.

## Criteria

* **Well Suited**
  * **Needed** - Solves a signifigant problem. One hard to solve with a bespoke solution
  * **Focused** - Solves only your problem domain. Avoids "everything for everyone" scope creep and bloat. A clue that something is focused is that it has few or no options/configuration. High configurability is a sign of handling many contexts,
                  and while your context might overlap, many others to you are likely to be bloat and get in the way.
  * **Complete** - Tackles the entire problem within its scope. No half-solutions that leave you frequently handling edge cases.

**Permeable** - Compresses complexity without creating barriers to the underlying system. Doesn't add complexity when handling the inevitable edge case.

**Reliable** - Minimal bugs, leaky abstractions, or surprise failures. Doesn't interrupt your work with its own problems.

**Fast Enough** - Leaves performance budget for your work on top. Not necessarily optimal, but not a bottleneck.

**Composable** - Plays well with other tools via standard interfaces (files, pipes, protocols). Doesn't demand living in its world. It should not constrain your choices for solving other problems

**Longevity** - Mature enough to survive technology cycles, but not legacy/maintenance-mode.

**Low Cognitive Overhead** - Reasonable mental model size. Doesn't require constant context switching or complex state tracking.

**Low Operational Overhead** - Once learned and configured, the tool should require minimal ongoing maintenance, troubleshooting, or administrative attention. It should not demand regular updates that break workflows, frequent configuration adjustments, or constant vigilance about system state. Cognitive energy should go toward actual work, not keeping tools functional.

**Graceful Degradation** - Fails in understandable ways. Provides workarounds when things break.

**Vendor Neutral** - Respects autonomy to choose complementary tools and integrates through standard, well-documented interfaces. Does not artificially degrade functionality when used with alternatives, create unnecessary dependencies on vendor-specific services, or make architectural decisions that primarily benefit the vendor's business model rather than user workflows. Avoids strategies that increase switching costs through non-technical means.


let's be delierate about dependencies.

