From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 10/11] tty: serial: 8250: Replace printk by pr_*
Date: Wed, 16 Dec 2015 16:36:16 +0100
Message-ID: <1450280177-4460-11-git-send-email-anton.wuerfel@fau.de>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anto>
List-Id: linux-serial@vger.kernel.org

This patch replaces printk by the corresponding variant of pr_* in orde=
r to
fix checkpatch warnings.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
CC: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_core.c  |  5 ++---
 drivers/tty/serial/8250/8250_gsc.c   |  6 ++----
 drivers/tty/serial/8250/8250_hp300.c | 14 +++++++-------
 drivers/tty/serial/8250/8250_pnp.c   |  6 +++---
 drivers/tty/serial/8250/8250_port.c  |  3 +--
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index 2b3731f..b5e0c48 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1095,9 +1095,8 @@ static int __init serial8250_init(void)
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
index 2e3ea1a..a9b63d0 100644
--- a/drivers/tty/serial/8250/8250_gsc.c
+++ b/drivers/tty/serial/8250/8250_gsc.c
@@ -42,8 +42,7 @@ static int __init serial_init_chip(struct parisc_devi=
ce *dev)
 		 * the user what they're missing.
 		 */
 		if (parisc_parent(dev)->id.hw_type !=3D HPHW_IOA)
-			printk(KERN_INFO
-				"Serial: device 0x%llx not configured.\n"
+			pr_info("Serial: device 0x%llx not configured.\n"
 				"Enable support for Wax, Lasi, Asp or Dino.\n",
 				(unsigned long long)dev->hpa.start);
 		return -ENODEV;
@@ -66,8 +65,7 @@ static int __init serial_init_chip(struct parisc_devi=
ce *dev)
=20
 	err =3D serial8250_register_8250_port(&uart);
 	if (err < 0) {
-		printk(KERN_WARNING
-			"serial8250_register_8250_port returned error %d\n", err);
+		pr_warn("serial8250_register_8250_port returned error %d\n", err);
 		iounmap(uart.port.membase);
 		return err;
 	}
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/=
8250/8250_hp300.c
index 52c43da..85b574896 100644
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
@@ -128,7 +128,7 @@ int __init hp300_setup_serial_console(void)
 		if (!pa)
 			return 0;
=20
-		printk(KERN_INFO "Serial console is HP DCA at select code %d\n", sco=
de);
+		pr_info("Serial console is HP DCA at select code %d\n", scode);
=20
 		port.uartclk =3D HPDCA_BAUD_BASE * 16;
 		port.mapbase =3D (pa + UART_OFFSET);
@@ -142,13 +142,13 @@ int __init hp300_setup_serial_console(void)
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
+		pr_warn("hp300_setup_serial_console(): early_serial_setup() failed.\=
n");
 	return 0;
 }
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
@@ -180,7 +180,7 @@ static int hpdca_init_one(struct dio_dev *d,
 	line =3D serial8250_register_8250_port(&uart);
=20
 	if (line < 0) {
-		printk(KERN_NOTICE "8250_hp300: register_serial() DCA scode %d"
+		pr_notice("8250_hp300: register_serial() DCA scode %d"
 		       " irq %d failed\n", d->scode, uart.port.irq);
 		return -ENOMEM;
 	}
@@ -261,7 +261,7 @@ static int __init hp300_8250_init(void)
 		line =3D serial8250_register_8250_port(&uart);
=20
 		if (line < 0) {
-			printk(KERN_NOTICE "8250_hp300: register_serial() APCI"
+			pr_notice("8250_hp300: register_serial() APCI"
 			       " %d irq %d failed\n", i, uart.port.irq);
 			kfree(port);
 			continue;
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/82=
50/8250_pnp.c
index 2731031..3811c67 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -465,9 +465,9 @@ serial_pnp_probe(struct pnp_dev *dev, const struct =
pnp_device_id *dev_id)
 		return -ENODEV;
=20
 #ifdef SERIAL_DEBUG_PNP
-	printk(KERN_DEBUG
-		"Setup PNP port: port %x, mem 0x%lx, irq %d, type %d\n",
-		       uart.port.iobase, uart.port.mapbase, uart.port.irq, uart.port=
=2Eiotype);
+	pr_debug("Setup PNP port: port %x, mem 0x%lx, irq %d, type %d\n",
+		 uart.port.iobase, uart.port.mapbase,
+		 uart.port.irq, uart.port.iotype);
 #endif
 	if (flags & CIR_PORT) {
 		uart.port.flags |=3D UPF_FIXED_PORT | UPF_FIXED_TYPE;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index 0ec823e..1b2aaf9 100644
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
