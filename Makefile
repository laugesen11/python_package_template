# Python Package Template Makefile
# This Makefile automates the configuration of setup.cfg with project-specific settings

# Default settings file
SETTINGS_FILE ?= settings.conf

# Required macros that must be defined
REQUIRED_MACROS = PACKAGE_NAME AUTHOR_NAME AUTHOR_EMAIL GIT_URL DESCRIPTION

# Colors for output
COLOR_GREEN = \033[0;32m
COLOR_RED = \033[0;31m
COLOR_YELLOW = \033[1;33m
COLOR_BLUE = \033[0;34m
COLOR_RESET = \033[0m

# Default target
.PHONY: help
help:
	@echo "$(COLOR_BLUE)Python Package Template Makefile$(COLOR_RESET)"
	@echo ""
	@echo "Usage:"
	@echo "  make configure              Configure setup.cfg with settings from $(SETTINGS_FILE)"
	@echo "  make validate               Validate that all required macros are set"
	@echo "  make show-config            Show current configuration from settings file"
	@echo "  make clean                  Restore original setup.cfg from backup"
	@echo ""
	@echo "Settings file: $(SETTINGS_FILE)"
	@echo "Required macros: $(REQUIRED_MACROS)"

# Main target to configure setup.cfg
.PHONY: configure
configure: validate backup-setup
	@echo "$(COLOR_BLUE)Configuring setup.cfg with settings from $(SETTINGS_FILE)...$(COLOR_RESET)"
	@$(MAKE) -s apply-macros
	@echo "$(COLOR_GREEN)✓ Configuration completed successfully!$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_YELLOW)Updated setup.cfg contents:$(COLOR_RESET)"
	@cat setup.cfg

# Validate that settings file exists and all required macros are set
.PHONY: validate
validate:
	@echo "$(COLOR_BLUE)Validating configuration...$(COLOR_RESET)"
	@if [ ! -f "$(SETTINGS_FILE)" ]; then \
		echo "$(COLOR_RED)Error: Settings file '$(SETTINGS_FILE)' not found!$(COLOR_RESET)"; \
		echo "Please create $(SETTINGS_FILE) with the required configuration values."; \
		echo "See 'make help' for more information."; \
		exit 1; \
	fi
	@$(MAKE) -s check-required-macros
	@echo "$(COLOR_GREEN)✓ All required macros are configured$(COLOR_RESET)"

# Check that all required macros are defined in settings file
.PHONY: check-required-macros
check-required-macros:
	@missing_macros=""; \
	for macro in $(REQUIRED_MACROS); do \
		if ! grep -q "^$$macro=" "$(SETTINGS_FILE)"; then \
			missing_macros="$$missing_macros $$macro"; \
		fi; \
	done; \
	if [ -n "$$missing_macros" ]; then \
		echo "$(COLOR_RED)Error: Missing required macros in $(SETTINGS_FILE):$$missing_macros$(COLOR_RESET)"; \
		echo "Please add the following lines to $(SETTINGS_FILE):"; \
		for macro in $$missing_macros; do \
			echo "  $$macro=your_value_here"; \
		done; \
		exit 1; \
	fi

# Create backup of original setup.cfg
.PHONY: backup-setup
backup-setup:
	@if [ ! -f "setup.cfg.backup" ]; then \
		cp setup.cfg setup.cfg.backup; \
		echo "$(COLOR_YELLOW)Created backup: setup.cfg.backup$(COLOR_RESET)"; \
	fi

# Apply macros to setup.cfg using sed
.PHONY: apply-macros
apply-macros:
	@temp_file=$$(mktemp); \
	cp setup.cfg "$$temp_file"; \
	while IFS='=' read -r key value; do \
		if [ -n "$$key" ] && [ -n "$$value" ] && [ "$${key#\#}" = "$$key" ]; then \
			sed -i "s|{$$key}|$$value|g" "$$temp_file"; \
		fi; \
	done < "$(SETTINGS_FILE)"; \
	cp "$$temp_file" setup.cfg; \
	rm "$$temp_file"

# Show current configuration from settings file
.PHONY: show-config
show-config:
	@if [ ! -f "$(SETTINGS_FILE)" ]; then \
		echo "$(COLOR_RED)Error: Settings file '$(SETTINGS_FILE)' not found!$(COLOR_RESET)"; \
		exit 1; \
	fi
	@echo "$(COLOR_BLUE)Current configuration from $(SETTINGS_FILE):$(COLOR_RESET)"
	@grep -v "^#" "$(SETTINGS_FILE)" | grep -v "^$$" | while IFS='=' read -r key value; do \
		echo "  $(COLOR_YELLOW)$$key$(COLOR_RESET) = $$value"; \
	done

# Restore original setup.cfg from backup
.PHONY: clean
clean:
	@if [ -f "setup.cfg.backup" ]; then \
		cp setup.cfg.backup setup.cfg; \
		echo "$(COLOR_GREEN)✓ Restored original setup.cfg from backup$(COLOR_RESET)"; \
	else \
		echo "$(COLOR_YELLOW)No backup found - setup.cfg unchanged$(COLOR_RESET)"; \
	fi

# Remove backup file
.PHONY: clean-backup
clean-backup:
	@if [ -f "setup.cfg.backup" ]; then \
		rm setup.cfg.backup; \
		echo "$(COLOR_GREEN)✓ Removed backup file$(COLOR_RESET)"; \
	else \
		echo "$(COLOR_YELLOW)No backup file to remove$(COLOR_RESET)"; \
	fi