unattended-upgrades
===================

v0.1.2 (2014-07-01)
-------------------

Fixes

* Fixed missing auto-upgrades.conf, preventing cron triggering these upgrades 

Changes

* no longer installs mailutils - a warning will be emitted if a mailer can't be detected instead

Features

* Now with unit and integration tests


v0.1.0 (2014-05-08)
-------------------
- First officially published release. Ubuntu support tested on 12.04
