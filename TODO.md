# Declarative setup

- [ ] declarative rpm packages
- [ ] declarative rpm package repositories
- [ ] declarative acs sources
- [ ] declarative stow packages
- [ ] declarative manual instilations (Go, Rust)
  - [ ] say I remove a manually installed thing from the declaration, how does the system then know how to plan it's removal?
    - do what package managers do, keep a database of installed things and what to remove/undo to remove the thing.
    - basically I need to create a "package" with an install, remove, and is_installed function interface
    - I'm signing on to never install something without it being packaged first, and that might mean packaging it myself

# System maintenence

- [ ] backups (snapshots, offsite)
- [ ] package upgrades (frequently enough)
- [ ] system upgrades (when ready)

# Security

- [ ] encrypted private config
  - declare ssh private keys
  - brave/chrome config saved as encrypted bytes?
  - encrypted backups
  
