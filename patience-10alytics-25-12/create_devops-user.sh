#!/bin/bash

# To ensure script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script as root or with sudo"
  exit 1
fi

# Prompt for employee details
read -p "Enter First Name: " FIRSTNAME
read -p "Enter Surname: " SURNAME

# Validate input
if [[ -z "$FIRSTNAME" || -z "$SURNAME" ]]; then
  echo "Error: Both first name and surname are required"
  exit 1
fi

# Convert to lowercase and create username
USERNAME=$(echo "${FIRSTNAME}${SURNAME}" | tr '[:upper:]' '[:lower:]')

# Create email
EMAIL="${USERNAME}@mycompany.com"

# Group name
GROUP="devops"

# Create devops group if it doesn't exist
if ! getent group "$GROUP" >/dev/null; then
  groupadd "$GROUP"
fi

# Create user if it doesn't exist
if ! id "$USERNAME" &>/dev/null; then
  useradd -m -s /bin/bash -G "$GROUP" "$USERNAME"
  # Set a temporary password and force change on first login
  echo "$USERNAME:Password@123" | chpasswd
  chage -d 0 "$USERNAME"
fi

# Add user to devops group (safe if already member)
usermod -aG "$GROUP" "$USERNAME"

# Give devops group sudo privileges safely
SUDO_FILE="/etc/sudoers.d/devops"
if [[ ! -f "$SUDO_FILE" ]]; then
  echo "%$GROUP ALL=(ALL) ALL" > "$SUDO_FILE"
  chmod 440 "$SUDO_FILE"
fi

# Output
echo "-----------------------------"
echo "User : $FIRSTNAME $SURNAME"
echo "Email: $EMAIL"
echo "groups: Devops (permission sudo)"
echo "-----------------------------"
