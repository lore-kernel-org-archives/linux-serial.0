From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] serial: 8250_ingenic: Parse earlycon options
Date: Thu, 28 Dec 2017 14:07:09 +0100
Message-ID: <20171228130709.12457-4-paul@crapouillou.net>
References: <20171228130709.12457-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228130709.12457-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-serial@vger.kernel.org

In the devicetree, it is possible to specify the baudrate, parity,
bits, flow of the early console, by passing a configuration string like
this:

aliases {
	serial0 = &uart0;
};

chosen {
	stdout-path = "serial0:57600n8";
};

This, for instance, will configure the early console for a baudrate of
57600 bps, no parity, and 8 bits per baud.

This patches implements parsing of this configuration string in the
8250_ingenic driver, which previously just ignored it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/tty/serial/8250/8250_ingenic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

 v1: Initial version

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 165b4bb3de93..15a8c8dfa92b 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -91,14 +91,22 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 					      const char *opt)
 {
 	struct uart_port *port = &dev->port;
-	unsigned int baud, divisor;
+	unsigned int divisor;
+	int baud = 115200;
 
 	if (!dev->port.membase)
 		return -ENODEV;
 
+	if (opt) {
+		unsigned int parity, bits, flow; /* unused for now */
+
+		uart_parse_options(opt, &baud, &parity, &bits, &flow);
+	}
+
 	ingenic_early_console_setup_clock(dev);
 
-	baud = dev->baud ?: 115200;
+	if (dev->baud)
+		baud = dev->baud;
 	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
 
 	early_out(port, UART_IER, 0);
-- 
2.15.1
