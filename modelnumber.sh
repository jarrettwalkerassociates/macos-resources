#!/bin/bash

# Get Model Abbreviation
# Tully Jagoe 240819
# Set to run on each boot
# Set command output as a Custom Device Attribute called custom_cc_modelid

# Get the Model Name of the Mac
modelName=$(system_profiler SPHardwareDataType | awk -F': ' '/Model Name/{print $2}' | tr -d ' ')

# Convert device name to abbreviation
model=""
[[ "${modelName}" == "MacBookPro" ]] && model="MBP"
[[ "${modelName}" == "MacBookAir" ]] && model="MBA"
[[ "${modelName}" == "MacBook" ]] && model="Mac"
[[ "${modelName}" == "iMac" ]] && model="iMac"
[[ "${modelName}" == "iMacPro" ]] && model="iMacPro"
[[ "${modelName}" == "MacPro" ]] && model="mPro"
[[ "${modelName}" == "MacStudio" ]] && model="mStu"
[[ "${modelName}" == "Macmini" ]] && model="mMin"

# If it smells like a duck...
[[ $(system_profiler SPHardwareDataType | awk -F': ' '/Model Identifier/{print $2}' | tr -d ' ' ) == "VMware"* ]] && model="VM"

# Regex, set to MAC if none of the above
[[ ! "${model}" =~ ^(MBP|MBA|MAC|IMAC|IMACPRO|MPRO|MS|MINI|VM)$ ]] && model="Mac"

echo -e "${model}"