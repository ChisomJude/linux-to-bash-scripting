#!/bin/bash

echo "What is your Name?"

read name

echo "What is your Surname?"

read surname

username=$name$surname

company_domain=@google.com

email=$username$company_domain

echo "Creating an user account for $username"

sudo useradd -m -s /bin/bash $username

echo "Adding $username to Devops group (Assuming it already exists)..."

sudo usermod $username -aG Devops

echo "---Result---"

echo "Email: $email"

echo "User: $username"

echo "Groups: "$(sudo groups $username)