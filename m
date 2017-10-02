From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev
Date: Mon,  2 Oct 2017 17:23:48 +0200
Message-ID: <20171002152356.4714-2-hdegoede@redhat.com>
References: <20171002152356.4714-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171002152356.4714-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix a NULL pointer deref (hu->tty) when calling hci_uart_set_flow_control
on hci_uart-s using serdev.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_ldisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a746627e784e..d02f6d029093 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -41,6 +41,7 @@
 #include <linux/ioctl.h>
 #include <linux/skbuff.h>
 #include <linux/firmware.h>
+#include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -298,6 +299,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 	unsigned int set = 0;
 	unsigned int clear = 0;
 
+	if (hu->serdev) {
+		serdev_device_set_flow_control(hu->serdev, !enable);
+		return;
+	}
+
 	if (enable) {
 		/* Disable hardware flow control */
 		ktermios = tty->termios;
-- 
2.14.2

