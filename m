From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v6 10/15] tty: serial: 8250: Suitably replace printk
Date: Wed, 13 Jan 2016 22:29:16 +0100
Message-ID: <1452720561-28443-11-git-send-email-anton.wuerfel@fau.de>
References: <1452720561-28443-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452720561-28443-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Anton=20W=C3=BCrfel?= <anton.wuerfel@fau.de>
List-Id: linux-serial@vger.kernel.org

=46rom: Phillip Raffeck <phillip.raffeck@fau.de>

This patch replaces printk by the corresponding variant of dev_* in ord=
er
to fix checkpatch warnings. If no suitable device pointer is present, t=
he
corresponding pr_* variant is used.

Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_core.c  |  5 ++---
 drivers/tty/serial/8250/8250_gsc.c   |  7 ++++---
 drivers/tty/serial/8250/8250_hp300.c | 20 +++++++++++---------
 drivers/tty/serial/8250/8250_port.c  |  3 +--
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index b60b58b..d6b4906 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1094,9 +1094,8 @@ static int __init serial8250_init(void)
=20
 	serial8250_isa_init_ports();
=20
-	printk(KERN_INFO "Serial: 8250/16550 driver, "
-		"%d ports, IRQ sharing %sabled\n", nr_uarts,
-		share_irqs ? "en" : "dis");
+	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %sabled\n",
+		nr_uarts, share_irqs ? "en" : "dis");
=20
 #ifdef CONFIG_SPARC
 	ret =3D sunserial_register_minors(&serial8250_reg, UART_NR);
diff --git a/drivers/tty/serial/8250/8250_gsc.c b/drivers/tty/serial/82=
50/8250_gsc.c
index 2e3ea1a..b1e6ae9 100644
--- a/drivers/tty/serial/8250/8250_gsc.c
+++ b/drivers/tty/serial/8250/8250_gsc.c
@@ -42,7 +42,7 @@ static int __init serial_init_chip(struct parisc_devi=
ce *dev)
 		 * the user what they're missing.
 		 */
 		if (parisc_parent(dev)->id.hw_type !=3D HPHW_IOA)
-			printk(KERN_INFO
+			dev_info(&dev->dev,
 				"Serial: device 0x%llx not configured.\n"
 				"Enable support for Wax, Lasi, Asp or Dino.\n",
 				(unsigned long long)dev->hpa.start);
@@ -66,8 +66,9 @@ static int __init serial_init_chip(struct parisc_devi=
ce *dev)
=20
 	err =3D serial8250_register_8250_port(&uart);
 	if (err < 0) {
-		printk(KERN_WARNING
-			"serial8250_register_8250_port returned error %d\n", err);
+		dev_warn(&dev->dev,
+			"serial8250_register_8250_port returned error %d\n",
+			err);
 		iounmap(uart.port.membase);
 		return err;
 	}
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/=
8250/8250_hp300.c
index cf566bb..38166db 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -110,7 +110,7 @@ int __init hp300_setup_serial_console(void)
 	/* Check for APCI console */
 	if (scode =3D=3D 256) {
 #ifdef CONFIG_HPAPCI
-		printk(KERN_INFO "Serial console is HP APCI 1\n");
+		pr_info("Serial console is HP APCI 1\n");
=20
 		port.uartclk =3D HPAPCI_BAUD_BASE * 16;
 		port.mapbase =3D (FRODO_BASE + FRODO_APCI_OFFSET(1));
@@ -118,7 +118,7 @@ int __init hp300_setup_serial_console(void)
 		port.regshift =3D 2;
 		add_preferred_console("ttyS", port.line, "9600n8");
 #else
-		printk(KERN_WARNING "Serial console is APCI but support is disabled =
(CONFIG_HPAPCI)!\n");
+		pr_warn("Serial console is APCI but support is disabled (CONFIG_HPAP=
CI)!\n");
 		return 0;
 #endif
 	} else {
@@ -127,7 +127,7 @@ int __init hp300_setup_serial_console(void)
 		if (!pa)
 			return 0;
=20
-		printk(KERN_INFO "Serial console is HP DCA at select code %d\n", sco=
de);
+		pr_info("Serial console is HP DCA at select code %d\n", scode);
=20
 		port.uartclk =3D HPDCA_BAUD_BASE * 16;
 		port.mapbase =3D (pa + UART_OFFSET);
@@ -141,13 +141,13 @@ int __init hp300_setup_serial_console(void)
 		if (DIO_ID(pa + DIO_VIRADDRBASE) & 0x80)
 			add_preferred_console("ttyS", port.line, "9600n8");
 #else
-		printk(KERN_WARNING "Serial console is DCA but support is disabled (=
CONFIG_HPDCA)!\n");
+		pr_warn("Serial console is DCA but support is disabled (CONFIG_HPDCA=
)!\n");
 		return 0;
 #endif
 	}
=20
 	if (early_serial_setup(&port) < 0)
-		printk(KERN_WARNING "hp300_setup_serial_console(): early_serial_setu=
p() failed.\n");
+		pr_warn("%s: early_serial_setup() failed.\n", __func__);
 	return 0;
 }
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
@@ -179,8 +179,9 @@ static int hpdca_init_one(struct dio_dev *d,
 	line =3D serial8250_register_8250_port(&uart);
=20
 	if (line < 0) {
-		printk(KERN_NOTICE "8250_hp300: register_serial() DCA scode %d"
-		       " irq %d failed\n", d->scode, uart.port.irq);
+		dev_notice(&d->dev,
+			  "8250_hp300: register_serial() DCA scode %d irq %d failed\n",
+			  d->scode, uart.port.irq);
 		return -ENOMEM;
 	}
=20
@@ -260,8 +261,9 @@ static int __init hp300_8250_init(void)
 		line =3D serial8250_register_8250_port(&uart);
=20
 		if (line < 0) {
-			printk(KERN_NOTICE "8250_hp300: register_serial() APCI"
-			       " %d irq %d failed\n", i, uart.port.irq);
+			dev_notice(uart.port.dev,
+				   "8250_hp300: register_serial() APCI %d irq %d failed\n",
+				   i, uart.port.irq);
 			kfree(port);
 			continue;
 		}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index 5375c24..25fd6b4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1222,8 +1222,7 @@ static void autoconfig(struct uart_8250_port *up)
 out_lock:
 	spin_unlock_irqrestore(&port->lock, flags);
 	if (up->capabilities !=3D old_capabilities) {
-		printk(KERN_WARNING
-		       "ttyS%d: detected caps %08x should be %08x\n",
+		pr_warn("ttyS%d: detected caps %08x should be %08x\n",
 		       serial_index(port), old_capabilities,
 		       up->capabilities);
 	}
--=20
1.9.1
