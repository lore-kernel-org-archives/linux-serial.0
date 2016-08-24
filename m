From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 6/6] bluetooth: hack up ldisc to use serio
Date: Wed, 24 Aug 2016 18:24:37 -0500
Message-ID: <20160824232437.9446-8-robh@kernel.org>
References: <20160824232437.9446-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160824232437.9446-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This hacks up the BT ldisc in place to work as a serio driver. It will
need refactoring into common, ldisc, and serio parts.

It is working under QEMU to the point the driver can bind to a serio
device via DT, register as a BT device, start sending out initial
packets and receive data (typed at a terminal). Now I need to find a
real device.

Still need to figure out how to plumb a few tty things like
TTY_DO_WRITE_WAKEUP bit handling and tty_unthrottle.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/bluetooth/hci_ldisc.c | 261 +++++++++++++++++-------------------------
 drivers/bluetooth/hci_uart.h  |   3 +
 2 files changed, 109 insertions(+), 155 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dda9739..8149952 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -34,7 +34,9 @@
 #include <linux/poll.h>
 
 #include <linux/slab.h>
-#include <linux/tty.h>
+#include <linux/serio.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/signal.h>
@@ -138,7 +140,7 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 static void hci_uart_write_work(struct work_struct *work)
 {
 	struct hci_uart *hu = container_of(work, struct hci_uart, write_work);
-	struct tty_struct *tty = hu->tty;
+	struct serio *serio = hu->serio;
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
 
@@ -152,8 +154,8 @@ restart:
 	while ((skb = hci_uart_dequeue(hu))) {
 		int len;
 
-		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-		len = tty->ops->write(tty, skb->data, skb->len);
+//		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+		len = serio_write_buf(serio, skb->data, skb->len);
 		hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
@@ -215,17 +217,15 @@ static int hci_uart_open(struct hci_dev *hdev)
 static int hci_uart_flush(struct hci_dev *hdev)
 {
 	struct hci_uart *hu  = hci_get_drvdata(hdev);
-	struct tty_struct *tty = hu->tty;
 
-	BT_DBG("hdev %p tty %p", hdev, tty);
+	BT_DBG("hdev %p serio %p", hdev, hu->serio);
 
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
 
 	/* Flush any pending characters in the driver and discipline. */
-	tty_ldisc_flush(tty);
-	tty_driver_flush_buffer(tty);
+	serio_write_flush(hu->serio);
 
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		hu->proto->flush(hu);
@@ -261,6 +261,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 /* Flow control or un-flow control the device */
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 {
+	serio_set_flow_control(hu->serio, enable);
+#if 0
 	struct tty_struct *tty = hu->tty;
 	struct ktermios ktermios;
 	int status;
@@ -309,6 +311,7 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		BT_DBG("Enabling hardware flow control: %s",
 		       status ? "failed" : "success");
 	}
+#endif
 }
 
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
@@ -317,7 +320,7 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 	hu->init_speed = init_speed;
 	hu->oper_speed = oper_speed;
 }
-
+#if 0
 void hci_uart_init_tty(struct hci_uart *hu)
 {
 	struct tty_struct *tty = hu->tty;
@@ -336,21 +339,13 @@ void hci_uart_init_tty(struct hci_uart *hu)
 	/* tty_set_termios() return not checked as it is always 0 */
 	tty_set_termios(tty, &ktermios);
 }
-
+#endif
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
-	struct tty_struct *tty = hu->tty;
-	struct ktermios ktermios;
-
-	ktermios = tty->termios;
-	ktermios.c_cflag &= ~CBAUD;
-	tty_termios_encode_baud_rate(&ktermios, speed, speed);
-
-	/* tty_set_termios() return not checked as it is always 0 */
-	tty_set_termios(tty, &ktermios);
+	int out_speed = serio_set_baudrate(hu->serio, speed);
 
 	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
-	       tty->termios.c_ispeed, tty->termios.c_ospeed);
+	       speed, out_speed);
 }
 
 static int hci_uart_setup(struct hci_dev *hdev)
@@ -428,83 +423,6 @@ done:
 	return 0;
 }
 
-/* ------ LDISC part ------ */
-/* hci_uart_tty_open
- *
- *     Called when line discipline changed to HCI_UART.
- *
- * Arguments:
- *     tty    pointer to tty info structure
- * Return Value:
- *     0 if success, otherwise error code
- */
-static int hci_uart_tty_open(struct tty_struct *tty)
-{
-	struct hci_uart *hu;
-
-	BT_DBG("tty %p", tty);
-
-	/* Error if the tty has no write op instead of leaving an exploitable
-	   hole */
-	if (tty->ops->write == NULL)
-		return -EOPNOTSUPP;
-
-	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
-	if (!hu) {
-		BT_ERR("Can't allocate control structure");
-		return -ENFILE;
-	}
-
-	tty->disc_data = hu;
-	hu->tty = tty;
-	tty->receive_room = 65536;
-
-	INIT_WORK(&hu->init_ready, hci_uart_init_work);
-	INIT_WORK(&hu->write_work, hci_uart_write_work);
-
-	/* Flush any pending characters in the driver */
-	tty_driver_flush_buffer(tty);
-
-	return 0;
-}
-
-/* hci_uart_tty_close()
- *
- *    Called when the line discipline is changed to something
- *    else, the tty is closed, or the tty detects a hangup.
- */
-static void hci_uart_tty_close(struct tty_struct *tty)
-{
-	struct hci_uart *hu = tty->disc_data;
-	struct hci_dev *hdev;
-
-	BT_DBG("tty %p", tty);
-
-	/* Detach from the tty */
-	tty->disc_data = NULL;
-
-	if (!hu)
-		return;
-
-	hdev = hu->hdev;
-	if (hdev)
-		hci_uart_close(hdev);
-
-	cancel_work_sync(&hu->write_work);
-
-	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		if (hdev) {
-			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-				hci_unregister_dev(hdev);
-			hci_free_dev(hdev);
-		}
-		hu->proto->close(hu);
-	}
-	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
-
-	kfree(hu);
-}
-
 /* hci_uart_tty_wakeup()
  *
  *    Callback for transmit wakeup. Called when low level
@@ -513,18 +431,18 @@ static void hci_uart_tty_close(struct tty_struct *tty)
  * Arguments:        tty    pointer to associated tty instance data
  * Return Value:    None
  */
-static void hci_uart_tty_wakeup(struct tty_struct *tty)
+static void hci_uart_serio_wakeup(struct serio *serio)
 {
-	struct hci_uart *hu = tty->disc_data;
+	struct hci_uart *hu = serio_get_drvdata(serio);
 
 	BT_DBG("");
 
 	if (!hu)
 		return;
 
-	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+//	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
-	if (tty != hu->tty)
+	if (serio != hu->serio)
 		return;
 
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
@@ -543,16 +461,16 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  *
  * Return Value:    None
  */
-static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 char *flags, int count)
+static int hci_uart_serio_receive(struct serio *serio, const u8 *data,
+				   size_t count)
 {
-	struct hci_uart *hu = tty->disc_data;
+	struct hci_uart *hu = serio_get_drvdata(serio);
 
-	if (!hu || tty != hu->tty)
-		return;
+	if (!hu || serio != hu->serio)
+		return 0;
 
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
-		return;
+		return 0;
 
 	/* It does not need a lock here as it is already protected by a mutex in
 	 * tty caller
@@ -562,7 +480,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 	if (hu->hdev)
 		hu->hdev->stat.byte_rx += count;
 
-	tty_unthrottle(tty);
+//	tty_unthrottle(tty);
+	return count;
 }
 
 static int hci_uart_register_dev(struct hci_uart *hu)
@@ -595,7 +514,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->flush = hci_uart_flush;
 	hdev->send  = hci_uart_send_frame;
 	hdev->setup = hci_uart_setup;
-	SET_HCIDEV_DEV(hdev, hu->tty->dev);
+	SET_HCIDEV_DEV(hdev, &hu->serio->dev);
 
 	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
@@ -650,6 +569,7 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	return 0;
 }
+#if 0
 
 static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 {
@@ -733,56 +653,95 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 
 	return err;
 }
+#endif
 
-/*
- * We don't provide read/write/poll interface for user space.
- */
-static ssize_t hci_uart_tty_read(struct tty_struct *tty, struct file *file,
-				 unsigned char __user *buf, size_t nr)
+static int hci_uart_connect(struct serio *serio, struct serio_driver *drv)
 {
-	return 0;
-}
+	int id, ret;
+	struct hci_uart *hu;
+
+	BT_INFO("HCI UART driver ver %s", VERSION);
+
+	id = (int)of_device_get_match_data(&serio->dev);
+
+	hu = devm_kzalloc(&serio->dev, sizeof(struct hci_uart), GFP_KERNEL);
+	if (!hu)
+		return -ENFILE;
+
+	serio_set_drvdata(serio, hu);
+	hu->serio = serio;
+
+//	tty->receive_room = 65536;
+
+	INIT_WORK(&hu->init_ready, hci_uart_init_work);
+	INIT_WORK(&hu->write_work, hci_uart_write_work);
+
+	ret = serio_open(serio, drv);
+	if (ret)
+		return ret;
+
+	set_bit(HCI_UART_PROTO_SET, &hu->flags);
+	ret = hci_uart_set_proto(hu, id);
+	if (ret) {
+		serio_close(serio);
+		return ret;
+	}
+
+	/* Flush any pending characters in the driver */
+//	tty_driver_flush_buffer(tty);
 
-static ssize_t hci_uart_tty_write(struct tty_struct *tty, struct file *file,
-				  const unsigned char *data, size_t count)
-{
-	return 0;
-}
 
-static unsigned int hci_uart_tty_poll(struct tty_struct *tty,
-				      struct file *filp, poll_table *wait)
-{
 	return 0;
 }
 
-static int __init hci_uart_init(void)
+static void hci_uart_disconnect(struct serio *serio)
 {
-	static struct tty_ldisc_ops hci_uart_ldisc;
-	int err;
+	struct hci_dev *hdev;
+	struct hci_uart *hu = serio_get_drvdata(serio);
 
-	BT_INFO("HCI UART driver ver %s", VERSION);
+	hdev = hu->hdev;
+	if (hdev)
+		hci_uart_close(hdev);
 
-	/* Register the tty discipline */
-
-	memset(&hci_uart_ldisc, 0, sizeof(hci_uart_ldisc));
-	hci_uart_ldisc.magic		= TTY_LDISC_MAGIC;
-	hci_uart_ldisc.name		= "n_hci";
-	hci_uart_ldisc.open		= hci_uart_tty_open;
-	hci_uart_ldisc.close		= hci_uart_tty_close;
-	hci_uart_ldisc.read		= hci_uart_tty_read;
-	hci_uart_ldisc.write		= hci_uart_tty_write;
-	hci_uart_ldisc.ioctl		= hci_uart_tty_ioctl;
-	hci_uart_ldisc.poll		= hci_uart_tty_poll;
-	hci_uart_ldisc.receive_buf	= hci_uart_tty_receive;
-	hci_uart_ldisc.write_wakeup	= hci_uart_tty_wakeup;
-	hci_uart_ldisc.owner		= THIS_MODULE;
-
-	err = tty_register_ldisc(N_HCI, &hci_uart_ldisc);
-	if (err) {
-		BT_ERR("HCI line discipline registration failed. (%d)", err);
-		return err;
+	cancel_work_sync(&hu->write_work);
+
+	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+		if (hdev) {
+			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+				hci_unregister_dev(hdev);
+			hci_free_dev(hdev);
+		}
+		hu->proto->close(hu);
 	}
+	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
+
+	pr_info("hci_uart disconnect!!!\n");
+	serio_close(serio);
+}
+
+
+static const struct of_device_id hci_uart_of_match[] = {
+	{ .compatible = "loopback-uart", .data = (void *)HCI_UART_BCSP },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hci_uart_of_match);
+
+static struct serio_driver serio_hci_uart_drv = {
+	.driver		= {
+		.name	= "hci-uart",
+		.of_match_table = of_match_ptr(hci_uart_of_match),
+	},
+	.description	= "hci uart",
+	.write_wakeup	= hci_uart_serio_wakeup,
+	.receive_buf	= hci_uart_serio_receive,
+	.connect	= hci_uart_connect,
+	.disconnect	= hci_uart_disconnect,
+};
 
+module_serio_driver(serio_hci_uart_drv);
+
+static int __init hci_uart_init(void)
+{
 #ifdef CONFIG_BT_HCIUART_H4
 	h4_init();
 #endif
@@ -816,8 +775,6 @@ static int __init hci_uart_init(void)
 
 static void __exit hci_uart_exit(void)
 {
-	int err;
-
 #ifdef CONFIG_BT_HCIUART_H4
 	h4_deinit();
 #endif
@@ -845,11 +802,6 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_AG6XX
 	ag6xx_deinit();
 #endif
-
-	/* Release tty registration of line discipline */
-	err = tty_unregister_ldisc(N_HCI);
-	if (err)
-		BT_ERR("Can't unregister HCI line discipline (%d)", err);
 }
 
 module_init(hci_uart_init);
@@ -859,4 +811,3 @@ MODULE_AUTHOR("Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>");
 MODULE_DESCRIPTION("Bluetooth HCI UART driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_LDISC(N_HCI);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 839bad1..c48dddc 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -73,8 +73,11 @@ struct hci_uart_proto {
 	struct sk_buff *(*dequeue)(struct hci_uart *hu);
 };
 
+struct serio;
+
 struct hci_uart {
 	struct tty_struct	*tty;
+	struct serio		*serio;
 	struct hci_dev		*hdev;
 	unsigned long		flags;
 	unsigned long		hdev_flags;
-- 
2.9.3
