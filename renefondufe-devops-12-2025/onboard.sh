#!/bin/bash
set -euo pipefail

# Get employee details
read -r -p "First name: " f
read -r -p "Surname: " s

# Validate input (prevents "unbound variable" with -u)
if [[ -z "${f:-}" || -z "${s:-}" ]]; then
  echo "Error: First name and surname are required."
  exit 1
fi

# Create username and email (lowercase)
u="$(printf "%s%s" "${f:0:1}" "$s" | tr '[:upper:]' '[:lower:]')"
e="$(printf "%s%s@mycompany.com" "$f" "$s" | tr '[:upper:]' '[:lower:]')"

echo "Username will be: $u"
echo "Email will be:    $e"

# Create devops group if missing
if ! getent group devops >/dev/null; then
  sudo groupadd devops
fi

# Create user if missing
if ! id "$u" >/dev/null 2>&1; then
  sudo useradd -m "$u"
fi

# Add user to devops group
sudo usermod -aG devops "$u"

# Give devops group sudo permission (creates /etc/sudoers.d/devops safely)
sudo tee /etc/sudoers.d/devops >/dev/null <<'EOF'
%devops ALL=(ALL) ALL
EOF

# Validate sudoers config (important)
sudo chmod 0440 /etc/sudoers.d/devops
sudo visudo -cf /etc/sudoers.d/devops >/dev/null

echo "Done. User '$u' onboarded and added to devops group."
