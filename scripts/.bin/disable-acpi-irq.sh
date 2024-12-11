#!/bin/sh

# Read most annoying IRQ, example output:
# /sys/firmware/acpi/interrupts/gpe69: 3928454     STS enabled      unmasked
irq=$(grep -Ev "^[ ]*0" /sys/firmware/acpi/interrupts/gpe?? | sort --field-separator=: --key=2 --numeric --reverse | head -1 | grep enabled)

# parse output and extract filename
if [ ! -z "$irq" ]; then
    filename=$(echo "$irq" | awk -F: '{ print $1 }')
    echo disable > $filename
fi
