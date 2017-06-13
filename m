From: Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V3 5/7] tty: serial: lpuart: add imx7ulp support
Date: Tue, 13 Jun 2017 03:02:27 +0000
Message-ID: <AM4PR0401MB22607CE9EE3909A7A0B9451AFFC20@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
 <1497281848-12995-6-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497281848-12995-6-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "stefan@agner.ch" <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, "nikita.yoush@cogentembedded.com" <nikita.yoush@cogentembedded.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "dongas86@gmail.com" <dongas86@gmail.com>, "A.s. Dong" <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com> Sent: Monday, June 12, 2017 11:37=
 PM
>The lpuart of imx7ulp is basically the same as ls1021a. It's also
>32 bit width register, but unlike ls1021a, it's little endian.
>Besides that, imx7ulp lpuart has a minor different register layout from ls=
1021a
>that it has four extra registers (verid, param, global,
>pincfg) located at the beginning of register map, which are currently not =
used
>by the driver and less to be used later.
>
>To ease the register difference handling, we add a reg_off member in
>lpuart_soc_data structure to represent if the normal lpuart32_{read|write}
>requires plus a offset to hide the issue.
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Jiri Slaby <jslaby@suse.com>
>Cc: Stefan Agner <stefan@agner.ch>
>Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
>Cc: Yangbo Lu <yangbo.lu@nxp.com>
>Cc: Fugang Duan <fugang.duan@nxp.com>
>Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>
>---
>ChangeLog:
>v2->v3:
> * use standard port->iotype to represent the endians.
>v1->v2:
> * remove lpuart_reg_off according to Stefan's suggestion
>---
> drivers/tty/serial/fsl_lpuart.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpua=
rt.c index
>bbf47a0..9d05e53 100644
>--- a/drivers/tty/serial/fsl_lpuart.c
>+++ b/drivers/tty/serial/fsl_lpuart.c
>@@ -231,6 +231,9 @@
> #define DEV_NAME	"ttyLP"
> #define UART_NR		6
>
>+/* IMX lpuart has four extra unused regs located at the beginning */
>+#define IMX_REG_OFF	0x10
>+
> struct lpuart_port {
> 	struct uart_port	port;
> 	struct clk		*clk;
>@@ -259,6 +262,7 @@ struct lpuart_port {
>
> struct lpuart_soc_data {
> 	char	iotype;
>+	u8	reg_off;
> };
>
> static const struct lpuart_soc_data vf_data =3D { @@ -267,12 +271,17 @@ s=
tatic
>const struct lpuart_soc_data vf_data =3D {
>
> static const struct lpuart_soc_data ls_data =3D {
> 	.iotype =3D UPIO_MEM32BE,
>+};
>
>+static struct lpuart_soc_data imx_data =3D {
>+	.iotype =3D UPIO_MEM32,
>+	.reg_off =3D IMX_REG_OFF,
> };
>
> static const struct of_device_id lpuart_dt_ids[] =3D {
> 	{ .compatible =3D "fsl,vf610-lpuart",	.data =3D &vf_data, },
> 	{ .compatible =3D "fsl,ls1021a-lpuart",	.data =3D &ls_data, },
>+	{ .compatible =3D "fsl,imx7ulp-lpuart",	.data =3D &imx_data, },
> 	{ /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, lpuart_dt_ids); @@ -2020,6 +2029,7 @@ static
>int lpuart_probe(struct platform_device *pdev)
> 	if (IS_ERR(sport->port.membase))
> 		return PTR_ERR(sport->port.membase);
>
>+	sport->port.membase +=3D sdata->reg_off;
> 	sport->port.mapbase =3D res->start;

Also update the mapbase.

> 	sport->port.dev =3D &pdev->dev;
> 	sport->port.type =3D PORT_LPUART;
>--
>2.7.4
