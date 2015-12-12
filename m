From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH v9 2/3] serial: 8250_dw: Add support for big-endian MMIO accesses
Date: Sat, 12 Dec 2015 19:18:26 +0200
Message-ID: <1449940707-17633-3-git-send-email-noamc@ezchip.com>
References: <1449940707-17633-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449940707-17633-1-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, vgupta@synopsys.com, Alexey.Brodkin@synopsys.com, jslaby@suse.com, peter@hurleysoftware.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

Add support for UPIO_MEM32BE in addition to UPIO_MEM32.

For big endian we use 2 new accessors similar to little endian,
called dw8250_serial_out32be() and dw8250_serial_in32be().

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 drivers/tty/serial/8250/8250_dw.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ffe5e0c..92c4a9b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -182,6 +182,24 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 	return dw8250_modify_msr(p, offset, value);
 }
 
+static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
+{
+	struct dw8250_data *d = p->private_data;
+
+	iowrite32be(value, p->membase + (offset << p->regshift));
+
+	if (offset == UART_LCR && !d->uart_16550_compatible)
+		dw8250_check_lcr(p, value);
+}
+
+static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
+{
+       unsigned int value = ioread32be(p->membase + (offset << p->regshift));
+
+       return dw8250_modify_msr(p, offset, value);
+}
+
+
 static int dw8250_handle_irq(struct uart_port *p)
 {
 	struct dw8250_data *d = p->private_data;
@@ -276,6 +294,11 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 			data->skip_autocfg = true;
 		}
 #endif
+		if (of_device_is_big_endian(p->dev->of_node)) {
+			p->iotype = UPIO_MEM32BE;
+			p->serial_in = dw8250_serial_in32be;
+			p->serial_out = dw8250_serial_out32be;
+		}
 	} else if (has_acpi_companion(p->dev)) {
 		p->iotype = UPIO_MEM32;
 		p->regshift = 2;
-- 
1.7.1
