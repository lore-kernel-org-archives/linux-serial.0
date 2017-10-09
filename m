From: Ian W MORRISON <ianwmorrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 1/2] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 serdev support
Date: Mon, 9 Oct 2017 11:43:19 +1100
Message-ID: <7bdc8a8a-1a36-0494-ed0c-6e2052fb53d7@gmail.com>
References: <82b477ef-757a-c953-45e8-fd68b28286e5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <82b477ef-757a-c953-45e8-fd68b28286e5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "bluez mailin list (linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly
since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented for
serdev. This is only possible if serdev support is compiled in as the code
hooks into TTY. Otherwise PM will silently break as the corresponding
platform devices would no longer be registered and as the tty class
device is also gone and hciattach (btattach) will also fail.

This patch set addresses this by making BT_HCIUART_BCM dependent on
SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS
and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

Signed-off-by: Ian W MORRISON <ianwmorrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
