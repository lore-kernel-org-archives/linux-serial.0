From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/4] n_gsm: clean up printks
Date: Thu, 04 Nov 2010 15:17:27 +0000
Message-ID: <20101104151714.21790.4269.stgit@localhost.localdomain>
References: <20101104151623.21790.64456.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49383 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab0KDPiZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2010 11:38:25 -0400
In-Reply-To: <20101104151623.21790.64456.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

[Original From Ken Mills but I redid it using pr_ helpers instead]

Also fix up coding style, there are two warnings left but that is where
the CodingStyle tools blow up because they cannot handle

	if (blah) {
		foo
	} else switch (x) {
		case 1:
		}

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/n_gsm.c |  154 ++++++++++++++++++++++++++------------------------
 1 files changed, 81 insertions(+), 73 deletions(-)


diff --git a/drivers/char/n_gsm.c b/drivers/char/n_gsm.c
index 02d09b5..5aaa5fe 100644
--- a/drivers/char/n_gsm.c
+++ b/drivers/char/n_gsm.c
@@ -19,7 +19,7 @@
  *
  * TO DO:
  *	Mostly done:	ioctls for setting modes/timing
- *	Partly done: 	hooks so you can pull off frames to non tty devs
+ *	Partly done:	hooks so you can pull off frames to non tty devs
  *	Restart DLCI 0 when it closes ?
  *	Test basic encoding
  *	Improve the tx engine
@@ -73,8 +73,10 @@ module_param(debug, int, 0600);
 #define T2	(2 * HZ)
 #endif
 
-/* Semi-arbitary buffer size limits. 0710 is normally run with 32-64 byte
-   limits so this is plenty */
+/*
+ * Semi-arbitary buffer size limits. 0710 is normally run with 32-64 byte
+ * limits so this is plenty
+ */
 #define MAX_MRU 512
 #define MAX_MTU 512
 
@@ -290,7 +292,7 @@ static spinlock_t gsm_mux_lock;
 #define MDM_DV			0x40
 
 #define GSM0_SOF		0xF9
-#define GSM1_SOF 		0x7E
+#define GSM1_SOF		0x7E
 #define GSM1_ESCAPE		0x7D
 #define GSM1_ESCAPE_BITS	0x20
 #define XON			0x11
@@ -433,61 +435,63 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 	if (!(debug & 1))
 		return;
 
-	printk(KERN_INFO "%s %d) %c: ", hdr, addr, "RC"[cr]);
+	pr_info("%s %d) %c: ", hdr, addr, "RC"[cr]);
 
 	switch (control & ~PF) {
 	case SABM:
-		printk(KERN_CONT "SABM");
+		pr_cont("SABM");
 		break;
 	case UA:
-		printk(KERN_CONT "UA");
+		pr_cont("UA");
 		break;
 	case DISC:
-		printk(KERN_CONT "DISC");
+		pr_cont("DISC");
 		break;
 	case DM:
-		printk(KERN_CONT "DM");
+		pr_cont("DM");
 		break;
 	case UI:
-		printk(KERN_CONT "UI");
+		pr_cont("UI");
 		break;
 	case UIH:
-		printk(KERN_CONT "UIH");
+		pr_cont("UIH");
 		break;
 	default:
 		if (!(control & 0x01)) {
-			printk(KERN_CONT "I N(S)%d N(R)%d",
-				(control & 0x0E) >> 1, (control & 0xE)>> 5);
+			pr_cont("I N(S)%d N(R)%d",
+				(control & 0x0E) >> 1, (control & 0xE) >> 5);
 		} else switch (control & 0x0F) {
-		case RR:
-			printk("RR(%d)", (control & 0xE0) >> 5);
-			break;
-		case RNR:
-			printk("RNR(%d)", (control & 0xE0) >> 5);
-			break;
-		case REJ:
-			printk("REJ(%d)", (control & 0xE0) >> 5);
-			break;
-		default:
-			printk(KERN_CONT "[%02X]", control);
+			case RR:
+				pr_cont("RR(%d)", (control & 0xE0) >> 5);
+				break;
+			case RNR:
+				pr_cont("RNR(%d)", (control & 0xE0) >> 5);
+				break;
+			case REJ:
+				pr_cont("REJ(%d)", (control & 0xE0) >> 5);
+				break;
+			default:
+				pr_cont("[%02X]", control);
 		}
 	}
 
 	if (control & PF)
-		printk(KERN_CONT "(P)");
+		pr_cont("(P)");
 	else
-		printk(KERN_CONT "(F)");
+		pr_cont("(F)");
 
 	if (dlen) {
 		int ct = 0;
 		while (dlen--) {
-			if (ct % 8 == 0)
-				printk(KERN_CONT "\n    ");
-			printk(KERN_CONT "%02X ", *data++);
+			if (ct % 8 == 0) {
+				pr_cont("\n");
+				pr_debug("    ");
+			}
+			pr_cont("%02X ", *data++);
 			ct++;
 		}
 	}
-	printk(KERN_CONT "\n");
+	pr_cont("\n");
 }
 
 
@@ -526,11 +530,13 @@ static void hex_packet(const unsigned char *p, int len)
 {
 	int i;
 	for (i = 0; i < len; i++) {
-		if (i && (i % 16) == 0)
-			printk("\n");
-		printk("%02X ", *p++);
+		if (i && (i % 16) == 0) {
+			pr_cont("\n");
+			pr_debug("");
+		}
+		pr_cont("%02X ", *p++);
 	}
-	printk("\n");
+	pr_cont("\n");
 }
 
 /**
@@ -680,7 +686,7 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 		}
 
 		if (debug & 4) {
-			printk("gsm_data_kick: \n");
+			pr_debug("gsm_data_kick:\n");
 			hex_packet(gsm->txframe, len);
 		}
 
@@ -1233,7 +1239,7 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 }
 
 /**
- *	gsm_control_transmit 	-	send control packet
+ *	gsm_control_transmit	-	send control packet
  *	@gsm: gsm mux
  *	@ctrl: frame to send
  *
@@ -1363,7 +1369,7 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 {
 	del_timer(&dlci->t1);
 	if (debug & 8)
-		printk("DLCI %d goes closed.\n", dlci->addr);
+		pr_debug("DLCI %d goes closed.\n", dlci->addr);
 	dlci->state = DLCI_CLOSED;
 	if (dlci->addr != 0) {
 		struct tty_struct  *tty = tty_port_tty_get(&dlci->port);
@@ -1394,7 +1400,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	/* This will let a tty open continue */
 	dlci->state = DLCI_OPEN;
 	if (debug & 8)
-		printk("DLCI %d goes open.\n", dlci->addr);
+		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	wake_up(&dlci->gsm->event);
 }
 
@@ -1496,29 +1502,29 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, u8 *data, int len)
 	unsigned int modem = 0;
 
 	if (debug & 16)
-		printk("%d bytes for tty %p\n", len, tty);
+		pr_debug("%d bytes for tty %p\n", len, tty);
 	if (tty) {
 		switch (dlci->adaption)  {
-			/* Unsupported types */
-			/* Packetised interruptible data */
-			case 4:
-				break;
-			/* Packetised uininterruptible voice/data */
-			case 3:
-				break;
-			/* Asynchronous serial with line state in each frame */
-			case 2:
-				while (gsm_read_ea(&modem, *data++) == 0) {
-					len--;
-					if (len == 0)
-						return;
-				}
-				gsm_process_modem(tty, dlci, modem);
-			/* Line state will go via DLCI 0 controls only */
-			case 1:
-			default:
-				tty_insert_flip_string(tty, data, len);
-				tty_flip_buffer_push(tty);
+		/* Unsupported types */
+		/* Packetised interruptible data */
+		case 4:
+			break;
+		/* Packetised uininterruptible voice/data */
+		case 3:
+			break;
+		/* Asynchronous serial with line state in each frame */
+		case 2:
+			while (gsm_read_ea(&modem, *data++) == 0) {
+				len--;
+				if (len == 0)
+					return;
+			}
+			gsm_process_modem(tty, dlci, modem);
+		/* Line state will go via DLCI 0 controls only */
+		case 1:
+		default:
+			tty_insert_flip_string(tty, data, len);
+			tty_flip_buffer_push(tty);
 		}
 		tty_kref_put(tty);
 	}
@@ -1656,7 +1662,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 	if (gsm->fcs != GOOD_FCS) {
 		gsm->bad_fcs++;
 		if (debug & 4)
-			printk("BAD FCS %02x\n", gsm->fcs);
+			pr_debug("BAD FCS %02x\n", gsm->fcs);
 		return;
 	}
 	address = gsm->address >> 1;
@@ -1890,7 +1896,7 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		gsm->state = GSM_DATA;
 		break;
 	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru ) {	/* Allow one for the FCS */
+		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
 			gsm->state = GSM_OVERRUN;
 			gsm->bad_size++;
 		} else
@@ -2085,7 +2091,7 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 		return -ENOSPC;
 	}
 	if (debug & 4) {
-		printk("-->%d bytes out\n", len);
+		pr_debug("-->%d bytes out\n", len);
 		hex_packet(data, len);
 	}
 	gsm->tty->ops->write(gsm->tty, data, len);
@@ -2142,7 +2148,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	char flags;
 
 	if (debug & 4) {
-		printk("Inbytes %dd\n", count);
+		pr_debug("Inbytes %dd\n", count);
 		hex_packet(cp, count);
 	}
 
@@ -2159,7 +2165,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			gsm->error(gsm, *dp, flags);
 			break;
 		default:
-			printk(KERN_ERR "%s: unknown flag %d\n",
+			WARN_ONCE("%s: unknown flag %d\n",
 			       tty_name(tty, buf), flags);
 			break;
 		}
@@ -2354,7 +2360,7 @@ static int gsmld_config(struct tty_struct *tty, struct gsm_mux *gsm,
 	int need_restart = 0;
 
 	/* Stuff we don't support yet - UI or I frame transport, windowing */
-	if ((c->adaption !=1 && c->adaption != 2) || c->k)
+	if ((c->adaption != 1 && c->adaption != 2) || c->k)
 		return -EOPNOTSUPP;
 	/* Check the MRU/MTU range looks sane */
 	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
@@ -2449,7 +2455,7 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 			c.i = 1;
 		else
 			c.i = 2;
-		printk("Ftype %d i %d\n", gsm->ftype, c.i);
+		pr_debug("Ftype %d i %d\n", gsm->ftype, c.i);
 		c.mru = gsm->mru;
 		c.mtu = gsm->mtu;
 		c.k = 0;
@@ -2743,14 +2749,15 @@ static int __init gsm_init(void)
 	/* Fill in our line protocol discipline, and register it */
 	int status = tty_register_ldisc(N_GSM0710, &tty_ldisc_packet);
 	if (status != 0) {
-		printk(KERN_ERR "n_gsm: can't register line discipline (err = %d)\n", status);
+		pr_err("n_gsm: can't register line discipline (err = %d)\n",
+								status);
 		return status;
 	}
 
 	gsm_tty_driver = alloc_tty_driver(256);
 	if (!gsm_tty_driver) {
 		tty_unregister_ldisc(N_GSM0710);
-		printk(KERN_ERR "gsm_init: tty allocation failed.\n");
+		pr_err("gsm_init: tty allocation failed.\n");
 		return -EINVAL;
 	}
 	gsm_tty_driver->owner	= THIS_MODULE;
@@ -2761,7 +2768,7 @@ static int __init gsm_init(void)
 	gsm_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
 	gsm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
 	gsm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV
-							| TTY_DRIVER_HARDWARE_BREAK;
+						| TTY_DRIVER_HARDWARE_BREAK;
 	gsm_tty_driver->init_termios	= tty_std_termios;
 	/* Fixme */
 	gsm_tty_driver->init_termios.c_lflag &= ~ECHO;
@@ -2772,10 +2779,11 @@ static int __init gsm_init(void)
 	if (tty_register_driver(gsm_tty_driver)) {
 		put_tty_driver(gsm_tty_driver);
 		tty_unregister_ldisc(N_GSM0710);
-		printk(KERN_ERR "gsm_init: tty registration failed.\n");
+		pr_err("gsm_init: tty registration failed.\n");
 		return -EBUSY;
 	}
-	printk(KERN_INFO "gsm_init: loaded as %d,%d.\n", gsm_tty_driver->major, gsm_tty_driver->minor_start);
+	pr_debug("gsm_init: loaded as %d,%d.\n",
+			gsm_tty_driver->major, gsm_tty_driver->minor_start);
 	return 0;
 }
 
@@ -2783,10 +2791,10 @@ static void __exit gsm_exit(void)
 {
 	int status = tty_unregister_ldisc(N_GSM0710);
 	if (status != 0)
-		printk(KERN_ERR "n_gsm: can't unregister line discipline (err = %d)\n", status);
+		pr_err("n_gsm: can't unregister line discipline (err = %d)\n",
+								status);
 	tty_unregister_driver(gsm_tty_driver);
 	put_tty_driver(gsm_tty_driver);
-	printk(KERN_INFO "gsm_init: unloaded.\n");
 }
 
 module_init(gsm_init);

