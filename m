From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Subject: RE: [PATCH 1/4] serial: imx: Fix the reporting of interrupts
Date: Tue, 28 Oct 2014 02:10:36 +0000
Message-ID: <8e4a991e46474daa8bc40b96e8042ef2@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bl2on0114.outbound.protection.outlook.com ([65.55.169.114]:15669
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752297AbaJ1CZk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 22:25:40 -0400
In-Reply-To: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com> Sent: Tuesday, October 28, 2014 12:50 AM
>To: gregkh@linuxfoundation.org
>Cc: shawn.guo@linaro.org; kernel@pengutronix.de; Duan Fugang-B38611;
>festevam@gmail.com; linux-serial@vger.kernel.org; Estevam Fabio-R49496
>Subject: [PATCH 1/4] serial: imx: Fix the reporting of interrupts
>
>On a imx system with ttymxc0, ttymxc1 and ttymxc4 registered we see the
>following output from 'cat /proc/interrupts':
>
>$ cat /proc/interrupts
>           CPU0
>...
> 58:         39       GIC  58  2020000.serial
> 67:        115       GIC  67  21f8000.i2c
>
>The only uart irq that appears is ttymxc0, which is the console.
>
>As ttymxc1 and ttymxc4 will only have their irq registered at
>imx_startup(), they are not shown right after probe.
>
>Transmitting to ttymxc1 and ttymxc4 will cause their irqs to be registered,
>but the output shows:
>
>$ echo "111111" > /dev/ttymxc1
>$ echo "444444" > /dev/ttymxc4
>$ cat /proc/interrupts
>           CPU0
>...
> 58:        150       GIC  58  2020000.serial
> 59:          1       GIC  59
> 62:          1       GIC  62
> 67:        115       GIC  67  21f8000.i2c
>
>,which misses printing the associated device address.
>
>In order to fix this, register all the irqs inside the probe function via
>devm_request_irq(), which will correctly report the serial interrupts
>associated with their correspondent serial device and also helps
>simplyfing the code by avoiding the calls to free_irq().
>
>$ echo "111111" > /dev/ttymxc1
>$ echo "444444" > /dev/ttymxc4
>$ cat /proc/interrupts
>
>	   CPU0
>....
> 58:        202       GIC  58  2020000.serial
> 59:          1       GIC  59  21e8000.serial
> 62:          1       GIC  62  21f4000.serial
> 67:        115       GIC  67  21f8000.i2c
>
>Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>---
> drivers/tty/serial/imx.c | 78 +++++++++++++++++++------------------------
>-----
> 1 file changed, 30 insertions(+), 48 deletions(-)
>
>diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
>8f62a3c..e4a2846 100644
>--- a/drivers/tty/serial/imx.c
>+++ b/drivers/tty/serial/imx.c
>@@ -1109,37 +1109,6 @@ static int imx_startup(struct uart_port *port)
> 	while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) && (--i > 0))
> 		udelay(1);
>
>-	/*
>-	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
>-	 * chips only have one interrupt.
>-	 */
>-	if (sport->txirq > 0) {
>-		retval = request_irq(sport->rxirq, imx_rxint, 0,
>-				     dev_name(port->dev), sport);
>-		if (retval)
>-			goto error_out1;
>-
>-		retval = request_irq(sport->txirq, imx_txint, 0,
>-				     dev_name(port->dev), sport);
>-		if (retval)
>-			goto error_out2;
>-
>-		/* do not use RTS IRQ on IrDA */
>-		if (!USE_IRDA(sport)) {
>-			retval = request_irq(sport->rtsirq, imx_rtsint, 0,
>-					     dev_name(port->dev), sport);
>-			if (retval)
>-				goto error_out3;
>-		}
>-	} else {
>-		retval = request_irq(sport->port.irq, imx_int, 0,
>-				     dev_name(port->dev), sport);
>-		if (retval) {
>-			free_irq(sport->port.irq, sport);
>-			goto error_out1;
>-		}
>-	}
>-
> 	spin_lock_irqsave(&sport->port.lock, flags);
> 	/*
> 	 * Finally, clear and enable interrupts @@ -1202,12 +1171,6 @@
>static int imx_startup(struct uart_port *port)
>
> 	return 0;
>
>-error_out3:
>-	if (sport->txirq)
>-		free_irq(sport->txirq, sport);
>-error_out2:
>-	if (sport->rxirq)
>-		free_irq(sport->rxirq, sport);
> error_out1:
> 	return retval;
> }
>@@ -1255,17 +1218,6 @@ static void imx_shutdown(struct uart_port *port)
> 	del_timer_sync(&sport->timer);
>
> 	/*
>-	 * Free the interrupts
>-	 */
>-	if (sport->txirq > 0) {
>-		if (!USE_IRDA(sport))
>-			free_irq(sport->rtsirq, sport);
>-		free_irq(sport->txirq, sport);
>-		free_irq(sport->rxirq, sport);
>-	} else
>-		free_irq(sport->port.irq, sport);
>-
>-	/*
> 	 * Disable all interrupts, port and break condition.
> 	 */
>
>@@ -1929,6 +1881,36 @@ static int serial_imx_probe(struct platform_device
>*pdev)
>
> 	sport->port.uartclk = clk_get_rate(sport->clk_per);
>
>+	/*
>+	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
>+	 * chips only have one interrupt.
>+	 */
>+	if (sport->txirq > 0) {
>+		ret = devm_request_irq(&pdev->dev, sport->rxirq, imx_rxint, 0,
>+				       dev_name(&pdev->dev), sport);
>+		if (ret)
>+			return ret;
>+
>+		ret = devm_request_irq(&pdev->dev, sport->txirq, imx_txint, 0,
>+				       dev_name(&pdev->dev), sport);
>+		if (ret)
>+			return ret;
>+
>+		/* do not use RTS IRQ on IrDA */
>+		if (!USE_IRDA(sport)) {
>+			ret = devm_request_irq(&pdev->dev, sport->rtsirq,
>+					       imx_rtsint, 0,
>+					       dev_name(&pdev->dev), sport);
>+			if (ret)
>+				return ret;
>+		}
>+	} else {
>+		ret = devm_request_irq(&pdev->dev, sport->port.irq, imx_int, 0,
>+				       dev_name(&pdev->dev), sport);
>+		if (ret)
>+			return ret;
>+	}
>+
> 	imx_ports[sport->port.line] = sport;
>
> 	platform_set_drvdata(pdev, sport);
>--
>1.9.1


Hi, Fabio,

After the patch, uart wake up feature may be break. (So I always don't do like this.)

Since the current driver enable AWAKE before system suspend in default, after suspend, if user click console keys, it generates AWAKE interrupt,
in the irq handler, there have register access that cause system hang since uart module/ipg clocks are disabled, and system cannot resume back.

Regards,
Andy
