Return-Path: <SRS0=INAG=AM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77ECC433DF
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 12:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85AD20702
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 12:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqT6qh0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgGAMqh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbgGAMqf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jul 2020 08:46:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F844C03E979
        for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2020 05:46:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so1854871ljn.8
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2020 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOvTyVPom8sy12IqSAPoAUTKHIeIoMVlwU22bcDjqVI=;
        b=oqT6qh0IRRfF/hnPkpSxBlCyj8JlcIeGScOsmu3MknpD1FOeumlsiueZV9yQrK6CbT
         irSqPO/UzaDN6TU8bs6xDqkerVRlNw8OtpvQIms+HZuijJce976FRgfZHVOMOzJ+iuX4
         KBxf6UE202KXfO2JbQ1mpcEZVV9gmuk+p/140T9mOkIVSVCp87s5NiE61LmBwFODPUiU
         HwuzN2rXXXp45jIAlyYWd2kpJooAB9pHBRbaHLSeoDnG954hScv6X8EOLIonsgOKOnvQ
         x+nCGPJrXDOssJfQ48uLMfwawqYhSXcU+SF7oq5ZY1VWDhKG4AUadO3Gth8hyX8CbkSG
         AdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOvTyVPom8sy12IqSAPoAUTKHIeIoMVlwU22bcDjqVI=;
        b=OhgN3GZl1NetnD2dA5dusBYPd8LcHsZBR+ITnS+GojQLtna11rSk1P38xd6LF28iwA
         q51htxANWviMt9Thqz7JM1g+x7t9P99BKqM/XvyCVGHwggoeKZsy/HXpmRoShcpD/pUf
         TkPn/fv9G4aQsq8bX/QMBTjrXsqnYdHJdrFJaLuiG3IP+uItbOxor14GepqQf2jjb64O
         9+B1gnYLovd0dWfwTnnmCUnOl4G8LVpWlMLPvShxzCy6VO8c1ilXOGUzrB2yvYSyv/Mv
         WWJUqWdnV3U2aQ8lHdy83251WZcvdrU8hN8wNrZjZdoC8GkZ2H/9/zA5QHZg8ICbCyoT
         sKtw==
X-Gm-Message-State: AOAM531dImByn5+OZLtQ/Y1m+P0URa+3n4UxF/QpXxhcFg5OmdFaiucs
        MSB1p3gyVr+OOfD/4+q1Z9GCxCGLn/D/6dDgaZBjwQ==
X-Google-Smtp-Source: ABdhPJyqoZrcGcxMfGqgL0Ym5t+DxEuMVFUjY74p7t/TokcsIbFUid9tbE1q0whKvuYnl7vgX2sWaFjlwZnne9EfZcM=
X-Received: by 2002:a2e:85d8:: with SMTP id h24mr12658637ljj.274.1593607593233;
 Wed, 01 Jul 2020 05:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
 <20200701043001.73qhxyyjx6bayn2m@wunner.de> <20200701113904.7zh534vmlvjvojia@mobilestation>
In-Reply-To: <20200701113904.7zh534vmlvjvojia@mobilestation>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 1 Jul 2020 08:46:21 -0400
Message-ID: <CALWDO_VbstuRPw-M13gf9JxsHb3Jhr7KEnCpFMoV6ZdDUohG1Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix max baud limit in generic 8250 port"
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Daniel Winkler <danielwinkler@google.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Adding the bluetooth list as well per the Bluetooth impact.


On Wed, Jul 1, 2020 at 7:39 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Hello Lukas,
>
> On Wed, Jul 01, 2020 at 06:30:01AM +0200, Lukas Wunner wrote:
> > On Tue, Jun 30, 2020 at 04:42:11PM -0700, Daniel Winkler wrote:
> > > This reverts commit 0eeaf62981ecc79e8395ca8caa1570eaf3a12257.
> >
> > That is not an upstream commit.  You probably mean:
> >
> >     commit 7b668c064ec33f3d687c3a413d05e355172e6c92
> >     Author: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >     Date:   Thu May 7 02:31:32 2020 +0300
> >
> >     serial: 8250: Fix max baud limit in generic 8250 port
> >
> > And you didn't cc the commit author (hereby fixed).
> >
> > Thanks,
> >
> > Lukas
>
> Thanks for Cc'ing me.
>
> >
> > >
> > > The change regresses the QCA6174A-3 bluetooth chip, preventing
> > > firmware from being properly loaded. We have verified that without
> > > this patch, the chip works as intended.
>
> That text doesn't say what is really wrong and why the firmware couldn't be loaded.
> The original commit gets back the 8250 port baud rate limitation so if the baud
> gets out of the range [uartclk / 16 / UART_DIV_MAX; (port->uartclk + tolerance) /
> 16], then it will be clamped to be within it. That range is what the standard
> 8250 port supports. Acceptance of out of that range values will cause a
> problem further in calling serial8250_get_divisor() and uart_get_divisor()
> methods (see the original patch log message) for standard 8250 ports. Any different
> behavior must be taken into account by a custom set_termios() callbacks or at
> least must be workarounded so the standard 8250 ports wouldn't be affected. So in
> order to investigate the root cause of the problem it would be good to at least
> know what your platform was and what UART port has been used in the attempt to
> load the QCA6174A-3 chip firmware.
>
> -Sergey
>
> > >
> > > Signed-off-by: Daniel Winkler <danielwinkler@google.com>
> > > ---
> > >
> > >  drivers/tty/serial/8250/8250_port.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index 1632f7d25acca..e057c65ac1580 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -2618,8 +2618,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
> > >                                          struct ktermios *termios,
> > >                                          struct ktermios *old)
> > >  {
> > > -   unsigned int tolerance = port->uartclk / 100;
> > > -
> > >     /*
> > >      * Ask the core to calculate the divisor for us.
> > >      * Allow 1% tolerance at the upper limit so uart clks marginally
> > > @@ -2628,7 +2626,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
> > >      */
> > >     return uart_get_baud_rate(port, termios, old,
> > >                               port->uartclk / 16 / UART_DIV_MAX,
> > > -                             (port->uartclk + tolerance) / 16);
> > > +                             port->uartclk);
> > >  }
> > >
> > >  void
> > > --
> > > 2.27.0.212.ge8ba1cc988-goog
>
> --
> You received this message because you are subscribed to the Google Groups "ChromeOS Bluetooth Upstreaming" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> To post to this group, send email to chromeos-bluetooth-upstreaming@chromium.org.
> To view this discussion on the web visit https://groups.google.com/a/chromium.org/d/msgid/chromeos-bluetooth-upstreaming/20200701113904.7zh534vmlvjvojia%40mobilestation.
