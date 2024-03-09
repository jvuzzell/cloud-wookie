#!/bin/bash

echo ""

echo "Changing directory to..."
if cd "$ENVIRONMENTS_DIR/dev/"; then
    pwd
else
    echo "Failed to change directory. Exiting..."
    exit 1
fi
echo "-----"
echo ""

terraform plan -destroy -out=full-destroy.plan

echo "Do you want to proceed with destroying the infrastructure? (yes/no)"
read -r confirmation

if [ "$confirmation" = "yes" ]; then
    terraform apply "full-destroy.plan"
    echo "Infrastructure destruction completed."
else
    echo "Destroy operation cancelled."
fi

# Remove the plan file after apply for security, relevance, and cleaniness
rm -f full-destroy.plan
echo "Removed the plan file."