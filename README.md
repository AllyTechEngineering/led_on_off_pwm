# led_on_off_pwm for Model 5

LED Demo Project
- Turns an LED off or on (flashing) from user UI input.
- Turns an LED on or off from a sensor state change.
- Uses PWM to control the brightness of an LED.
- User can set the brightness and turn the LED on/off at a set dutycycle.
## Summary
- Cookbook of methods and classes to use the PWM functions, write to GPIO and read from GPIO.
- Includes async Dart features for polling and delays.
- Uses BLoC for state management.
- Individual classes for GPIO service and PWM Service.
- Individual classes for the UI Widgets.
- constants.dart for easy of changing key parameters.



## TODO
- Watch out for flutter upgrade switching the the master channel!
If you get an error that the dart version of your project is higher then stable:
go to pubspec.yaml and change this to the current stable version.
For example:
``
environment:
  sdk: ^3.6.2
``

To safely upgrade use this instead:
```
flutter channel stable && flutter upgrade
```

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
