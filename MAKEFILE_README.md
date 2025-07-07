# Python Package Template Makefile

This Makefile automates the process of configuring `setup.cfg` with project-specific settings using a settings file.

## Features

- **Settings file validation**: Ensures all required macros are properly configured
- **Macro replacement**: Uses `sed` to replace placeholders in `setup.cfg` with actual values
- **Error handling**: Clear error messages for missing settings files or macros
- **Backup system**: Automatically backs up original `setup.cfg` before making changes
- **User-friendly output**: Colored output and clear status messages
- **Extensible**: Easy to add new macros and settings

## Usage

### Basic Commands

```bash
# Show help and available commands
make help

# Configure setup.cfg with default settings file (settings.conf)
make configure

# Configure setup.cfg with custom settings file
make configure SETTINGS_FILE=my_settings.conf

# Validate settings file without making changes
make validate

# Show current configuration from settings file
make show-config

# Restore original setup.cfg from backup
make clean
```

### Settings File Format

Create a settings file (default: `settings.conf`) with the following format:

```bash
# Package information
PACKAGE_NAME=my_awesome_package
DESCRIPTION=A description of my awesome package

# Author information
AUTHOR_NAME=Your Name
AUTHOR_EMAIL=your.email@example.com

# Repository information
GIT_URL=https://github.com/yourusername/yourrepo
```

### Required Macros

The following macros must be defined in your settings file:

- `PACKAGE_NAME`: Name of your Python package
- `DESCRIPTION`: Short description of your package
- `AUTHOR_NAME`: Your name or organization name
- `AUTHOR_EMAIL`: Your email address
- `GIT_URL`: URL to your Git repository

### Examples

1. **Basic configuration**:
   ```bash
   make configure
   ```

2. **Using a custom settings file**:
   ```bash
   make configure SETTINGS_FILE=production.conf
   ```

3. **Validating settings before configuration**:
   ```bash
   make validate SETTINGS_FILE=production.conf
   make configure SETTINGS_FILE=production.conf
   ```

4. **Checking current settings**:
   ```bash
   make show-config
   ```

5. **Restoring original setup.cfg**:
   ```bash
   make clean
   ```

## Error Handling

The Makefile provides clear error messages for common issues:

- **Missing settings file**: Clear message indicating the file doesn't exist
- **Missing required macros**: Lists exactly which macros are missing
- **Invalid settings format**: Graceful handling of malformed settings files

## Backup System

The Makefile automatically creates a backup of your original `setup.cfg` as `setup.cfg.backup` before making any changes. You can restore the original file at any time using `make clean`.

## Extensibility

To add new macros:

1. Add the macro name to the `REQUIRED_MACROS` variable in the Makefile
2. Add the macro definition to your settings file
3. Add the corresponding `{MACRO_NAME}` placeholder to your `setup.cfg`

Example:
```makefile
REQUIRED_MACROS = PACKAGE_NAME AUTHOR_NAME AUTHOR_EMAIL GIT_URL DESCRIPTION NEW_MACRO
```

## Files Created

- `setup.cfg.backup`: Backup of original setup.cfg (created automatically)
- `settings.conf`: Default settings file (you need to create this)
- `settings.example.conf`: Example settings file with realistic values

## Testing

Run the test script to verify functionality:
```bash
./test_files/test_makefile.sh
```