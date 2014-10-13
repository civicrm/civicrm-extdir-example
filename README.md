### Example extension repository

When testing or developing with the extension browser or extension downloader, it is helpful to have your own locally-managed
extension directory.

This implementation aims for minimalism (at the cost of features/performance/etc). To add an extension, simply add an eponymous
folder with the code and run the "extdir.sh make" script.  Similarly, to update (or remove) an extension, update (or remove) the
folder, and again run "extdir.sh make".

### Installation and Configuration (with buildkit)

If you use buildkit ( https://github.com/civicrm/civicrm-buildkit ), then installation is pretty simple.

Choose a URL like "http://extdir.localhost" and run:

```bash
civibuild extdir --url http://extdir.localhost
## Note: You may need to update /etc/hosts and/or restart Apache
```

Any other CiviCRM installations created through buildkit will automatically download their extensions from here (instead of the
normal civicrm.org extensions directory).  To opt-out, you can either delete "build/extdir" or run

```bash
touch build/extdir/.extdir-no-auto
```

When using the "Extension Manager", you may need to "Refresh" the list of extensions.

### Installation and Configuration (Manual)

Setup a web-accessible folder and clone the git repo ( https://github.com/civicrm/civicrm-extdir-example.git ) into the
web-accessible directory.  Determine the corresponding URL (e.g.  "http://extdir.localhost") and run:

```bash
echo http://extdir.localhost > .extdir-url
./extdir.sh make
```

By default, CiviCRM installations browse and download via civicrm.org's Extensions Directory, but you can configure a particular
installation to download from the example repository.  Use civicrm.settings.php or the Settings API to set "ext_repo_url" (in group
"Extension Preferences").  For example, one might add this to civicrm.settings.php:

```php
global $civicrm_setting;
$civicrm_setting['Extension Preferences']['ext_repo_url'] = 'http://extdir.localhost';
```

When using the "Extension Manager", you may need to "Refresh" the list of extensions.
