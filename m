From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] serial: 8250_uniphier: remove unused "fifo-size" property
Date: Wed, 19 Sep 2018 14:28:11 +0900
Message-ID: <1537334893-26079-2-git-send-email-yamada.masahiro@socionext.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dai Okamura <okamura.dai@socionext.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The FIFO size of the UART devices is 64 on almost all UniPhier SoCs
with the exception Pro4TV SoC (MN2WS0230), which used 128 FIFO size.
However, Pro4TV SoC was never upstreamed, and out of production.

So, this property has never been used in a useful way.
Let's remove old unused code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/devicetree/bindings/serial/uniphier-uart.txt |  4 ----
 drivers/tty/serial/8250/8250_uniphier.c                    | 10 +---------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/uniphier-uart.txt b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
index 0b3892a..811c479 100644
--- a/Documentation/devicetree/bindings/serial/uniphier-uart.txt
+++ b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
@@ -6,9 +6,6 @@ Required properties:
 - interrupts: a single interrupt specifier.
 - clocks: phandle to the input clock.
 
-Optional properties:
-- fifo-size: the RX/TX FIFO size.  Defaults to 64 if not specified.
-
 Example:
 	aliases {
 		serial0 = &serial0;
@@ -19,5 +16,4 @@ Example:
 		reg = <0x54006800 0x40>;
 		interrupts = <0 33 4>;
 		clocks = <&uart_clk>;
-		fifo-size = <64>;
 	};
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 28d88ccf..d292654 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -12,9 +12,6 @@
 
 #include "8250.h"
 
-/* Most (but not all) of UniPhier UART devices have 64-depth FIFO. */
-#define UNIPHIER_UART_DEFAULT_FIFO_SIZE	64
-
 /*
  * This hardware is similar to 8250, but its register map is a bit different:
  *   - MMIO32 (regshift = 2)
@@ -185,12 +182,6 @@ static int uniphier_of_serial_setup(struct device *dev, struct uart_port *port,
 
 	port->uartclk = clk_get_rate(priv->clk);
 
-	/* Check for fifo size */
-	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
-		port->fifosize = prop;
-	else
-		port->fifosize = UNIPHIER_UART_DEFAULT_FIFO_SIZE;
-
 	return 0;
 }
 
@@ -241,6 +232,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	up.port.type = PORT_16550A;
 	up.port.iotype = UPIO_MEM32;
+	up.port.fifosize = 64;
 	up.port.regshift = UNIPHIER_UART_REGSHIFT;
 	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	up.capabilities = UART_CAP_FIFO;
-- 
2.7.4
