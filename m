From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 11/11] serial: 8250_omap: Add omap8250 earlycon
Date: Tue, 12 Jan 2016 11:41:12 -0800
Message-ID: <1452627672-9482-12-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>, Peter Hurley <peter@hurleysoftware.com>
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
 drivers/tty/serial/8250/8250_early.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index e7cdc0c..d1f6310 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -201,3 +201,23 @@ EARLYCON_DECLARE(rt288x, early_rt288x_setup);
 OF_EARLYCON_DECLARE(rt288x, "ralink,rt2880-uart", early_rt288x_setup);
 
 #endif /* CONFIG_SERIAL_8250_RT288X */
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
+#endif
-- 
2.7.0
