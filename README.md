# led_on_off_pwm

LED Demo Project

## TODO
How to fix: (com.example.led_on_off_pwm:3567): Atk-CRITICAL **: 10:44:36.833: atk_socket_embed: assertion 'plug_id != NULL' failed
Install this:
```
sudo apt install at-spi2-core
```
at-spi2-core enables ATK accessibility support.

You may also need to install:
```
sudo apt install libatk-adaptor
```
libatk-adaptor is needed for applications using GTK and ATK to integrate properly with accessibility tools.

When running the app from CLI: sudo ./app_name
- XDG_RUNTIME_DIR is used by many GUI-based applications and must point to /run/user/UID where UID is your user ID.
- sudo removes most environment variables by default, which is why this error occurs.
- The solutions ensure that XDG_RUNTIME_DIR is set before launching the application.

How to fix: error: SDG_RUNTIME_DIR is invalid or not set in the environment.
- Option: 1
Perserve the environment
```
sudo XDG_RUNTIME_DIR=/run/user/$(id -u) ./app_name
```
- Option 2
Preserve the environment variables
```
sudo -E ./app_name
```
Option 3
Edit the sudoers file - this opens the file.
```
sudo visudo
```
At the end of the file add this, save and then reboot and try again.
```
Defaults env_keep += "XDG_RUNTIME_DIR"
```
