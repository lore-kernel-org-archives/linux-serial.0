From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH v2 1/2] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 serdev support
Date: Sun, 8 Oct 2017 14:20:07 +1100
Message-ID: <82b477ef-757a-c953-45e8-fd68b28286e5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, hdegoede@redhat.com, frederic.danis.oss@gmail.com, robh@kernel.org, sre@kernel.org, Loic Poulain <loic.poulain@gmail.com>, lukas@wunner.de, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented for serdev. This is only possible if serdev support is compiled in as the code hooks into TTY. Otherwise PM will silently break as the corresponding platform devices would no longer be registered and as the tty class device is also gone and hciattach (btattach) will also fail.

This patch set addresses this by making BT_HCIUART_BCM dependent on SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/tty/serdev/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index cdc6b820cf93..1144f4db5087 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -2,7 +2,7 @@
 # Serial bus device driver configuration
 #
 menuconfig SERIAL_DEV_BUS
-	tristate "Serial device bus"
+	bool "Serial device bus"
 	help
 	  Core support for devices connected via a serial port.
 
@@ -11,6 +11,6 @@ if SERIAL_DEV_BUS
 config SERIAL_DEV_CTRL_TTYPORT
 	bool "Serial device TTY port controller"
 	depends on TTY
-	depends on SERIAL_DEV_BUS != m
+	depends on SERIAL_DEV_BUS
 
 endif
-- 
2.11.0
