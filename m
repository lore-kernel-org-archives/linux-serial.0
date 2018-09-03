From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode
 switch for suspend
Date: Mon, 3 Sep 2018 08:51:23 +0000
Message-ID: <AM6PR0402MB3911C74F62B845CF83644D6DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
 <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

Gentle Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Thursday, August 9, 2018 6:06 PM
> To: gregkh@linuxfoundation.org; jslaby@suse.com;
> linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode swi=
tch for
> suspend
>=20
> On some i.MX SoCs' low power mode, UART iomux settings may be lost, need
> to add pinctrl sleep/default mode switch during suspend/resume to make su=
re
> UART iomux settings are correct after resume.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> a09ccef..c280d43 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -24,6 +24,7 @@
>  #include <linux/serial.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/rational.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> @@ -2447,6 +2448,8 @@ static int imx_uart_suspend_noirq(struct device
> *dev)
>=20
>  	clk_disable(sport->clk_ipg);
>=20
> +	pinctrl_pm_select_sleep_state(dev);
> +
>  	return 0;
>  }
>=20
> @@ -2455,6 +2458,8 @@ static int imx_uart_resume_noirq(struct device
> *dev)
>  	struct imx_port *sport =3D dev_get_drvdata(dev);
>  	int ret;
>=20
> +	pinctrl_pm_select_default_state(dev);
> +
>  	ret =3D clk_enable(sport->clk_ipg);
>  	if (ret)
>  		return ret;
> --
> 2.7.4
