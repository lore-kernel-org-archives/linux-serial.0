From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] TTY: serial, handle platform_get_irq retval properly
Date: Thu, 31 Mar 2016 10:23:33 +0200
Message-ID: <1459412614-4549-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <kernel@pengutronix.de>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

platform_get_irq:
* can fail =3D> handle negative value
* can return 0 as irq number, change '<=3D 0' checks accordingly
* returns int =3D> when converted to uint (e.g. uart_port->irq),
  '< 0' would not work on that, do '< 0' on the int instead
* '!retval' does not mean bad irq, 'retval < 0' does

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: "Uwe Kleine-K=C3=B6nig" <kernel@pengutronix.de>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c    | 8 +++++++-
 drivers/tty/serial/efm32-uart.c    | 4 ++--
 drivers/tty/serial/fsl_lpuart.c    | 8 +++++++-
 drivers/tty/serial/pmac_zilog.c    | 2 +-
 drivers/tty/serial/serial-tegra.c  | 7 ++++++-
 drivers/tty/serial/uartlite.c      | 2 +-
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 7 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
index 7c198e0a3178..59f31073e746 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2552,11 +2552,17 @@ static int sbsa_uart_probe(struct platform_devi=
ce *pdev)
 	if (!uap)
 		return -ENOMEM;
=20
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	uap->port.irq	=3D ret;
+
 	uap->reg_offset	=3D vendor_sbsa.reg_offset;
 	uap->vendor	=3D &vendor_sbsa;
 	uap->fifosize	=3D 32;
 	uap->port.iotype =3D vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
-	uap->port.irq	=3D platform_get_irq(pdev, 0);
 	uap->port.ops	=3D &sbsa_uart_pops;
 	uap->fixed_baud =3D baudrate;
=20
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32=
-uart.c
index 195acc868763..efadba355a20 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -724,7 +724,7 @@ static int efm32_uart_probe(struct platform_device =
*pdev)
 	}
=20
 	ret =3D platform_get_irq(pdev, 0);
-	if (ret <=3D 0) {
+	if (ret < 0) {
 		dev_dbg(&pdev->dev, "failed to get rx irq\n");
 		goto err_get_rxirq;
 	}
@@ -732,7 +732,7 @@ static int efm32_uart_probe(struct platform_device =
*pdev)
 	efm_port->port.irq =3D ret;
=20
 	ret =3D platform_get_irq(pdev, 1);
-	if (ret <=3D 0)
+	if (ret < 0)
 		ret =3D efm_port->port.irq + 1;
=20
 	efm_port->txirq =3D ret;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_l=
puart.c
index 3d790033744e..7f95f782a485 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1830,7 +1830,13 @@ static int lpuart_probe(struct platform_device *=
pdev)
 	sport->port.dev =3D &pdev->dev;
 	sport->port.type =3D PORT_LPUART;
 	sport->port.iotype =3D UPIO_MEM;
-	sport->port.irq =3D platform_get_irq(pdev, 0);
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	sport->port.irq =3D ret;
+
 	if (sport->lpuart32)
 		sport->port.ops =3D &lpuart32_pops;
 	else
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_=
zilog.c
index e156e39d620c..0f086a2559ff 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1720,7 +1720,7 @@ static int __init pmz_init_port(struct uart_pmac_=
port *uap)
=20
 	r_ports =3D platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
 	irq =3D platform_get_irq(uap->pdev, 0);
-	if (!r_ports || !irq)
+	if (!r_ports || irq < 0)
 		return -ENODEV;
=20
 	uap->port.mapbase  =3D r_ports->start;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/ser=
ial-tegra.c
index 5dde7ed3950a..11e64624dcdc 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1312,7 +1312,12 @@ static int tegra_uart_probe(struct platform_devi=
ce *pdev)
 	}
=20
 	u->iotype =3D UPIO_MEM32;
-	u->irq =3D platform_get_irq(pdev, 0);
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't get IRQ\n");
+		return ret;
+	}
+	u->irq =3D ret;
 	u->regshift =3D 2;
 	ret =3D uart_add_one_port(&tegra_uart_driver, u);
 	if (ret < 0) {
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlit=
e.c
index c9fdfc8bf47f..0e4e398c66c0 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -693,7 +693,7 @@ static int ulite_probe(struct platform_device *pdev=
)
 		return -ENODEV;
=20
 	irq =3D platform_get_irq(pdev, 0);
-	if (irq <=3D 0)
+	if (irq < 0)
 		return -ENXIO;
=20
 	return ulite_assign(&pdev->dev, id, res->start, irq);
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xi=
linx_uartps.c
index cd46e64c4255..34a705b15a4f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1368,7 +1368,7 @@ static int cdns_uart_probe(struct platform_device=
 *pdev)
 	}
=20
 	irq =3D platform_get_irq(pdev, 0);
-	if (irq <=3D 0) {
+	if (irq < 0) {
 		rc =3D -ENXIO;
 		goto err_out_clk_disable;
 	}
--=20
2.7.4
