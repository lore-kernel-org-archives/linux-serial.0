From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] serial: samsung: fix device name
Date: Fri, 6 Aug 2010 09:04:00 +0900
Message-ID: <AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62998 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab0HFAED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Aug 2010 20:04:03 -0400
Received: by wwj40 with SMTP id 40so8439788wwj.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Aug 2010 17:04:00 -0700 (PDT)
In-Reply-To: <20100805201000.14030.34703.stgit@darius-desktop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darius Augulis <augulis.darius@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-serial@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>

Hi,

It's already posted by Mr. Shim
http://marc.info/?l=3Dlinux-arm-kernel&m=3D127410047306149&w=3D2

As discussed with Ben. even though it's right patch, there's some
users to use previous interface.
I also think it will be fixed. but need to coordinate with existing use=
rs.

Ben, how to you think?

On Fri, Aug 6, 2010 at 5:10 AM, Darius Augulis <augulis.darius@gmail.co=
m> wrote:
> Swap device and driver names in serial/samsung.c
>
> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> ---
> =A0drivers/serial/samsung.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> index a9d6c56..9d63f24 100644
> --- a/drivers/serial/samsung.c
> +++ b/drivers/serial/samsung.c
> @@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops =3D {
>
> =A0static struct uart_driver s3c24xx_uart_drv =3D {
> =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> - =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D "s3c2410_serial",
> + =A0 =A0 =A0 .driver_name =A0 =A0=3D "s3c2410_serial",
> =A0 =A0 =A0 =A0.nr =A0 =A0 =A0 =A0 =A0 =A0 =3D CONFIG_SERIAL_SAMSUNG_=
UARTS,
> =A0 =A0 =A0 =A0.cons =A0 =A0 =A0 =A0 =A0 =3D S3C24XX_SERIAL_CONSOLE,
> - =A0 =A0 =A0 .driver_name =A0 =A0=3D S3C24XX_SERIAL_NAME,
> + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D S3C24XX_SERIAL_NAME,
> =A0 =A0 =A0 =A0.major =A0 =A0 =A0 =A0 =A0=3D S3C24XX_SERIAL_MAJOR,
> =A0 =A0 =A0 =A0.minor =A0 =A0 =A0 =A0 =A0=3D S3C24XX_SERIAL_MINOR,
> =A0};
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
