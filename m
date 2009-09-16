From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH][uart] fit blackfin uart over sport driver into common
	uart inftrastructure (v2)
Date: Wed, 16 Sep 2009 14:56:29 -0400
Message-ID: <8bd0f97a0909161156x3cf83b51tb01f6c890abf8594@mail.gmail.com>
References: <1253095348.25791.6.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:35836 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZIPS4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Sep 2009 14:56:48 -0400
In-Reply-To: <1253095348.25791.6.camel@eight.analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

On Wed, Sep 16, 2009 at 06:02, sonic zhang wrote:
> 3. Move most platform data into arch specific board files.

might as well do it right now since you've done most of it already.
i.e. all of the peripheral logic should be in the boards, not the
driver.  so the bfin_uart_pin_req_sportx lists should get moved to the
platform resources as well as the SPORT base addresses.

then we get proper device bindings between ttySS# and SPORT# by using
the .id field.  ttySS0 should always be SPORT0, ttySS1 should always
be SPORT1, etc...

> Signed-off-by: Michael Frysinger <michael.frysinger@analog.com>

you shouldnt add s-o-b tags for people who didnt opt for them ... i
was sleeping when you wrote, committed, and e-mailed out these
changes.  i also handt posted these changes yet because i knew there
were still issues to be worked out.

> --- a/drivers/serial/bfin_sport_uart.c
> +++ b/drivers/serial/bfin_sport_uart.c
> +#define DRV_NAME "bfin-sport-uart"
> +#define DEVICE_NAME =C2=A0 =C2=A0"ttySS"

should really use the dev_* functions for output rather than the pr_*
ones, but if you dont do that, you should add before the #include's:
#define pr_fmt(fmt) DRV_NAME ": " fmt

> =C2=A0 =C2=A0 =C2=A0 =C2=A0tclkdiv =3D sclk/(2 * baud_rate) - 1;
> - =C2=A0 =C2=A0 =C2=A0 tfsdiv =3D 12;
> - =C2=A0 =C2=A0 =C2=A0 rclkdiv =3D sclk/(2 * baud_rate * 3) - 1;
> + =C2=A0 =C2=A0 =C2=A0 rclkdiv =3D sclk/(2 * baud_rate * 2) - 1;

missing space around the "/"

> -static int sport_uart_suspend(struct platform_device *dev, pm_messag=
e_t state)
> +#ifdef CONFIG_PM
> +static int sport_uart_suspend(struct platform_device *pdev, pm_messa=
ge_t state)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 struct sport_uart_port *sport =3D platform_get=
_drvdata(dev);
> + =C2=A0 =C2=A0 =C2=A0 struct sport_uart_port *sport =3D platform_get=
_drvdata(pdev);
>
> - =C2=A0 =C2=A0 =C2=A0 pr_debug("%s enter\n", __func__);
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev, "%s enter\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sport)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uart_suspend_p=
ort(&sport_uart_reg, &sport->port);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int sport_uart_resume(struct platform_device *dev)
> +static int sport_uart_resume(struct platform_device *pdev)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 struct sport_uart_port *sport =3D platform_get=
_drvdata(dev);
> + =C2=A0 =C2=A0 =C2=A0 struct sport_uart_port *sport =3D platform_get=
_drvdata(pdev);
>
> - =C2=A0 =C2=A0 =C2=A0 pr_debug("%s enter\n", __func__);
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev, "%s enter\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sport)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uart_resume_po=
rt(&sport_uart_reg, &sport->port);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}

these need updating to the new dev_pm_opts structure.  see the changes
i just did to the adp558-keys driver for a simple example.

> --- a/drivers/serial/bfin_sport_uart.h
> +++ b/drivers/serial/bfin_sport_uart.h

while you're in here, you might as well add the proper #ifndef header p=
rotection
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
