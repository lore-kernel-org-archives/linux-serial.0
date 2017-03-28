From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv3 08/10] Bluetooth: hci_serdev: allow modular drivers
Date: Tue, 28 Mar 2017 17:59:37 +0200
Message-ID: <20170328155939.31566-9-sre@kernel.org>
References: <20170328155939.31566-1-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328155939.31566-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

For bluetooth protocol driver only supporting serdev it makes
sense to follow common practice and built them into their own
module.

Such modules need access to hci_uart_register_device and
hci_uart_tx_wakeup for using the common protocol helpers.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
New patch since patchset v2.
---
 drivers/bluetooth/hci_ldisc.c  | 1 +
 drivers/bluetooth/hci_serdev.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 0ec8a94bd712..17bcbc13623f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -134,6 +134,7 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hci_uart_tx_wakeup);
 
 static void hci_uart_write_work(struct work_struct *work)
 {
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 3b8ac0ece3fb..7de0edc0ff8c 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -353,3 +353,4 @@ int hci_uart_register_device(struct hci_uart *hu,
 	p->close(hu);
 	return err;
 }
+EXPORT_SYMBOL_GPL(hci_uart_register_device);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
