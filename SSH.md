# SSH Guide

SSH means Secure Shell. It is a protocol and a set of tools used to connect
securely to another machine over a network.

Most Linux remote administration uses SSH.

SSH can be used for:

- Opening a remote shell.
- Running one command on a remote machine.
- Copying files.
- Forwarding ports.
- Using Git over SSH.
- Jumping through another server.
- Creating encrypted tunnels.
- Forwarding an SSH agent.
- Running remote development tools.

## Mental Model

There are two machines:

- Client: the machine you connect from.
- Server: the machine you connect to.

There are also two main programs:

- `ssh`: the client program.
- `sshd`: the server daemon.

Example:

```bash
ssh kamronbek@192.168.10.11
```

In this example:

- `ssh` runs on your laptop.
- `192.168.10.11` is the server.
- `kamronbek` is the Linux user on the server.
- `sshd` must be running on the server.

## Important Files

Client-side files:

```text
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
~/.ssh/config
~/.ssh/known_hosts
```

Server-side files:

```text
~/.ssh/authorized_keys
/etc/ssh/sshd_config
/etc/ssh/ssh_host_ed25519_key
/etc/ssh/ssh_host_ed25519_key.pub
```

The client private key stays on the client.

The server stores allowed public keys in `authorized_keys`.

The client stores remembered server identities in `known_hosts`.

## User Keys vs Host Keys

SSH has two different key concepts.

User keys authenticate users.

Host keys authenticate servers.

Do not confuse them.

### User Keys

User keys answer this question:

"Is this client allowed to log in as this server user?"

Files involved:

```text
client: ~/.ssh/id_ed25519
client: ~/.ssh/id_ed25519.pub
server: ~/.ssh/authorized_keys
```

The private key stays on the client.

The public key is copied to the server.

### Host Keys

Host keys answer this question:

"Is this really the server I think it is?"

Files involved:

```text
server: /etc/ssh/ssh_host_*_key
client: ~/.ssh/known_hosts
```

The first time you connect, SSH asks whether you trust the server
fingerprint.

If you accept it, SSH saves it in `known_hosts`.

If the server host key changes later, SSH warns you.

That warning can mean:

- The server was reinstalled.
- The server regenerated host keys.
- The IP address now belongs to another machine.
- Someone may be intercepting the connection.

## Basic SSH Commands

Connect to a server:

```bash
ssh user@host
```

Connect to an IP address:

```bash
ssh kamronbek@192.168.10.11
```

Connect with a specific key:

```bash
ssh -i ~/.ssh/home_pc_ed25519 kamronbek@192.168.10.11
```

Connect to a different port:

```bash
ssh -p 2222 kamronbek@192.168.10.11
```

Run one command remotely:

```bash
ssh kamronbek@192.168.10.11 "uname -a"
```

Exit an SSH session:

```bash
exit
```

Or press:

```text
Ctrl-D
```

## Generate a Modern SSH Key

Use Ed25519 for normal modern usage:

```bash
ssh-keygen -t ed25519 -a 100 -C "kamronbek@laptop"
```

Suggested filename:

```text
/home/kamronbek/.ssh/home_pc_ed25519
```

This creates two files:

```text
~/.ssh/home_pc_ed25519
~/.ssh/home_pc_ed25519.pub
```

The first file is private.

The second file is public.

Never share the private key.

The public key can be copied to servers.

## RSA Keys

Ed25519 is usually preferred today.

Use RSA only when you need compatibility with old systems.

Modern RSA example:

```bash
ssh-keygen -t rsa -b 4096 -a 100 -C "kamronbek@laptop"
```

Do not generate small RSA keys.

Avoid old DSA keys.

Avoid old ECDSA keys unless you specifically need them.

## SSH Key Passphrase

An SSH key passphrase encrypts your private key on disk.

It protects you if someone copies your private key file.

You can use a passphrase and still avoid typing it every time by using
`ssh-agent`.

Change a key passphrase:

```bash
ssh-keygen -p -f ~/.ssh/home_pc_ed25519
```

## Copy Public Key to Server

The public key must be added to this file on the server:

```text
~/.ssh/authorized_keys
```

### With `ssh-copy-id`

Use this if password login still works:

```bash
ssh-copy-id -i ~/.ssh/home_pc_ed25519.pub kamronbek@192.168.10.11
```

Then test:

```bash
ssh -i ~/.ssh/home_pc_ed25519 kamronbek@192.168.10.11
```

### Manually

On the client:

```bash
cat ~/.ssh/home_pc_ed25519.pub
```

Copy the whole line.

On the server:

```bash
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys
```

Paste the public key line.

Then fix permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Required Permissions

SSH is strict about permissions.

On the client:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/home_pc_ed25519
chmod 644 ~/.ssh/home_pc_ed25519.pub
chmod 600 ~/.ssh/config
chmod 644 ~/.ssh/known_hosts
```

On the server:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

Also make sure ownership is correct:

```bash
chown -R "$USER:$USER" ~/.ssh
```

For your home PC user:

```bash
sudo chown -R kamronbek:kamronbek /home/kamronbek/.ssh
```

## Client Config

Instead of typing long commands, use `~/.ssh/config`.

Create it:

```bash
nano ~/.ssh/config
```

Example:

```sshconfig
Host homepc
    HostName 192.168.10.11
    User kamronbek
    Port 22
    IdentityFile ~/.ssh/home_pc_ed25519
    IdentitiesOnly yes
```

Then connect with:

```bash
ssh homepc
```

## Multiple Hosts

Example:

```sshconfig
Host homepc
    HostName 192.168.10.11
    User kamronbek
    IdentityFile ~/.ssh/home_pc_ed25519
    IdentitiesOnly yes

Host vps
    HostName example.com
    User deploy
    Port 22
    IdentityFile ~/.ssh/vps_ed25519
    IdentitiesOnly yes

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_ed25519
    IdentitiesOnly yes
```

`Host` is the alias you type.

`HostName` is the real IP address or domain.

`User` is the remote Linux username.

`IdentityFile` is the private key.

`IdentitiesOnly yes` tells SSH to use only the configured key.

## Good Default Client Config

A practical config:

```sshconfig
Host *
    ServerAliveInterval 30
    ServerAliveCountMax 3
    AddKeysToAgent yes
    IdentityAgent SSH_AUTH_SOCK
```

Host-specific blocks should usually come before `Host *`.

Example:

```sshconfig
Host homepc
    HostName 192.168.10.11
    User kamronbek
    IdentityFile ~/.ssh/home_pc_ed25519
    IdentitiesOnly yes

Host *
    ServerAliveInterval 30
    ServerAliveCountMax 3
```

## SSH Agent

`ssh-agent` stores decrypted private keys in memory.

This means you type the key passphrase once.

Start an agent:

```bash
eval "$(ssh-agent -s)"
```

Add a key:

```bash
ssh-add ~/.ssh/home_pc_ed25519
```

List loaded keys:

```bash
ssh-add -l
```

Remove all loaded keys:

```bash
ssh-add -D
```

Many desktop environments start an agent automatically.

On Arch with a Wayland setup, this depends on your session setup.

## Test Which Key SSH Uses

Use verbose mode:

```bash
ssh -vvv homepc
```

Useful lines to look for:

```text
Offering public key
Server accepts key
Permission denied
Authentications that can continue
```

A shorter debug command:

```bash
ssh -v homepc
```

## Common Error: Permission Denied Publickey

Error:

```text
Permission denied (publickey).
```

Meaning:

SSH reached the server, but authentication failed.

Common causes:

- The client used the wrong private key.
- The private key has unsafe permissions.
- The server does not have the matching public key.
- The public key is in the wrong user's `authorized_keys`.
- The server has bad permissions on `.ssh`.
- The server disallows the login user.
- `sshd_config` disables public key auth.
- You are connecting as the wrong username.

Debug:

```bash
ssh -vvv -i ~/.ssh/home_pc_ed25519 kamronbek@192.168.10.11
```

Check client permissions:

```bash
ls -la ~/.ssh
```

Check server permissions:

```bash
ls -ld ~/.ssh
ls -la ~/.ssh/authorized_keys
```

Check whether the public key matches the private key:

```bash
ssh-keygen -y -f ~/.ssh/home_pc_ed25519
```

Compare that output with the server's `authorized_keys`.

## Common Error: Connection Refused

Error:

```text
ssh: connect to host 192.168.10.11 port 22: Connection refused
```

Meaning:

The server is reachable, but nothing is listening on that port.

Check server:

```bash
sudo systemctl status sshd
```

Start server:

```bash
sudo systemctl start sshd
```

Enable on boot:

```bash
sudo systemctl enable sshd
```

Check listening port:

```bash
ss -tlnp | grep ssh
```

## Common Error: Connection Timed Out

Error:

```text
ssh: connect to host 192.168.10.11 port 22: Connection timed out
```

Meaning:

The client cannot reach the SSH service.

Possible causes:

- Wrong IP address.
- Server is off.
- Firewall blocks the port.
- Router blocks traffic.
- Server is on another network.
- SSH listens on a different port.

Check network:

```bash
ping 192.168.10.11
```

Check route:

```bash
ip route
```

Check port:

```bash
nc -vz 192.168.10.11 22
```

## Common Error: Host Key Changed

Error:

```text
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
```

Meaning:

The saved host key in `known_hosts` does not match the server.

If you intentionally reinstalled the server, remove the old entry:

```bash
ssh-keygen -R 192.168.10.11
```

Then reconnect:

```bash
ssh kamronbek@192.168.10.11
```

Do not ignore this warning on public networks or production systems.

## Server Config

The main OpenSSH server config is:

```text
/etc/ssh/sshd_config
```

On Arch, the service is usually:

```text
sshd.service
```

Check status:

```bash
sudo systemctl status sshd
```

Restart:

```bash
sudo systemctl restart sshd
```

Reload:

```bash
sudo systemctl reload sshd
```

Before restarting after config changes, test syntax:

```bash
sudo sshd -t
```

## Safer Server Baseline

Edit:

```bash
sudo nano /etc/ssh/sshd_config
```

Recommended baseline:

```sshconfig
PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no
PubkeyAuthentication yes
X11Forwarding no
AllowUsers kamronbek
```

Then test config:

```bash
sudo sshd -t
```

Reload:

```bash
sudo systemctl reload sshd
```

Keep one existing SSH session open while changing server config.

Open a second terminal and test the new login.

Do not close the working session until the new one works.

## Password Login vs Key Login

Password login:

- Easy to understand.
- Easy to brute force.
- Bad for internet-facing servers.
- Depends on the account password.

Key login:

- Uses a public/private key pair.
- Safer against brute force.
- Private key never leaves the client.
- Public key is stored on the server.
- Preferred for real systems.

For your home PC, key login plus disabled password login is good.

## Root Login

Avoid direct root SSH login.

Bad:

```sshconfig
PermitRootLogin yes
```

Better:

```sshconfig
PermitRootLogin no
```

Log in as your normal user.

Then use `sudo`:

```bash
sudo pacman -Syu
```

## `authorized_keys`

This file lives on the server.

Path:

```text
/home/kamronbek/.ssh/authorized_keys
```

It contains public keys.

Each key is one long line.

Example shape:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... user@host
```

You can have many keys in this file.

For example:

- Laptop key.
- Desktop key.
- Emergency USB key.
- GitHub deploy key.

Remove a line to revoke that key.

## `known_hosts`

This file lives on the client.

Path:

```text
~/.ssh/known_hosts
```

It stores server host identities.

It does not control whether you can log in.

It only helps verify that the server is the same server as before.

Remove one host:

```bash
ssh-keygen -R 192.168.10.11
```

Show fingerprints:

```bash
ssh-keygen -lf ~/.ssh/known_hosts
```

## Fingerprints

Show a public key fingerprint:

```bash
ssh-keygen -lf ~/.ssh/home_pc_ed25519.pub
```

Show a private key's public fingerprint:

```bash
ssh-keygen -lf ~/.ssh/home_pc_ed25519
```

Print the public key from a private key:

```bash
ssh-keygen -y -f ~/.ssh/home_pc_ed25519
```

This is useful when checking whether a server has the matching public key.

## Copy Files with `scp`

Copy local file to server:

```bash
scp file.txt homepc:/home/kamronbek/
```

Copy file from server to local machine:

```bash
scp homepc:/home/kamronbek/file.txt .
```

Copy directory:

```bash
scp -r mydir homepc:/home/kamronbek/
```

Use a custom key:

```bash
scp -i ~/.ssh/home_pc_ed25519 file.txt \
    kamronbek@192.168.10.11:/home/kamronbek/
```

`scp` is simple, but `rsync` is better for repeated syncs.

## Copy Files with `sftp`

Open an interactive SFTP session:

```bash
sftp homepc
```

Useful commands inside SFTP:

```text
ls
pwd
cd
lcd
put file.txt
get file.txt
mkdir name
rm file.txt
exit
```

SFTP uses SSH underneath.

It is not old FTP.

## Sync Files with `rsync`

Copy a directory to the server:

```bash
rsync -avh ./project/ homepc:/home/kamronbek/project/
```

Copy from server to local:

```bash
rsync -avh homepc:/home/kamronbek/project/ ./project/
```

Delete remote files that no longer exist locally:

```bash
rsync -avh --delete ./project/ homepc:/home/kamronbek/project/
```

Use SSH options:

```bash
rsync -avh -e "ssh -i ~/.ssh/home_pc_ed25519" \
    ./project/ kamronbek@192.168.10.11:/home/kamronbek/project/
```

## Local Port Forwarding

Local forwarding exposes a remote service on your local machine.

Shape:

```bash
ssh -L local_port:target_host:target_port user@ssh_server
```

Example:

```bash
ssh -L 8080:localhost:80 homepc
```

Meaning:

- Open local port `8080` on your laptop.
- Send traffic through SSH to `homepc`.
- From `homepc`, connect to `localhost:80`.

Then open locally:

```text
http://localhost:8080
```

Useful for:

- Adminer.
- pgAdmin.
- PostgreSQL.
- Redis.
- Local-only web apps.
- Private dashboards.

PostgreSQL example:

```bash
ssh -L 5433:localhost:5432 homepc
```

Then connect locally to:

```text
localhost:5433
```

## Remote Port Forwarding

Remote forwarding exposes a local service on the remote machine.

Shape:

```bash
ssh -R remote_port:target_host:target_port user@ssh_server
```

Example:

```bash
ssh -R 9000:localhost:3000 vps
```

Meaning:

- Open port `9000` on the VPS side.
- Forward traffic back to your local `localhost:3000`.

This is useful when your local machine is behind NAT.

Server config may need:

```sshconfig
AllowTcpForwarding yes
GatewayPorts no
```

Be careful with public remote forwards.

## Dynamic Port Forwarding

Dynamic forwarding creates a SOCKS proxy.

Example:

```bash
ssh -D 1080 homepc
```

Then configure browser SOCKS proxy:

```text
Host: 127.0.0.1
Port: 1080
SOCKS version: 5
```

This sends browser traffic through the SSH server.

Useful for private browsing through another trusted machine.

Not the same thing as a full VPN.

## Jump Hosts

A jump host is an intermediate SSH server.

Example command:

```bash
ssh -J user@jump.example.com user@private-host
```

Example config:

```sshconfig
Host jump
    HostName jump.example.com
    User kamronbek
    IdentityFile ~/.ssh/jump_ed25519

Host private
    HostName 10.0.0.10
    User kamronbek
    IdentityFile ~/.ssh/private_ed25519
    ProxyJump jump
```

Connect:

```bash
ssh private
```

## Agent Forwarding

Agent forwarding lets a remote server use your local SSH agent.

Example:

```bash
ssh -A homepc
```

Config:

```sshconfig
Host homepc
    ForwardAgent yes
```

Use this carefully.

If the remote server is compromised, attackers may abuse your forwarded
agent while your session is active.

Prefer not to forward agents by default.

Better alternatives:

- Use separate deploy keys.
- Use `ProxyJump`.
- Use GitHub deploy keys.
- Use short-lived credentials.

## Git over SSH

GitHub SSH URL shape:

```text
git@github.com:owner/repo.git
```

Test GitHub SSH:

```bash
ssh -T git@github.com
```

Example config:

```sshconfig
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_ed25519
    IdentitiesOnly yes
```

Clone:

```bash
git clone git@github.com:owner/repo.git
```

Remote URL:

```bash
git remote -v
```

Change HTTPS remote to SSH:

```bash
git remote set-url origin git@github.com:owner/repo.git
```

## Keep SSH Sessions Alive

Client-side config:

```sshconfig
Host *
    ServerAliveInterval 30
    ServerAliveCountMax 3
```

Meaning:

- Send a keepalive every 30 seconds.
- Disconnect after 3 failed replies.

This helps avoid dead frozen SSH sessions.

## Escape Sequences

SSH has escape commands.

They work after a newline.

Disconnect stuck session:

```text
Enter
~.
```

Show help:

```text
Enter
~?
```

Background SSH session:

```text
Enter
~^Z
```

The escape character is usually `~`.

## Mount Remote Files with SSHFS

Install:

```bash
sudo pacman -S sshfs
```

Create mount directory:

```bash
mkdir -p ~/mnt/homepc
```

Mount:

```bash
sshfs homepc:/home/kamronbek ~/mnt/homepc
```

Unmount:

```bash
fusermount3 -u ~/mnt/homepc
```

SSHFS is convenient, but for coding large projects, native remote dev tools
or `rsync` can be smoother.

## Remote Development

Common approaches:

- SSH into the machine and use terminal tools.
- Use Neovim over SSH.
- Use VSCode Remote SSH.
- Use Zed remote features if available.
- Use `rsync` to sync files.
- Use Git push/pull between machines.
- Use SSH port forwards for dev servers.

For a home dev PC, a common workflow is:

```bash
ssh homepc
cd ~/Documents/Coding/project
nvim .
```

For a web app running on the remote PC:

```bash
ssh -L 5173:localhost:5173 homepc
```

Then open on the laptop:

```text
http://localhost:5173
```

## Systemd SSH Server on Arch

Install OpenSSH:

```bash
sudo pacman -S openssh
```

Start SSH server:

```bash
sudo systemctl start sshd
```

Enable on boot:

```bash
sudo systemctl enable sshd
```

Check status:

```bash
sudo systemctl status sshd
```

View logs:

```bash
journalctl -u sshd
```

Follow logs:

```bash
journalctl -u sshd -f
```

## Firewall Basics

If using `ufw`:

```bash
sudo ufw allow ssh
```

Or for custom port:

```bash
sudo ufw allow 2222/tcp
```

If using raw nftables, allow TCP port 22.

Check listening sockets:

```bash
ss -tlnp
```

Check SSH only:

```bash
ss -tlnp | grep ssh
```

## Changing SSH Port

Changing the port reduces noise from bots.

It is not real security by itself.

Edit server config:

```bash
sudo nano /etc/ssh/sshd_config
```

Example:

```sshconfig
Port 2222
```

Test config:

```bash
sudo sshd -t
```

Reload:

```bash
sudo systemctl reload sshd
```

Connect:

```bash
ssh -p 2222 kamronbek@192.168.10.11
```

Or config:

```sshconfig
Host homepc
    HostName 192.168.10.11
    User kamronbek
    Port 2222
```

## Safer Key Strategy

Use different keys for different purposes.

Example:

```text
~/.ssh/home_pc_ed25519
~/.ssh/github_ed25519
~/.ssh/vps_ed25519
~/.ssh/poddle_deploy_ed25519
```

Benefits:

- Easier revocation.
- Less blast radius.
- Cleaner `~/.ssh/config`.
- Better separation between personal and deploy access.

## Backup Strategy

Back up private keys carefully.

Good options:

- Encrypted backup.
- Password manager with file support.
- Encrypted USB drive.
- Age or GPG encrypted archive.

Do not put private keys in:

- Public Git repos.
- Dotfiles repos without encryption.
- Cloud folders without encryption.
- Screenshots.
- Chat messages.

If a private key leaks, remove its public key from every server.

Then generate a new key.

## Revoking Access

To revoke a client key from a server:

```bash
nano ~/.ssh/authorized_keys
```

Delete the matching public key line.

You can identify the key by comment:

```text
ssh-ed25519 AAAA... kamronbek@laptop
```

This is why good comments are useful.

Generate keys with comments:

```bash
ssh-keygen -t ed25519 -C "kamronbek@acer-laptop"
```

## Restricting Keys in `authorized_keys`

You can restrict what a key can do.

Example:

```text
command="/usr/bin/uptime",no-port-forwarding ssh-ed25519 AAAA...
```

Common options:

```text
command="..."
no-agent-forwarding
no-X11-forwarding
no-port-forwarding
no-pty
from="192.168.10.0/24"
```

This is useful for automation and deploy keys.

Keep normal human login keys unrestricted unless you have a clear reason.

## Public Key Auth Flow

The simplified flow:

1. Client connects to server.
2. Server proves its host identity.
3. Client checks `known_hosts`.
4. Client offers a public key identity.
5. Server checks `authorized_keys`.
6. Server sends a challenge.
7. Client signs the challenge with the private key.
8. Server verifies the signature with the public key.
9. Login succeeds.

The private key is never sent to the server.

## What Happens on First Connect

You may see:

```text
The authenticity of host cannot be established.
Are you sure you want to continue connecting?
```

This means your client has not seen this server host key before.

For a home LAN machine, this is usually normal on first connect.

For production, verify the fingerprint out of band.

After accepting, the host key is saved in:

```text
~/.ssh/known_hosts
```

## Useful SSH Options

Specify identity file:

```bash
ssh -i ~/.ssh/home_pc_ed25519 homepc
```

Specify port:

```bash
ssh -p 2222 homepc
```

Verbose debug:

```bash
ssh -vvv homepc
```

Do not execute remote command:

```bash
ssh -N homepc
```

Useful with tunnels.

Do not allocate TTY:

```bash
ssh -T git@github.com
```

Force TTY:

```bash
ssh -t homepc "htop"
```

Run in background after auth:

```bash
ssh -f -N -L 8080:localhost:80 homepc
```

## Useful Commands

Show SSH client version:

```bash
ssh -V
```

Show final resolved config:

```bash
ssh -G homepc
```

Scan server host key:

```bash
ssh-keyscan 192.168.10.11
```

Remove old host key:

```bash
ssh-keygen -R 192.168.10.11
```

Show key fingerprint:

```bash
ssh-keygen -lf ~/.ssh/home_pc_ed25519.pub
```

Generate public key from private key:

```bash
ssh-keygen -y -f ~/.ssh/home_pc_ed25519
```

## Home PC Checklist

On the server:

```bash
sudo pacman -S openssh
sudo systemctl enable --now sshd
```

Check server IP:

```bash
ip a
```

On the client:

```bash
ping 192.168.10.11
```

Generate key:

```bash
ssh-keygen -t ed25519 -a 100 -C "kamronbek@laptop"
```

Copy public key to server:

```bash
ssh-copy-id -i ~/.ssh/home_pc_ed25519.pub \
    kamronbek@192.168.10.11
```

Create config:

```sshconfig
Host homepc
    HostName 192.168.10.11
    User kamronbek
    IdentityFile ~/.ssh/home_pc_ed25519
    IdentitiesOnly yes
```

Connect:

```bash
ssh homepc
```

After key login works, disable password login on the server:

```sshconfig
PasswordAuthentication no
KbdInteractiveAuthentication no
PermitRootLogin no
PubkeyAuthentication yes
```

Test config:

```bash
sudo sshd -t
```

Reload:

```bash
sudo systemctl reload sshd
```

## Troubleshooting Order

Use this order.

First, check network:

```bash
ping 192.168.10.11
```

Second, check port:

```bash
nc -vz 192.168.10.11 22
```

Third, debug client auth:

```bash
ssh -vvv homepc
```

Fourth, check server logs:

```bash
journalctl -u sshd -f
```

Fifth, check permissions:

```bash
ls -la ~/.ssh
```

Sixth, verify the public key:

```bash
ssh-keygen -y -f ~/.ssh/home_pc_ed25519
```

Compare with server:

```bash
cat ~/.ssh/authorized_keys
```

## Common Fixes

Fix client private key permissions:

```bash
chmod 600 ~/.ssh/home_pc_ed25519
```

Fix client `.ssh` directory:

```bash
chmod 700 ~/.ssh
```

Fix server `.ssh` directory:

```bash
chmod 700 ~/.ssh
```

Fix server `authorized_keys`:

```bash
chmod 600 ~/.ssh/authorized_keys
```

Fix ownership:

```bash
sudo chown -R kamronbek:kamronbek /home/kamronbek/.ssh
```

Force a specific key:

```bash
ssh -i ~/.ssh/home_pc_ed25519 \
    -o IdentitiesOnly=yes \
    kamronbek@192.168.10.11
```

## Good Habits

Use Ed25519 keys.

Use one key per purpose.

Use `~/.ssh/config`.

Use key comments.

Use passphrases for important keys.

Use `ssh-agent`.

Disable password login after keys work.

Disable root login.

Keep one session open when changing server config.

Check `sshd -t` before reloading SSH.

Do not copy private keys to servers.

Do not commit private keys to Git.

Do not ignore host key warnings blindly.

## Glossary

SSH:

Secure Shell protocol and tool family.

`ssh`:

Client command used to connect.

`sshd`:

Server daemon that accepts SSH connections.

Private key:

Secret key kept on the client.

Public key:

Shareable key copied to servers.

`authorized_keys`:

Server file listing public keys allowed to log in.

`known_hosts`:

Client file listing remembered server host keys.

Host key:

Server identity key.

Fingerprint:

Short hash used to identify a key.

SSH agent:

Local program that stores decrypted private keys in memory.

Port forwarding:

Sending network traffic through an SSH connection.

Jump host:

Intermediate SSH server used to reach another server.

SFTP:

File transfer protocol that runs over SSH.

SCP:

Simple file copy command over SSH.

Rsync:

Efficient file sync tool often used over SSH.

## Minimal Real Setup

For your home PC, a clean setup can look like this.

Client key:

```text
~/.ssh/home_pc_ed25519
~/.ssh/home_pc_ed25519.pub
```

Client config:

```sshconfig
Host homepc
    HostName 192.168.10.11
    User kamronbek
    IdentityFile ~/.ssh/home_pc_ed25519
    IdentitiesOnly yes
    ServerAliveInterval 30
    ServerAliveCountMax 3
```

Server allowed key:

```text
/home/kamronbek/.ssh/authorized_keys
```

Connect:

```bash
ssh homepc
```

Forward remote dev server:

```bash
ssh -L 5173:localhost:5173 homepc
```

Copy files:

```bash
rsync -avh ./project/ homepc:/home/kamronbek/project/
```

Debug:

```bash
ssh -vvv homepc
```
