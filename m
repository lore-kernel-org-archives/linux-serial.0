From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH] serial: 8250_fintek: fix the mismatched IRQ mode
Date: Fri, 27 May 2016 10:02:51 +0800
Message-ID: <1464314571-15429-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: ricardo.ribalda@gmail.com, alan@linux.intel.com, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Some BIOS only use _OSI("Linux") to distinguish between Linux & Windows=
=2E
Apply Level/Low to UART trigger mode if Windows, Edge/High mode otherwi=
se.
But since 2.6.23 the mainline kernel no longer returns true for
_OSI(=E2=80=9CLinux=E2=80=9D).

The default IRQ0~15 trigger mode in Linux is Edge/High mode without
ACPI MADT override. It mismatches IRQ mode and makes UART malfunctional=
 on
such motherboard.

This patch will check the current IRQ mode and apply correct mode to UA=
RT.

The following link is F81216AD spec PDF:
http://html.alldatasheet.com/html-pdf/257956/FINTEK/F81216AD/5569/
25/F81216AD.html

LDN0~3
	70h: IRQ channel & Mode register
		Bit 6~5	:
			00	: Active low level mode
			01	: Active high edge mode
		Bit 4	: Sharing Flag (0: not share/1: share)
		Bit 3~0 : IRQ channel

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 36 +++++++++++++++++++++++++++=
+++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial=
/8250/8250_fintek.c
index 870981d..737b4b3 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -13,6 +13,7 @@
 #include <linux/pnp.h>
 #include <linux/kernel.h>
 #include <linux/serial_core.h>
+#include <linux/irq.h>
 #include  "8250.h"
=20
 #define ADDR_PORT 0
@@ -30,6 +31,12 @@
 #define IO_ADDR2 0x60
 #define LDN 0x7
=20
+#define IRQ_MODE	0x70
+#define IRQ_SHARE	BIT(4)
+#define IRQ_MODE_MASK	(BIT(6) | BIT(5))
+#define IRQ_LEVEL_LOW	0
+#define IRQ_EDGE_HIGH	BIT(5)
+
 #define RS485  0xF0
 #define RTS_INVERT BIT(5)
 #define RS485_URA BIT(4)
@@ -176,10 +183,37 @@ static int find_base_port(struct fintek_8250 *pda=
ta, u16 io_address)
 	return -ENODEV;
 }
=20
+static int fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool le=
vel_mode)
+{
+	int status;
+	u8 tmp;
+
+	status =3D fintek_8250_enter_key(pdata->base_port, pdata->key);
+	if (status)
+		return status;
+
+	outb(LDN, pdata->base_port + ADDR_PORT);
+	outb(pdata->index, pdata->base_port + DATA_PORT);
+
+	outb(IRQ_MODE, pdata->base_port + ADDR_PORT);
+	tmp =3D inb(pdata->base_port + DATA_PORT);
+
+	tmp &=3D ~IRQ_MODE_MASK;
+	tmp |=3D IRQ_SHARE;
+	if (!level_mode)
+		tmp |=3D IRQ_EDGE_HIGH;
+
+	outb(tmp, pdata->base_port + DATA_PORT);
+	fintek_8250_exit_key(pdata->base_port);
+	return 0;
+}
+
 int fintek_8250_probe(struct uart_8250_port *uart)
 {
 	struct fintek_8250 *pdata;
 	struct fintek_8250 probe_data;
+	struct irq_data *irq_data =3D irq_get_irq_data(uart->port.irq);
+	bool level_mode =3D irqd_is_level_type(irq_data);
=20
 	if (find_base_port(&probe_data, uart->port.iobase))
 		return -ENODEV;
@@ -192,5 +226,5 @@ int fintek_8250_probe(struct uart_8250_port *uart)
 	uart->port.rs485_config =3D fintek_8250_rs485_config;
 	uart->port.private_data =3D pdata;
=20
-	return 0;
+	return fintek_8250_set_irq_mode(pdata, level_mode);
 }
--=20
1.9.1
