From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V3 3/7] tty: serial: lpuart: add little endian 32 bit
 register support
Date: Tue, 13 Jun 2017 03:27:18 +0000
Message-ID: <AM3PR04MB3063080710BB96E2E27BDD480C20@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
 <1497281848-12995-4-git-send-email-aisheng.dong@nxp.com>
 <AM4PR0401MB226097F474202777C61AAE72FFC20@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR0401MB226097F474202777C61AAE72FFC20@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Duan <fugang.duan@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "stefan@agner.ch" <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, "nikita.yoush@cogentembedded.com" <nikita.yoush@cogentembedded.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "dongas86@gmail.com" <dongas86@gmail.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Andy Duan
> Sent: Tuesday, June 13, 2017 11:09 AM
> To: A.s. Dong; linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> gregkh@linuxfoundation.org; jslaby@suse.com; stefan@agner.ch; Mingkai Hu;
> Y.b. Lu; nikita.yoush@cogentembedded.com; andy.shevchenko@gmail.com;
> dongas86@gmail.com; A.s. Dong
> Subject: RE: [PATCH V3 3/7] tty: serial: lpuart: add little endian 32 bit
> register support
>=20
> From: Dong Aisheng <aisheng.dong@nxp.com> Sent: Monday, June 12, 2017
> 11:37 PM
> >To: linux-serial@vger.kernel.org
> >Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >gregkh@linuxfoundation.org; jslaby@suse.com; Andy Duan
> ><fugang.duan@nxp.com>; stefan@agner.ch; Mingkai Hu
> ><mingkai.hu@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>;
> >nikita.yoush@cogentembedded.com; andy.shevchenko@gmail.com;
> >dongas86@gmail.com; A.S. Dong <aisheng.dong@nxp.com>
> >Subject: [PATCH V3 3/7] tty: serial: lpuart: add little endian 32 bit
> >register support
> >
> >Use standard port->iotype to distinguish endian difference. Note as we
> >read/write register by checking iotype dynamically, we need to
> >initialize the iotype correctly for earlycon as well to avoid a break.
> >
> >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Cc: Jiri Slaby <jslaby@suse.com> (supporter:TTY LAYER)
> >Cc: Stefan Agner <stefan@agner.ch>
> >Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
> >Cc: Yangbo Lu <yangbo.lu@nxp.com>
> >Cc: Fugang Duan <fugang.duan@nxp.com>
> >Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> >ChangeLog:
> >v2->v3:
> > * Instead of using global var, use standard port->iotype to distinguish
> >   endian difference.
> >v1->v2:
> > * No changes
> >---
> > drivers/tty/serial/fsl_lpuart.c | 43
> >+++++++++++++++++++++++++++----------
> >----
> > 1 file changed, 29 insertions(+), 14 deletions(-)
> >
> >diff --git a/drivers/tty/serial/fsl_lpuart.c
> >b/drivers/tty/serial/fsl_lpuart.c index
> >ed9db2f..bbf47a0 100644
> >--- a/drivers/tty/serial/fsl_lpuart.c
> >+++ b/drivers/tty/serial/fsl_lpuart.c
> >@@ -280,15 +280,29 @@ MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
> > /* Forward declare this for the dma callbacks*/  static void
> >lpuart_dma_tx_complete(void *arg);
> >
> >-static inline u32 lpuart32_read(struct uart_port *port, u32 reg_off) -{
> >-	return ioread32be(port->membase + reg_off);
> >+static inline u32 lpuart32_read(struct uart_port *port, u32 off) {
> >+	switch (port->iotype) {
> >+	case UPIO_MEM32:
> >+		return readl(port->membase + off);
> >+	case UPIO_MEM32BE:
> >+		return ioread32be(port->membase + off);
> >+	default:
> >+		return 0;
> >+	};
> > }
> >
> > static inline void lpuart32_write(struct uart_port *port, u32 val,
> >-				  u32 reg_off)
> >+				  u32 off)
> > {
> >-	iowrite32be(val, port->membase + reg_off);
> >+	switch (port->iotype) {
> >+	case UPIO_MEM32:
> >+		writel(val, port->membase + off);
> >+		break;
> >+	case UPIO_MEM32BE:
> >+		iowrite32be(val, port->membase + off);
> >+		break;
> >+	};
> > }
> >
> > static void lpuart_stop_tx(struct uart_port *port) @@ -602,7 +616,7 @@
> >static irqreturn_t lpuart_txint(int irq, void *dev_id)
> >
> > 	spin_lock_irqsave(&sport->port.lock, flags);
> > 	if (sport->port.x_char) {
> >-		if (sport->port.iotype & UPIO_MEM32BE)
> >+		if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
> > 			lpuart32_write(&sport->port, sport->port.x_char,
> UARTDATA);
> > 		else
> > 			writeb(sport->port.x_char, sport->port.membase + UARTDR);
> @@
> >-610,14 +624,14 @@ static irqreturn_t lpuart_txint(int irq, void
> >*dev_id)
> > 	}
> >
> > 	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
> >-		if (sport->port.iotype & UPIO_MEM32BE)
> >+		if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
>=20
> Can use one macro instead of sport->port.iotype & (UPIO_MEM32 |
> UPIO_MEM32BE ?
>=20

UPIO_MEM32 and UPIO_MEM32BE are serial core definitions.
If we use one macro for it, then the macro seems be better in serial core.
But I don't think it's quite necessary.

Explicit using also make the code look clearer.

Regards
Dong Aisheng

> > 			lpuart32_stop_tx(&sport->port);
> > 		else
> > 			lpuart_stop_tx(&sport->port);
> > 		goto out;
> > 	}
> >
> >-	if (sport->port.iotype & UPIO_MEM32BE)
> >+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
> > 		lpuart32_transmit_buffer(sport);
> > 	else
> > 		lpuart_transmit_buffer(sport);
> >@@ -1890,12 +1904,12 @@ static int __init lpuart_console_setup(struct
> >console *co, char *options)
> > 	if (options)
> > 		uart_parse_options(options, &baud, &parity, &bits, &flow);
> > 	else
> >-		if (sport->port.iotype & UPIO_MEM32BE)
> >+		if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
> > 			lpuart32_console_get_options(sport, &baud, &parity,
> &bits);
> > 		else
> > 			lpuart_console_get_options(sport, &baud, &parity, &bits);
> >
> >-	if (sport->port.iotype & UPIO_MEM32BE)
> >+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
> > 		lpuart32_setup_watermark(sport);
> > 	else
> > 		lpuart_setup_watermark(sport);
> >@@ -1954,6 +1968,7 @@ static int __init
> >lpuart32_early_console_setup(struct
> >earlycon_device *device,
> > 	if (!device->port.membase)
> > 		return -ENODEV;
> >
> >+	device->port.iotype =3D UPIO_MEM32BE;
> > 	device->con->write =3D lpuart32_early_write;
> > 	return 0;
> > }
> >@@ -2015,7 +2030,7 @@ static int lpuart_probe(struct platform_device
> *pdev)
> > 	}
> > 	sport->port.irq =3D ret;
> > 	sport->port.iotype =3D sdata->iotype;
> >-	if (sport->port.iotype & UPIO_MEM32BE)
> >+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
> > 		sport->port.ops =3D &lpuart32_pops;
> > 	else
> > 		sport->port.ops =3D &lpuart_pops;
> >@@ -2042,7 +2057,7 @@ static int lpuart_probe(struct platform_device
> >*pdev)
> >
> > 	platform_set_drvdata(pdev, &sport->port);
> >
> >-	if (sport->port.iotype & UPIO_MEM32BE)
> >+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
> > 		lpuart_reg.cons =3D LPUART32_CONSOLE;
> > 	else
> > 		lpuart_reg.cons =3D LPUART_CONSOLE;
> >@@ -2095,7 +2110,7 @@ static int lpuart_suspend(struct device *dev)
> > 	struct lpuart_port *sport =3D dev_get_drvdata(dev);
> > 	unsigned long temp;
> >
> >-	if (sport->port.iotype & UPIO_MEM32BE) {
> >+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE)) {
> > 		/* disable Rx/Tx and interrupts */
> > 		temp =3D lpuart32_read(&sport->port, UARTCTRL);
> > 		temp &=3D ~(UARTCTRL_TE | UARTCTRL_TIE | UARTCTRL_TCIE); @@ -
> 2146,7
> >+2161,7 @@ static int lpuart_resume(struct device *dev)
> > 	if (sport->port.suspended && !sport->port.irq_wake)
> > 		clk_prepare_enable(sport->clk);
> >
> >-	if (sport->port.iotype & UPIO_MEM32BE) {
> >+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE)) {
> > 		lpuart32_setup_watermark(sport);
> > 		temp =3D lpuart32_read(&sport->port, UARTCTRL);
> > 		temp |=3D (UARTCTRL_RIE | UARTCTRL_TIE | UARTCTRL_RE |
> >--
> >2.7.4
