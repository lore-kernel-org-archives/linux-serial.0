From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev
Date: Wed,  4 Oct 2017 20:43:35 +0200
Message-ID: <20171004184343.7855-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix a NULL pointer deref (hu->tty) when calling hci_uart_set_flow_control
on hci_uart-s using serdev.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Also set RTS (Suggested-by: Sebastian Reichel <sre@kernel.org>)
---
 drivers/bluetooth/hci_ldisc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a746627e784e..eec95019f15c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -41,6 +41,7 @@
 #include <linux/ioctl.h>
 #include <linux/skbuff.h>
 #include <linux/firmware.h>
+#include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -298,6 +299,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 	unsigned int set = 0;
 	unsigned int clear = 0;
 
+	if (hu->serdev) {
+		serdev_device_set_flow_control(hu->serdev, !enable);
+		serdev_device_set_rts(hu->serdev, !enable);
+		return;
+	}
+
 	if (enable) {
 		/* Disable hardware flow control */
 		ktermios = tty->termios;
-- 
2.14.2

