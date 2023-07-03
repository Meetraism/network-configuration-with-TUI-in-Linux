# Makefile
# Find all Bash files in the directory
BASHEXEC := $(shell find . -type f -name "*.sh")

all: add_exec_permission

add_exec_permission: $(BASHEXEC)
    chmod +x $(BASHEXEC)