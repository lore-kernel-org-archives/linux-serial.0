From: Ian W MORRISON <ianwmorrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/2] serdev: Update drivers/bluetooth/Kconfig for ACPI
 serdev support
Date: Mon, 9 Oct 2017 11:43:31 +1100
Message-ID: <427a95f6-feda-e93e-9a0f-a05b7b339ee6@gmail.com>
References: <dc9cecc0-d9ef-109f-5f05-cf77ab16e60e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dc9cecc0-d9ef-109f-5f05-cf77ab16e60e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fae5a74dc737..8d432ee9f4bd 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -171,6 +171,7 @@ config BT_HCIUART_BCM
 	depends on BT_HCIUART_SERDEV
 	select BT_HCIUART_H4
 	select BT_BCM
+	select SERIAL_DEV_CTRL_TTYPORT
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
 	  port interface for Broadcom Bluetooth controllers.
-- 
2.11.0
