From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6 12/12] serial: 8250_omap: Add omap8250 earlycon
Date: Sat, 16 Jan 2016 15:23:49 -0800
Message-ID: <1452986629-17210-13-git-send-email-peter@hurleysoftware.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Add DT earlycon for 8250_omap driver. This boot console is included
for kernels built with CONFIG_SERIAL_EARLYCON=y, CONFIG_OF=y,
CONFIG_SERIAL_8250_OMAP=y, and CONFIG_OF_EARLY_FLATTREE=y.

This boot console is enabled with the command line option "earlycon"
(without "=<name>...") when the DT 'stdout-path' property matches a
compatible uart. For example,

/ {
   chosen {
        stdout-path = "serial0:115200";
   };

   ....

   aliases {
        serial0 = &uart0;
   };

   ....

   ocp : ocp {
        uart0 : serial@44e09000 {
             compatible = "ti,omap3-uart";
        }
   };
};

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_early.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 180143c..3b3dbdc 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -149,3 +149,24 @@ EARLYCON_DECLARE(uart8250, early_serial8250_setup);
 EARLYCON_DECLARE(uart, early_serial8250_setup);
 OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
 OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
+
+#ifdef CONFIG_SERIAL_8250_OMAP
+
+static int __init early_omap8250_setup(struct earlycon_device *device,
+				       const char *options)
+{
+	struct uart_port *port = &device->port;
+
+	if (!(device->port.membase || device->port.iobase))
+		return -ENODEV;
+
+	port->regshift = 2;
+	device->con->write = early_serial8250_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
+
+#endif
-- 
2.7.0
