#!/bin/bash
SCRATCH_ALIAS="MyFSCDev1"
SCRATCH_DEF="config/project-scratch-def.json"
CLASS_NAME="PersonAccountPrinter"
TEST_NAME="PersonAccountPrinterTest"

# Create scratch org
echo "Creating scratch org using definition file: $SCRATCH_DEF"
sf org create scratch --definition-file $SCRATCH_DEF --set-default --alias $SCRATCH_ALIAS
if [ $? -ne 0 ]; then
  echo "ERROR: Failed to create scratch org"
  exit 1
fi

#Deploy PersonAccountPrinter class + run the specified test
echo "Deploying $CLASS_NAME and running test: $TEST_NAME"
sf project deploy start --metadata "ApexClass:${CLASS_NAME}*" --target-org $SCRATCH_ALIAS -l RunSpecifiedTests -t $TEST_NAME
if [ $? -ne 0 ]; then
  echo "ERROR: Deployment or test execution failed"
  exit 1
fi

#Open scratch org
echo "Opening scratch org in browser..."
sf org open --target-org $SCRATCH_ALIAS
if [ $? -ne 0 ]; then
  echo "ERROR: Failed to open scratch org"
  exit 1
fi

echo "Script completed successfully"
