### Example extension repository

When testing or developing with the extension browser or extension downloader, it is helpful to have your own locally-managed
extension directory.

### Installation

If you use buildkit ( https://github.com/civicrm/civicrm-buildkit ), then choose a URL like "http://extdir.localhost" and run:

```bash
civibuild extdir --url http://extdir.localhost
```

If installing manually, then clone the git repo ( https://github.com/civicrm/civicrm-extdir-example.git ) into a web-accessible
location.  Determine the corresponding URL (e.g.  "http://extdir.localhost") and run:

```bash
env DL_URL="http://extdir.localhost" ./extdir.sh make
```

### Managing extensions

To add an extension, simply add an eponymous folder with the code and re-run the "extdir.sh make" script.  Similarly, to update (or
remove) an extension, update (or remove) the folder, and again run "extdir.sh make".

### Browsing and downloading extensions

By default, CiviCRM installations will browse and download via civicrm.org's Extensions Directory, but you can configure a
particular installation to download from the example repository.  Simply the Settings API (group='Extension Preferences',
name='ext_repo_url').  For example, one might add this to civicrm.settings.php:

```php
global $civicrm_setting;
$civicrm_setting['Extension Preferences']['ext_repo_url'] = 'http://extdir.localhost';
```
