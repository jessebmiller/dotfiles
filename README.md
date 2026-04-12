# dotfiles

## Install

Install [Fedora i3 Spin](https://fedoraproject.org/spins/i3), then on the new machine:

```sh
curl -fsSL https://raw.githubusercontent.com/jessebmiller/dotfiles/main/bootstrap.sh | sh
```

After it completes, the SSH public key will be printed. Add it to GitHub, then switch the remote to SSH:

```sh
cd ~/work/dotfiles
git remote set-url origin git@github.com:jessebmiller/dotfiles.git
```

**Manual steps after bootstrap:**
- Install 1Password extension in Brave
- Set Brave default search engine
- Log in to GitHub, Google, etc.



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

