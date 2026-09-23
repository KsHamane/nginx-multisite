# Nginx Multi-Site Lab

Spin up multiple independent Nginx sites on a single Ubuntu VM, entirely through
scripts — no manual config editing, no repeated setup. First hands-on DevOps
project, self-taught, built from a standing start.

## Skills demonstrated
- **Ubuntu Server** administration on a Multipass VM
- **SSH** key-based auth, separate keys per trust relationship (VM access vs. GitHub)
- **UFW** firewall rules opened per-service and per-site
- **Nginx** — multiple server blocks, each with its own root and port
- **Bash scripting** — idempotent setup scripts safe to rerun
- **Dynamic site/port provisioning** — new sites get a port and firewall rule automatically
- **systemd** service management
- **Git/GitHub** version control
- **Troubleshooting** real misconfigurations, not just following a tutorial

## What this does
Everything below runs inside a [Multipass](https://multipass.run) Ubuntu VM.
Each script has exactly one job, so nothing gets hand-edited twice.

| Script | What it does |
| ----------------------
| `nginx-setup.sh` | Installs Nginx if missing, enables it, opens HTTP in the firewall |
| `site1-setup.sh` | Deploys the first site (`site1-index.html`) on port 80 |
| `new-site-code.sh` | Opens an editor for a new site's HTML, auto-numbered |
| `new-site-setup.sh` | Wires that new site into Nginx on its own port, opens the firewall, prints the live link |

## Quickstart
```bash
git clone git@github.com:KsHamane/nginx-multi-site.git
cd nginx-multi-site
chmod +x *.sh
./nginx-setup.sh          # base Nginx install + firewall
./site1-setup.sh          # first site, port 80
./new-site-code.sh        # write a new site's HTML, auto-numbered
./new-site-setup.sh       # deploy it, get a live link back
```
`test-site.html` is ready-made content to paste in when testing
`new-site-code.sh` / `new-site-setup.sh`, so you're not writing throwaway HTML
by hand every time.

## What I debugged
Ubuntu's Nginx default root is `/var/www/html` — not `/usr/share/nginx/html`,
which is the RedHat/CentOS convention most tutorials assume. My first deploy
script copied the site into the wrong root, so Nginx kept serving its stock
welcome page while the "correct" file sat untouched one directory over. Caught
it by diffing `curl localhost` against the file I'd actually copied, then
fixed the script's destination path and added an `nginx -t` check before every
reload so a bad config can't silently break a live site again.

## Notes
- Each new site gets `8080 + site_number` as its port, opened automatically in `ufw`.
- Once `new-site-setup.sh` deploys a site, re-running `new-site-code.sh` starts
  the next site fresh — copy the previous HTML file first if you want to keep editing it.

## About
Built by [Karim Salah Hamane (KsHamane)] https://www.linkedin.com/in/karim-salah-hamane — 
first project in a DevOps course. [GitHub] https://github.com/KsHamane
