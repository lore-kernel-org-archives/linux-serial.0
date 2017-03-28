From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv3 05/10] Bluetooth: hci_uart: add support for word alignment
Date: Tue, 28 Mar 2017 17:59:34 +0200
Message-ID: <20170328155939.31566-6-sre@kernel.org>
References: <20170328155939.31566-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170328155939.31566-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This will be used by Nokia's H4+ protocol, which
uses 2-byte aligned packets.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Changes since PATCHv1:
 * use u8 instead of uint8_t
---
 drivers/bluetooth/hci_h4.c    | 17 +++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |  4 ++++
 drivers/bluetooth/hci_uart.h  |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 635597b6e168..82e5a32b87a4 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -171,9 +171,20 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count)
 {
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	u8 alignment = hu->alignment;
+
 	while (count) {
 		int i, len;
 
+		/* remove padding bytes from buffer */
+		for (; hu->padding && count > 0; hu->padding--) {
+			count--;
+			buffer++;
+		}
+		if (!count)
+			break;
+
 		if (!skb) {
 			for (i = 0; i < pkts_count; i++) {
 				if (buffer[0] != (&pkts[i])->type)
@@ -253,11 +264,17 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			}
 
 			if (!dlen) {
+				hu->padding = (skb->len - 1) % alignment;
+				hu->padding = (alignment - hu->padding) % alignment;
+
 				/* No more data, complete frame */
 				(&pkts[i])->recv(hdev, skb);
 				skb = NULL;
 			}
 		} else {
+			hu->padding = (skb->len - 1) % alignment;
+			hu->padding = (alignment - hu->padding) % alignment;
+
 			/* Complete frame */
 			(&pkts[i])->recv(hdev, skb);
 			skb = NULL;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 9497c469efd2..0ec8a94bd712 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -459,6 +459,10 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	hu->tty = tty;
 	tty->receive_room = 65536;
 
+	/* disable alignment support by default */
+	hu->alignment = 1;
+	hu->padding = 0;
+
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 070139513e65..4aff50960cac 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -92,6 +92,9 @@ struct hci_uart {
 
 	unsigned int init_speed;
 	unsigned int oper_speed;
+
+	u8			alignment;
+	u8			padding;
 };
 
 /* HCI_UART proto flag bits */
-- 
2.11.0
