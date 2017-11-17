From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v1 7/8] Bluetooth: hci_serdev: remove the HCI_UART_INIT_PENDING check
Date: Fri, 17 Nov 2017 23:35:42 +0100
Message-ID: <20171117223543.32429-8-martin.blumenstingl@googlemail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171117223543.32429-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The three-wire (H5) protocol is the only protocol which uses
HCI_UART_INIT_PENDING.
Unfortunately the protocol implementation never receives data with this
check still in place. For the H5 protocol this means that the
initialization never completes and thus the firmware download never
starts. Even if the initialization would succeed later on the drivers
would call hci_uart_init_ready() which schedules the registration which
is currently not implemented by hci_serdev.c.

Removing the HCI_UART_INIT_PENDING check makes the code easier to read
and also fixes the initalization of devices (implemented with the serdev
library) which use the H5 protocol.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/bluetooth/hci_serdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461b9200..fe67eb6d4278 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -333,9 +333,6 @@ int hci_uart_register_device(struct hci_uart *hu,
 	else
 		hdev->dev_type = HCI_PRIMARY;
 
-	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
-		return 0;
-
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		err = -ENODEV;
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
