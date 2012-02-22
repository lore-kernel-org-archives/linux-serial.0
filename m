From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] serial/sirf: fixup for changes to pin control
Date: Wed, 22 Feb 2012 17:14:40 +0800
Message-ID: <CAGsJ_4yLTPhLJEf9GHw694U9iYmtLgYPvYe3VGdyKKKcuX6pUA@mail.gmail.com>
References: <1329417828-6005-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65299 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab2BVJPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 04:15:02 -0500
In-Reply-To: <1329417828-6005-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@freescale.com>, Thomas Abraham <thomas.abraham@linaro.org>, Dong Aisheng <dong.aisheng@linaro.org>, Rajendra Nayak <rajendra.nayak@linaro.org>, Haojian Zhuang <haojian.zhuang@marvell.com>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2012/2/17 Linus Walleij <linus.walleij@linaro.org>:
> We changed the signature of the pin multiplexing functions to
> handle any pin business, so fix up the Sirf driver to call this
> new interface and rename some variables to make the semantics
> understandable.
>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Barry Song <Baohua.Song@csr.com>

> ---
> =C2=A0drivers/tty/serial/sirfsoc_uart.c | =C2=A0 20 ++++++++++-------=
---
> =C2=A0drivers/tty/serial/sirfsoc_uart.h | =C2=A0 =C2=A02 +-
> =C2=A02 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/s=
irfsoc_uart.c
> index a60523f..c1a871e 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -22,7 +22,7 @@
> =C2=A0#include <linux/io.h>
> =C2=A0#include <asm/irq.h>
> =C2=A0#include <asm/mach/irq.h>
> -#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/consumer.h>
>
> =C2=A0#include "sirfsoc_uart.h"
>
> @@ -673,12 +673,12 @@ int sirfsoc_uart_probe(struct platform_device *=
pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0port->irq =3D res->start;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sirfport->hw_flow_ctrl) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sirfport->pmx =3D =
pinmux_get(&pdev->dev, NULL);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D IS_ERR(sir=
fport->pmx);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sirfport->p =3D pi=
nctrl_get(&pdev->dev, NULL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D IS_ERR(sir=
fport->p);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto pmx_err;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto pin_err;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinmux_enable(sirf=
port->pmx);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl_enable(sir=
fport->p);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0port->ops =3D &sirfsoc_uart_ops;
> @@ -696,10 +696,10 @@ int sirfsoc_uart_probe(struct platform_device *=
pdev)
> =C2=A0port_err:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sirfport->hw_flow_ctrl) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinmux_disable(sir=
fport->pmx);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinmux_put(sirfpor=
t->pmx);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl_disable(si=
rfport->p);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl_put(sirfpo=
rt->p);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> -pmx_err:
> +pin_err:
> =C2=A0irq_err:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0devm_iounmap(&pdev->dev, port->membase);
> =C2=A0err:
> @@ -712,8 +712,8 @@ static int sirfsoc_uart_remove(struct platform_de=
vice *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct uart_port *port =3D &sirfport->port=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sirfport->hw_flow_ctrl) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinmux_disable(sir=
fport->pmx);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinmux_put(sirfpor=
t->pmx);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl_disable(si=
rfport->p);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl_put(sirfpo=
rt->p);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0devm_iounmap(&pdev->dev, port->membase);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0uart_remove_one_port(&sirfsoc_uart_drv, po=
rt);
> diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/s=
irfsoc_uart.h
> index fc64260..6e207fd 100644
> --- a/drivers/tty/serial/sirfsoc_uart.h
> +++ b/drivers/tty/serial/sirfsoc_uart.h
> @@ -162,7 +162,7 @@ struct sirfsoc_uart_port {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ms_enabled;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct uart_port =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0port;
> - =C2=A0 =C2=A0 =C2=A0 struct pinmux =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *pmx;
> + =C2=A0 =C2=A0 =C2=A0 struct pinctrl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*p;
> =C2=A0};
>
> =C2=A0/* Hardware Flow Control */
> --
> 1.7.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
