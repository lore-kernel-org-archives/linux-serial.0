From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] serial: amba-pl011: fix regression, causing an Oops on rmmod
Date: Mon, 14 Apr 2014 12:55:58 +0530
Message-ID: <CAHbNUh0AfrbamzauMxEp=88+y=Q8BksikCXkYvp5z1YvpKtF7Q@mail.gmail.com>
References: <Pine.LNX.4.64.1404051629050.3518@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:40478 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaDNHZ7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2014 03:25:59 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so8733370obc.3
        for <linux-serial@vger.kernel.org>; Mon, 14 Apr 2014 00:25:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1404051629050.3518@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg KH <greg@kroah.com>, linux-serial <linux-serial@vger.kernel.org>

On 5 April 2014 20:01, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> A recent commit ef2889f7ffee67f0aed49e854c72be63f1466759 "serial: pl011:
> Move uart_register_driver call to device probe" introduced a regression,
> causing the pl011 driver to Oops if more than 1 port have been probed. Fix
> the Oops by only calling uart_unregister_driver() once after the last port
> has been removed.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Sorry about this. There were some additional suggestion in following
thread [1] about registering it once during first probe and then
unregistering during the last remove.

[1] http://linux-kernel.2935.n7.nabble.com/PATCH-0-2-serial-Move-uart-register-driver-call-to-device-probe-td789746.html#a790221

> ---
>  drivers/tty/serial/amba-pl011.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index d4eda24..07325f2 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2176,6 +2176,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  static int pl011_remove(struct amba_device *dev)
>  {
>         struct uart_amba_port *uap = amba_get_drvdata(dev);
> +       bool busy = false;
>         int i;
>
>         uart_remove_one_port(&amba_reg, &uap->port);
> @@ -2183,9 +2184,12 @@ static int pl011_remove(struct amba_device *dev)
>         for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
>                 if (amba_ports[i] == uap)
>                         amba_ports[i] = NULL;
> +               else if (amba_ports[i])
> +                       busy = true;
>
>         pl011_dma_remove(uap);
> -       uart_unregister_driver(&amba_reg);
> +       if (!busy)
> +               uart_unregister_driver(&amba_reg);
>         return 0;
>  }
>
> --
> 1.9.1
>



-- 
Tushar Behera
