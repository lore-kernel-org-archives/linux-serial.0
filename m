From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 5/5] mfd: tc6387xb: prepare/unprepare clocks
Date: Tue, 18 Nov 2014 12:04:29 +0000
Message-ID: <20141118120429.GZ24004@x1>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-5-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52966 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbaKRMEh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Nov 2014 07:04:37 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so7067944ier.32
        for <linux-serial@vger.kernel.org>; Tue, 18 Nov 2014 04:04:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416236863-20898-5-git-send-email-dbaryshkov@gmail.com>
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
>  drivers/mfd/tc6387xb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Looks good.  Applied, thanks.

> diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
> index e71f880..85fab37 100644
> --- a/drivers/mfd/tc6387xb.c
> +++ b/drivers/mfd/tc6387xb.c
> @@ -52,7 +52,7 @@ static int tc6387xb_suspend(struct platform_device =
*dev, pm_message_t state)
> =20
>  	if (pdata && pdata->suspend)
>  		pdata->suspend(dev);
> -	clk_disable(tc6387xb->clk32k);
> +	clk_disable_unprepare(tc6387xb->clk32k);
> =20
>  	return 0;
>  }
> @@ -62,7 +62,7 @@ static int tc6387xb_resume(struct platform_device *=
dev)
>  	struct tc6387xb *tc6387xb =3D platform_get_drvdata(dev);
>  	struct tc6387xb_platform_data *pdata =3D dev_get_platdata(&dev->dev=
);
> =20
> -	clk_enable(tc6387xb->clk32k);
> +	clk_prepare_enable(tc6387xb->clk32k);
>  	if (pdata && pdata->resume)
>  		pdata->resume(dev);
> =20
> @@ -100,7 +100,7 @@ static int tc6387xb_mmc_enable(struct platform_de=
vice *mmc)
>  	struct platform_device *dev      =3D to_platform_device(mmc->dev.pa=
rent);
>  	struct tc6387xb *tc6387xb =3D platform_get_drvdata(dev);
> =20
> -	clk_enable(tc6387xb->clk32k);
> +	clk_prepare_enable(tc6387xb->clk32k);
> =20
>  	tmio_core_mmc_enable(tc6387xb->scr + 0x200, 0,
>  		tc6387xb_mmc_resources[0].start & 0xfffe);
> @@ -113,7 +113,7 @@ static int tc6387xb_mmc_disable(struct platform_d=
evice *mmc)
>  	struct platform_device *dev      =3D to_platform_device(mmc->dev.pa=
rent);
>  	struct tc6387xb *tc6387xb =3D platform_get_drvdata(dev);
> =20
> -	clk_disable(tc6387xb->clk32k);
> +	clk_disable_unprepare(tc6387xb->clk32k);
> =20
>  	return 0;
>  }
> @@ -214,7 +214,7 @@ static int tc6387xb_remove(struct platform_device=
 *dev)
>  	mfd_remove_devices(&dev->dev);
>  	iounmap(tc6387xb->scr);
>  	release_resource(&tc6387xb->rscr);
> -	clk_disable(tc6387xb->clk32k);
> +	clk_disable_unprepare(tc6387xb->clk32k);
>  	clk_put(tc6387xb->clk32k);
>  	kfree(tc6387xb);
> =20

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
