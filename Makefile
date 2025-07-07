# Makefile for Python package template configuration
# This Makefile reads settings and updates setup.cfg with sed commands

# Include the settings file
include settings

# Define required macros for validation
REQUIRED_VARS := PACKAGE_NAME AUTHOR_NAME AUTHOR_EMAIL GIT_URL DESCRIPTION

# Default target
.PHONY: default
default: help

# Check that all required variables are defined
.PHONY: check-vars
check-vars:
	@echo "Checking required variables..."
	@$(foreach var,$(REQUIRED_VARS),\
		$(if $(value $(var)),,\
			$(error ERROR: $(var) is not defined in settings file)))
	@echo "All required variables are defined."

# Update setup.cfg with values from settings
.PHONY: update-setup
update-setup: check-vars
	@echo "Updating setup.cfg with values from settings..."
	@# Create backup of original file
	cp setup.cfg setup.cfg.bak
	@# Replace PACKAGE_NAME
	sed -i.tmp 's/name = {PACKAGE_NAME}/name = $(PACKAGE_NAME)/' setup.cfg
	@# Replace AUTHOR_NAME
	sed -i.tmp 's/author={AUTHOR_NAME}/author=$(AUTHOR_NAME)/' setup.cfg
	@# Replace AUTHOR_EMAIL in author_email line
	sed -i.tmp 's/author_email="{AUTHOR_NAME}" <{AUTHOR_EMAIL}>/author_email="$(AUTHOR_NAME)" <$(AUTHOR_EMAIL)>/' setup.cfg
	@# Replace GIT_URL
	sed -i.tmp 's|url={GIT_URL}|url=$(GIT_URL)|' setup.cfg
	@# Replace DESCRIPTION
	sed -i.tmp 's/description = {DESCRIPTION}/description = $(DESCRIPTION)/' setup.cfg
	@# Remove temporary files
	rm -f setup.cfg.tmp
	@echo "setup.cfg has been updated successfully."
	@echo "Original file backed up as setup.cfg.bak"

# Show current values
.PHONY: show-vars
show-vars:
	@echo "Current settings values:"
	@echo "PACKAGE_NAME: $(PACKAGE_NAME)"
	@echo "AUTHOR_NAME: $(AUTHOR_NAME)"
	@echo "AUTHOR_EMAIL: $(AUTHOR_EMAIL)"
	@echo "GIT_URL: $(GIT_URL)"
	@echo "DESCRIPTION: $(DESCRIPTION)"

# Clean up backup files
.PHONY: clean
clean:
	@rm -f setup.cfg.bak setup.cfg.tmp
	@echo "Cleanup completed."

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  check-vars    - Check that all required variables are defined"
	@echo "  update-setup  - Update setup.cfg with values from settings file"
	@echo "  show-vars     - Display current variable values"
	@echo "  clean         - Remove backup files"
	@echo "  help          - Show this help message"