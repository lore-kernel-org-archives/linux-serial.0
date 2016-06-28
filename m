From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH] serial: 8250_fintek: Fix potential NULL pointer dereference
Date: Tue, 28 Jun 2016 09:46:30 +0800
Message-ID: <1467078390-2406-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: alan@linux.intel.com, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fix potential NULL pointer dereference on
'commit 4da22f1418cb ("serial: 8250_fintek: fix the mismatched IRQ mode")'

We try to fix IRQ mode mismatch issue and add the following code to
detect IRQ Level or Edge mode.

struct irq_data *irq_data = irq_get_irq_data(uart->port.irq);
bool level_mode = irqd_is_level_type(irq_data);

But *irq_data had not any check and pass to irqd_is_level_type(),
it may lead to potential NULL pointer dereference.

Also modify detecting IRQ mode when fintek chip found.

Suggested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 737b4b3..9119d0c 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -212,8 +212,8 @@ int fintek_8250_probe(struct uart_8250_port *uart)
 {
 	struct fintek_8250 *pdata;
 	struct fintek_8250 probe_data;
-	struct irq_data *irq_data = irq_get_irq_data(uart->port.irq);
-	bool level_mode = irqd_is_level_type(irq_data);
+	struct irq_data *irq_data;
+	bool level_mode = false; /* Default to Edge/High */
 
 	if (find_base_port(&probe_data, uart->port.iobase))
 		return -ENODEV;
@@ -226,5 +226,14 @@ int fintek_8250_probe(struct uart_8250_port *uart)
 	uart->port.rs485_config = fintek_8250_rs485_config;
 	uart->port.private_data = pdata;
 
+	irq_data = irq_get_irq_data(uart->port.irq);
+	if (irq_data) {
+		level_mode = irqd_is_level_type(irq_data);
+	} else {
+		dev_warn(uart->port.dev,
+			 "%s: Can't get irq_data, set this port to Edge/High",
+			 __func__);
+	}
+
 	return fintek_8250_set_irq_mode(pdata, level_mode);
 }
-- 
1.9.1
