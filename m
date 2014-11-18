From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 4/5] mfd: t7l66xb: prepare/unprepare clocks
Date: Tue, 18 Nov 2014 13:14:34 +0000
Message-ID: <20141118131434.GA24004@x1>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-4-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:48441 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbaKRNOm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Nov 2014 08:14:42 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so3763017iec.24
        for <linux-serial@vger.kernel.org>; Tue, 18 Nov 2014 05:14:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416236863-20898-4-git-send-email-dbaryshkov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Jiri Slaby <jslaby@suse.cz>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, 17 Nov 2014, Dmitry Eremin-Solenikov wrote:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/mfd/t7l66xb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
> index 9e04a74..439d905 100644
> --- a/drivers/mfd/t7l66xb.c
> +++ b/drivers/mfd/t7l66xb.c
> @@ -87,7 +87,7 @@ static int t7l66xb_mmc_enable(struct platform_devic=
e *mmc)
>  	unsigned long flags;
>  	u8 dev_ctl;
> =20
> -	clk_enable(t7l66xb->clk32k);
> +	clk_prepare_enable(t7l66xb->clk32k);
> =20
>  	spin_lock_irqsave(&t7l66xb->lock, flags);
> =20
> @@ -118,7 +118,7 @@ static int t7l66xb_mmc_disable(struct platform_de=
vice *mmc)
> =20
>  	spin_unlock_irqrestore(&t7l66xb->lock, flags);
> =20
> -	clk_disable(t7l66xb->clk32k);
> +	clk_disable_unprepare(t7l66xb->clk32k);
> =20
>  	return 0;
>  }
> @@ -285,7 +285,7 @@ static int t7l66xb_suspend(struct platform_device=
 *dev, pm_message_t state)
> =20
>  	if (pdata && pdata->suspend)
>  		pdata->suspend(dev);
> -	clk_disable(t7l66xb->clk48m);
> +	clk_disable_unprepare(t7l66xb->clk48m);
> =20
>  	return 0;
>  }
> @@ -295,7 +295,7 @@ static int t7l66xb_resume(struct platform_device =
*dev)
>  	struct t7l66xb *t7l66xb =3D platform_get_drvdata(dev);
>  	struct t7l66xb_platform_data *pdata =3D dev_get_platdata(&dev->dev)=
;
> =20
> -	clk_enable(t7l66xb->clk48m);
> +	clk_prepare_enable(t7l66xb->clk48m);
>  	if (pdata && pdata->resume)
>  		pdata->resume(dev);
> =20
> @@ -369,7 +369,7 @@ static int t7l66xb_probe(struct platform_device *=
dev)
>  		goto err_ioremap;
>  	}
> =20
> -	clk_enable(t7l66xb->clk48m);
> +	clk_prepare_enable(t7l66xb->clk48m);
> =20
>  	if (pdata && pdata->enable)
>  		pdata->enable(dev);
> @@ -414,9 +414,9 @@ static int t7l66xb_remove(struct platform_device =
*dev)
>  	int ret;
> =20
>  	ret =3D pdata->disable(dev);
> -	clk_disable(t7l66xb->clk48m);
> +	clk_disable_unprepare(t7l66xb->clk48m);
>  	clk_put(t7l66xb->clk48m);
> -	clk_disable(t7l66xb->clk32k);
> +	clk_disable_unprepare(t7l66xb->clk32k);
>  	clk_put(t7l66xb->clk32k);
>  	t7l66xb_detach_irq(dev);
>  	iounmap(t7l66xb->scr);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
