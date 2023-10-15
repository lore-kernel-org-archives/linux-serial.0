Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1921CDB47E
	for <linux-serial@archiver.kernel.org>; Sun, 15 Oct 2023 21:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJOVax (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 15 Oct 2023 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJOVaw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 15 Oct 2023 17:30:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3CA9
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 14:30:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so37167065e9.3
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697405449; x=1698010249; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2nGlzinV6cB6NHNvb3oZZiKEgqkp2ZYj2O1yT8Va4E=;
        b=hY96bZqliSDoBaT3iFB5Fv1fMSL5fxeGf1xH/woZwSY/stQXpXqC9YJUhuW9+ANCvK
         SVEGRAdaVJqo0+rfF/dAm2NXXK2I7jOBx/yV+VSEEU4iKOI9nVKSq+wNY9llRBxv+xBz
         o913mwKe72cPgCsZmtQqLPfV+coKcuZzrw1Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697405449; x=1698010249;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2nGlzinV6cB6NHNvb3oZZiKEgqkp2ZYj2O1yT8Va4E=;
        b=uHLqz/iScU3HBrr1hR7zAs3q7BF2gImRmKpWtV2/DGzhKtITl7kNjUrJHISCmvil6H
         dGwJ0bqaMtv4WGd/M5x9e09yKR4ZlXVnCnofOii1UdTpkoYryjCVI7tBUXkpMw/pZWsV
         tuK545Jwma0uJsCRgwuv65A1nGolzO0nKapv8gQmwZW7YNVQJtw42CJ2/vC0f26aUFx2
         BAUTRfJYoaZquABIKZkFnLnQkQzS1Lfs2PyJofNTiIwUzonGlQ8FyEhnn74aKdqe5uLO
         dbjosrx9MzyrK9xRoQH+2JHYSPuzjfWa1xntv8dFDcGYfAtEWlxFedn6V4P+2NniisI3
         jQFA==
X-Gm-Message-State: AOJu0YyjKpaIezsFLMK3H5vkaLfwK3tGfDzkPUYYqML4+0UUYkD/iqTg
        10hS3lgP0OnXZjYzxWw2uBFX9A==
X-Google-Smtp-Source: AGHT+IHlPgT180oGSbo/RRCzou55LKTouEa9OfMqH4/HAdiYBtIdRNh7QKDPcl7m9XmOcZS1+13Vpg==
X-Received: by 2002:a05:600c:2613:b0:401:d947:c8a9 with SMTP id h19-20020a05600c261300b00401d947c8a9mr28058119wma.19.1697405449216;
        Sun, 15 Oct 2023 14:30:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:67e:6714:eb50:d32? ([2001:8b0:aba:5f3c:67e:6714:eb50:d32])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b003fee8793911sm5396071wmo.44.2023.10.15.14.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 14:30:48 -0700 (PDT)
Message-ID: <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Sun, 15 Oct 2023 22:30:47 +0100
In-Reply-To: <2023101516-unmolded-otter-e3e0@gregkh>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
         <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
         <ZSPQY6UYg21Z0PnN@nuoska>
         <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
         <178DF50519C11C84.8679@lists.openembedded.org>
         <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
         <2023101516-unmolded-otter-e3e0@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 2023-10-15 at 17:31 +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 15, 2023 at 01:29:48PM +0100, Richard Purdie wrote:
> > On Sat, 2023-10-14 at 12:13 +0100, Richard Purdie via
> > lists.openembedded.org wrote:
> > > On Sat, 2023-10-14 at 10:41 +0100, Richard Purdie wrote:
> > > > Brief summary:
> > > >=20
> > > > We're seeing an issue on x86_64 with 6.5.X where data appears to be
> > > > left in the transmission buffer and not sent to the port on the sec=
ond
> > > > serial port (ttyS1) until we trigger it with intervention.
> > > >=20
> > > > Paul Gortmaker did some painful bisection over a few days down to:
> > > >=20
> > > > serial: core: Start managing serial controllers to enable runtime P=
M
> > > > https://lore.kernel.org/linux-serial/1431f5b4-fb39-483b-9314-ed2b7c=
118c11@gmail.com/T/#t
> > >=20
> > > Having poked around a bit and knowing nothing about any of this, shou=
ld
> > > this bit of new code added in the above commit to __uart_start() in
> > > serial_core.c:
> > >=20
> > > 	/*
> > > 	 * Start TX if enabled, and kick runtime PM. If the device is not
> > > 	 * enabled, serial_port_runtime_resume() calls start_tx()
> > > again
> > > 	 * after enabling the device.
> > > 	 */
> > > 	if (pm_runtime_active(&port_dev->dev))
> > > 		port->ops->start_tx(port);
> > >=20
> > >=20
> > > actually be something like:
> > >=20
> > >=20
> > > 	if (pm_runtime_active(&port_dev->dev) || !pm_runtime_enabled(&port_d=
ev->dev))
> > > 		port->ops->start_tx(port);
> > >=20
> > >=20
> > > since there are uarts that don't enable runtime PM?
> > >=20
> > > I notice that 16550A I'm using doesn't set UART_CAP_RPM and since we
> > > have data left in the xmit buffer (I managed to confirm that), it is =
as
> > > if during init, there is a race between the serial probing and the
> > > getty putting data in the buffer? If it weren't statrted, that would
> > > explain things...
> >=20
> > The above change didn't work but what does appear to be making a
> > difference is making this code call start_tx unconditionally which is
> > what it did prior to the patch. That does cause a "wake" when there
> > might not be any data but the code handles that gracefully.
> >=20
> > I therefore suspect this is the place the issue is, the question is
> > what the right conditions for calling start_tx are?
> >=20
> > I'll keep going with testing of that as the intermittent nature does
> > make this hard to know if any change helps or not.
>=20
> Can you try the patch below?  I just sent it to Linus and it's from Tony
> to resolve some other pm issues with the serial port code.

Thanks for the pointer to this. I've put it through some testing and
had one failure so far so I suspect this isn't enough unfortunately.

FWIW I was looping the testing on the complete removal of the
conditions and didn't see any failures with that.

Cheers,

Richard

>=20
> thanks,
>=20
> greg k-h
>=20
> From 81a61051e0ce5fd7e09225c0d5985da08c7954a7 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 5 Oct 2023 10:56:42 +0300
> Subject: [PATCH 3/4] serial: core: Fix checks for tx runtime PM state
>=20
> Maximilian reported that surface_serial_hub serdev tx does not work durin=
g
> system suspend. During system suspend, runtime PM gets disabled in
> __device_suspend_late(), and tx is unable to wake-up the serial core port
> device that we use to check if tx is safe to start. Johan summarized the
> regression noting that serdev tx no longer always works as earlier when t=
he
> serdev device is runtime PM active.
>=20
> The serdev device and the serial core controller devices are siblings of
> the serial port hardware device. The runtime PM usage count from serdev
> device does not propagate to the serial core device siblings, it only
> propagates to the parent.
>=20
> In addition to the tx issue for suspend, testing for the serial core port
> device can cause an unnecessary delay in enabling tx while waiting for th=
e
> serial core port device to wake-up. The serial core port device wake-up i=
s
> only needed to flush pending tx when the serial port hardware device was
> in runtime PM suspended state.
>=20
> To fix the regression, we need to check the runtime PM state of the paren=
t
> serial port hardware device for tx instead of the serial core port device=
.
>=20
> As the serial port device drivers may or may not implement runtime PM, we
> need to also add a check for pm_runtime_enabled().
>=20
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: stable <stable@kernel.org>
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to =
enable runtime PM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/r/20231005075644.25936-1-tony@atomide.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index ca26a8aef2cb..d5ba6e90bd95 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
>  	 * enabled, serial_port_runtime_resume() calls start_tx() again
>  	 * after enabling the device.
>  	 */
> -	if (pm_runtime_active(&port_dev->dev))
> +	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
>  		port->ops->start_tx(port);
>  	pm_runtime_mark_last_busy(&port_dev->dev);
>  	pm_runtime_put_autosuspend(&port_dev->dev);

