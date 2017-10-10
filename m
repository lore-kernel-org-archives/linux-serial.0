From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Bluetooth: avoid silent hci_bcm ACPI PM regression
Date: Tue, 10 Oct 2017 10:01:52 +0200
Message-ID: <20171010080152.18444-1-johan@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The hci_bcm platform-device hack which was used to implement
power management for ACPI devices is being replaced by a
serial-device-bus implementation.

Unfortunately, when the corresponding change to the ACPI code lands (a
change that will stop enumerating and registering the serial-device-node
child as a platform device) PM will break silently unless serdev
TTY-port controller support has been enabled. Specifically, hciattach
(btattach) would still succeed, but power management would no longer
work.

Although this is strictly a runtime dependency, let's make the driver
depend on SERIAL_DEV_CTRL_TTYPORT, which is the particular serdev
controller implementation used by the ACPI devices currently managed by
this driver, to avoid breaking PM without anyone noticing.

Note that the driver already has a (build-time) dependency on the serdev
bus code.

Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fae5a74dc737..082e1c7329de 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -169,6 +169,7 @@ config BT_HCIUART_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
+	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
 	select BT_HCIUART_H4
 	select BT_BCM
 	help
-- 
2.14.2
