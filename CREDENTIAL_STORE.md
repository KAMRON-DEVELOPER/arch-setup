# Docker Credential Storage on Arch Linux

This guide explains how to configure Docker credential storage securely on Arch
Linux. It covers two common approaches:

- GNOME Keyring through the Secret Service API
- GPG and `pass`

Use **one** method. Do not configure both `secretservice` and `pass` as the
active Docker credential store at the same time.

## Why Credential Storage Matters

Docker stores registry credentials after `docker login`. Without a credential
helper, Docker may store authentication data directly in its config file.
That is risky because anyone who can read the file may be able to reuse your
Docker registry token.

Credential helpers solve this by moving the secret out of Docker's config file
and into an encrypted or system-managed credential store.

## Option 1: GNOME Keyring and Secret Service

This method stores Docker credentials in GNOME Keyring. It is a good choice on
GNOME, Hyprland, Sway, or other Linux desktop environments that can use the
Secret Service API.

### Install Packages (gnome-keyring, seahorse, docker-credential-secretservice)

Install GNOME Keyring, Seahorse, and the Docker credential helper:

```bash
sudo pacman -S --needed gnome-keyring seahorse
yay -S docker-credential-secretservice
```

`seahorse` is the graphical application usually shown as **Passwords and Keys**
in application launchers.

### Initialize the Default Keyring

GNOME Keyring needs a default keyring before applications can store secrets in
it. Create one manually if it does not already exist.

1. Launch `seahorse`.
2. Click the `+` button in the top-left corner.
3. Select **Password Keyring**.
4. Name the new keyring `login`.
5. Use your current Linux user password as the keyring password.
6. Right-click the new `login` keyring in the sidebar.
7. Select **Set as Default**.

Using your current Linux user password matters. With a display manager and PAM
integration, the `login` keyring can unlock automatically when you log in.

### Start GNOME Keyring in Hyprland

Some login flows do not start the Secret Service component automatically. This
is common when starting Hyprland directly from a TTY, or when the login manager
does not fully initialize the keyring environment.

Add this line to `~/.config/hyprland/hyprland.conf`:

```conf
exec-once = gnome-keyring-daemon --start --components=secrets
```

Restart Hyprland or log out and log back in after changing the config.

### Configure Docker (secretservice)

Create or edit this file:

```bash
nvim ~/.docker/config.json
```

Use this configuration:

```json
{
  "credsStore": "secretservice"
}
```

Docker automatically resolves `secretservice` to the
`docker-credential-secretservice` executable.

### Verify Secret Service Storage

Log in to Docker:

```bash
docker login
```

Then check the config file:

```bash
cat ~/.docker/config.json
```

The file should contain `credsStore`, but it should not contain a long `auth`
value with your credentials.

## Option 2: GPG and Pass

This method stores Docker credentials in `pass`, the standard Unix password
manager. `pass` encrypts secrets with GPG and stores them under
`~/.password-store/`.

This is a good choice if you prefer a terminal-first workflow and want your
credential store to be independent from a desktop keyring.

### Install Packages (pass, gnupg, docker-credential-pass)

Install `pass`, GPG, and the Docker credential helper:

```bash
sudo pacman -S --needed pass gnupg
yay -S docker-credential-pass
```

### Generate a GPG Key

Create a GPG key:

```bash
gpg --full-generate-key
```

Recommended settings:

- Key type: `1` for RSA and RSA
- Key size: `4096`
- Expiration: `0` for no expiration, or another value if preferred
- Real name and email: use values you can recognize later

Use a strong GPG passphrase. This passphrase protects your encrypted secrets.

### Find Your GPG Key ID

List your secret keys:

```bash
gpg --list-secret-keys --keyid-format LONG
```

Look for the line that starts with `sec`:

```text
sec   rsa4096/F0CF6767CDB76281 2025-11-23 [SC]
```

In this example, the key ID is:

```text
F0CF6767CDB76281
```

### Initialize Pass

Initialize `pass` with your GPG key ID:

```bash
pass init YOUR_KEY_ID
```

Example:

```bash
pass init F0CF6767CDB76281
```

This creates the password store directory:

```text
~/.password-store/
```

### Configure Docker (pass)

Create or edit this file:

```bash
nvim ~/.docker/config.json
```

Use this configuration:

```json
{
  "auths": {
    "https://index.docker.io/v1/": {}
  },
  "credsStore": "pass"
}
```

Docker automatically resolves `pass` to the `docker-credential-pass`
executable.

### Log In to Docker

Run:

```bash
docker login
```

Docker will store the credentials through `docker-credential-pass`, and `pass`
will encrypt them with your GPG key.

## How GPG and Pass Work with Docker

The flow looks like this:

```text
Docker command
    |
    v
Docker credential helper
    |
    v
pass
    |
    v
GPG-encrypted password store
```

For example, when you run `docker push`:

1. Docker needs registry credentials.
2. Docker asks `docker-credential-pass` for the credentials.
3. `docker-credential-pass` asks `pass` to retrieve the secret.
4. `pass` asks GPG to decrypt the secret.
5. GPG may ask for your GPG passphrase.
6. Docker receives the decrypted credentials and uses them for the operation.

The GPG passphrase prompt is expected. It is part of the security model.

## What Gets Stored Where

### Insecure Plain-Text Style

Without a credential helper, Docker config may contain an `auth` value:

```json
{
  "auths": {
    "https://index.docker.io/v1/": {
      "auth": "base64-encoded-credential"
    }
  }
}
```

Base64 is not encryption. It is only an encoding.

### Secure Helper Style

With a credential helper, Docker config only points to the helper:

```json
{
  "auths": {
    "https://index.docker.io/v1/": {}
  },
  "credsStore": "pass"
}
```

Or, when using GNOME Keyring:

```json
{
  "credsStore": "secretservice"
}
```

The real credentials are stored outside `~/.docker/config.json`.

For `pass`, Docker credentials are usually stored under:

```text
~/.password-store/docker-credential-helpers/
```

The files in that directory are encrypted GPG files.

For GNOME Keyring, the credentials are stored in the keyring database and can be
viewed through Seahorse.

## Troubleshooting

### Docker Still Writes an Auth Field

Check that `credsStore` is spelled correctly:

```json
{
  "credsStore": "pass"
}
```

or:

```json
{
  "credsStore": "secretservice"
}
```

The field name is `credsStore`, not `credStore`, `credentialStore`, or
`credsstore`.

Also check that the helper executable exists:

```bash
command -v docker-credential-pass
command -v docker-credential-secretservice
```

Only the helper for your chosen method needs to exist.

### Docker Does Not Prompt for the GPG Passphrase

The GPG agent may be caching your passphrase. That is normal.

To reload the agent:

```bash
echo RELOADAGENT | gpg-connect-agent
```

You can also kill the agent:

```bash
gpgconf --kill gpg-agent
```

The next operation that needs the key may prompt again.

### GPG Says No Secret Key

This usually means `pass` was initialized with a key that is not available on
this system.

List your secret keys:

```bash
gpg --list-secret-keys --keyid-format LONG
```

Then reinitialize `pass` with the correct key ID:

```bash
pass init YOUR_KEY_ID
```

### Test Pass Manually

Store a test secret:

```bash
pass insert test/example
```

Read it back:

```bash
pass test/example
```

If this works, `pass` and GPG are working.

### Secret Service Helper Cannot Store Credentials

Make sure the Secret Service daemon is running:

```bash
pgrep -a gnome-keyring-daemon
```

On Hyprland, make sure this line exists in your Hyprland config:

```conf
exec-once = gnome-keyring-daemon --start --components=secrets
```

Then log out and log back in.

### Keyring Does Not Unlock Automatically

The `login` keyring should use the same password as your Linux user account. If
it uses a different password, it may not unlock automatically during login.

You can change the keyring password in Seahorse.

## Choosing Between Secret Service and Pass

Use GNOME Keyring and Secret Service if:

- You already use a desktop session.
- You want credentials managed by the desktop keyring.
- You prefer GUI inspection through Seahorse.
- You want automatic unlock through PAM login integration.

Use GPG and `pass` if:

- You prefer terminal-first tooling.
- You want a simple file-based encrypted password store.
- You already use GPG.
- You want the same password store to work across many CLI tools.

Both options are valid. The important part is to avoid storing registry tokens
plainly in Docker's config file.

## Security Notes

- Do not commit `~/.docker/config.json` to a Git repository.
- Do not share files from `~/.password-store/` unless you understand GPG key
  access and trust.
- Prefer Docker access tokens over account passwords when possible.
- Protect your GPG private key and your Linux user account.
- Keep your credential helper packages updated.

## Useful Commands

Show Docker config:

```bash
cat ~/.docker/config.json
```

Log in to Docker Hub:

```bash
docker login
```

Log out from Docker Hub:

```bash
docker logout
```

List GPG secret keys:

```bash
gpg --list-secret-keys --keyid-format LONG
```

List `pass` entries:

```bash
pass
```

Show Docker entries stored by `pass`:

```bash
pass docker-credential-helpers
```

Reload the GPG agent:

```bash
echo RELOADAGENT | gpg-connect-agent
```

Kill the GPG agent:

```bash
gpgconf --kill gpg-agent
```
