From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/efm32: parse location property
Date: Mon, 21 Jan 2013 14:22:56 +0100
Message-ID: <1358774576-13275-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50825 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab3AUNXZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jan 2013 08:23:25 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org, kernel@pengutronix.de, linux-doc@vger.kernel.org

The non-dt probing allowed passing the location via platform data from
the beginning. So make up leeway for device tree probing.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I wonder if the location property should be mandatory. Do you have an
opinion?=20

BTW, I was surprised that I had to use of_property_read_u32 but not
of_property_read_u8. I would have expected that the only difference
between those two is the returned type, but actually the format to
specify an u8 is different. Is this intended? (Probably it is. If so, i=
s
it maybe sensible to accentuate the difference by using a different
function name for the u32 case?)

Best regards
Uwe

 .../devicetree/bindings/tty/serial/efm32-uart.txt  |    6 ++++
 drivers/tty/serial/efm32-uart.c                    |   31 ++++++++++++=
+++-----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/efm32-uart.tx=
t b/Documentation/devicetree/bindings/tty/serial/efm32-uart.txt
index 6588b69..8e080b8 100644
--- a/Documentation/devicetree/bindings/tty/serial/efm32-uart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/efm32-uart.txt
@@ -5,10 +5,16 @@ Required properties:
 - reg : Address and length of the register set
 - interrupts : Should contain uart interrupt
=20
+Optional properties:
+- location : Decides the location of the USART I/O pins.
+  Allowed range : [0 .. 5]
+  Default: 0
+
 Example:
=20
 uart@0x4000c400 {
 	compatible =3D "efm32,uart";
 	reg =3D <0x4000c400 0x400>;
 	interrupts =3D <15>;
+	location =3D <0>;
 };
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index a8cbb26..67ff23b 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -81,6 +81,7 @@ struct efm32_uart_port {
 	struct uart_port port;
 	unsigned int txirq;
 	struct clk *clk;
+	struct efm32_uart_pdata pdata;
 };
 #define to_efm_port(_port) container_of(_port, struct efm32_uart_port,=
 port)
 #define efm_debug(efm_port, format, arg...)			\
@@ -300,13 +301,8 @@ static irqreturn_t efm32_uart_txirq(int irq, void =
*data)
 static int efm32_uart_startup(struct uart_port *port)
 {
 	struct efm32_uart_port *efm_port =3D to_efm_port(port);
-	u32 location =3D 0;
-	struct efm32_uart_pdata *pdata =3D dev_get_platdata(port->dev);
 	int ret;
=20
-	if (pdata)
-		location =3D UARTn_ROUTE_LOCATION(pdata->location);
-
 	ret =3D clk_enable(efm_port->clk);
 	if (ret) {
 		efm_debug(efm_port, "failed to enable clk\n");
@@ -315,7 +311,9 @@ static int efm32_uart_startup(struct uart_port *por=
t)
 	port->uartclk =3D clk_get_rate(efm_port->clk);
=20
 	/* Enable pins at configured location */
-	efm32_uart_write32(efm_port, location | UARTn_ROUTE_RXPEN | UARTn_ROU=
TE_TXPEN,
+	efm32_uart_write32(efm_port,
+			UARTn_ROUTE_LOCATION(efm_port->pdata.location) |
+			UARTn_ROUTE_RXPEN | UARTn_ROUTE_TXPEN,
 			UARTn_ROUTE);
=20
 	ret =3D request_irq(port->irq, efm32_uart_rxirq, 0,
@@ -674,11 +672,24 @@ static int efm32_uart_probe_dt(struct platform_de=
vice *pdev,
 		struct efm32_uart_port *efm_port)
 {
 	struct device_node *np =3D pdev->dev.of_node;
+	u32 location;
 	int ret;
=20
 	if (!np)
 		return 1;
=20
+	ret =3D of_property_read_u32(np, "location", &location);
+	if (!ret) {
+		if (location > 5) {
+			dev_err(&pdev->dev, "invalid location\n");
+			return -EINVAL;
+		}
+		efm_debug(efm_port, "using location %u\n", location);
+		efm_port->pdata.location =3D location;
+	} else {
+		efm_debug(efm_port, "fall back to location 0\n");
+	}
+
 	ret =3D of_alias_get_id(np, "serial");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
@@ -738,10 +749,16 @@ static int efm32_uart_probe(struct platform_devic=
e *pdev)
 	efm_port->port.flags =3D UPF_BOOT_AUTOCONF;
=20
 	ret =3D efm32_uart_probe_dt(pdev, efm_port);
-	if (ret > 0)
+	if (ret > 0) {
 		/* not created by device tree */
+		const struct efm32_uart_pdata *pdata =3D dev_get_platdata(&pdev->dev=
);
+
 		efm_port->port.line =3D pdev->id;
=20
+		if (pdata)
+			efm_port->pdata =3D *pdata;
+	}
+
 	if (efm_port->port.line >=3D 0 &&
 			efm_port->port.line < ARRAY_SIZE(efm32_uart_ports))
 		efm32_uart_ports[efm_port->port.line] =3D efm_port;
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
