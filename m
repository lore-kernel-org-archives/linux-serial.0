Return-Path: <SRS0=5/AJ=YK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42382ECE58E
	for <linux-serial@archiver.kernel.org>; Thu, 17 Oct 2019 09:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1288420869
	for <linux-serial@archiver.kernel.org>; Thu, 17 Oct 2019 09:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aek6BC7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfJQJT1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:19:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37110 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfJQJT1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Oct 2019 05:19:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so1465486wro.4
        for <linux-serial@vger.kernel.org>; Thu, 17 Oct 2019 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2rPzssdN6z3cxWFZZ1XMiDGt+ASAcGv7S+PRuvjPC4Q=;
        b=aek6BC7EqF/Vrx/pQWjIM0yVjIWcNCwCSPoyk0sXx0H9Vo56DjzIKFlkkPpPG/L8Eb
         SmcceodL/HKayuVP4dPj+WH+5qQPCDsu7Pga737QfWE/EG1VW55kWQ9/zz7JyHTypkIK
         sktGGkWYQk3ITNdV1/GkhQWS2gRBBkTt5GrV4eWoqTQRr0AielcCTVuh53K5CaW252Ii
         8HVSjyTv8/WZAsWVAJu/hz3Nwp3wHTB8NAI06AsZNVfJmDtNI78ZLr6hbRVo6qSCHgsk
         XkC/0bRxkhfrfGe6BUpvaRzFy7+OfXzV/7qTA8Dwm35fg9xhdpUctB/uwGhtn3rVTfLx
         CGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2rPzssdN6z3cxWFZZ1XMiDGt+ASAcGv7S+PRuvjPC4Q=;
        b=uJDOD4+B0Iz8ih05gIwaZKHU59T27XgTkGk50fkYwYSO91ORjF+ufWVBs/rz3Ina4A
         BXgRyn+nBfpoCiWdUvP67kbM3ARYETssXjoTAe8vof2FQMUaGx4kISROKsyir20nI2AS
         TfrNTcpPIdYy/8HB0M/4ILFQgQQyCwK4md5k8iCAC1c+pfdQ1WlqiSdmbPke+y8Mb6ii
         xDKPp/CI531a4k0goDrAORsZD13eqkK/lQvxY+fuUCIT7A9kk8JjJQmcGWjRXQUHMoIU
         yFC/4mRYWPuBRuNApmGhuimSyVjhNpphR3mlQZaW1OmTrGQIA+bcspmrHT8Il/T8pxu3
         vV2w==
X-Gm-Message-State: APjAAAURx6z3h10ZKe9gYFmGprQzCf1+Hu4Sze9MaJ/I+ix9BaEAmXDC
        fGJ+s7xxFq8wQar6uJRiNfKckCdLzs0cyQzPJsKCD13+
X-Google-Smtp-Source: APXvYqwhn0Y/vYGmuFdp1dA941sP7INgVbPBlxJHgNDfpnwcrv41274UqZYvnw2YRIm+OAnl1pgQAbH2JBlxe4Yt8nc=
X-Received: by 2002:adf:8068:: with SMTP id 95mr2215547wrk.249.1571303965385;
 Thu, 17 Oct 2019 02:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
 <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com> <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com>
In-Reply-To: <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com>
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Thu, 17 Oct 2019 11:19:13 +0200
Message-ID: <CAEXMXLSkNXPYQtzLtnxTzeVAL5MvafsG1yUZHjn8Stg-UZyT=g@mail.gmail.com>
Subject: Re: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        giulio.benetti@benettiengineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Yegor,

I'm not sure if by your previous message you think I have some kind of
hardware or DT issue or if this is being handled as a regression.

Thanks,
Nuno

On Tue, Oct 1, 2019 at 11:03 PM Nuno Gon=C3=A7alves <nunojpg@gmail.com> wro=
te:
>
> Yes, I remember seeing those warnings.
>
> On Tue, Oct 1, 2019 at 10:02 PM Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
> >
> > Hi Nuno,
> >
> > On Sun, Sep 29, 2019 at 8:46 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com>=
 wrote:
> > >
> > > I have since found that I am affected by two apparently different
> > > regressions since 5.3.
> > >
> > > 4a96895f74c9633b51427fd080ab70fa62b65bc4 is only confirmed to affect
> > > me on a omap8250 where the issue is that there are a few char errors
> > > every few seconds. I can't confirm if chars are added, removed or
> > > changed, for now I only can confirm my state machine looses tracking.
> >
> > Can you see kernel warnings about an overrun on OMAP UART?
> >
> > > I will make a separate report from the problem identified on sunxi.
> > >
> > > On Sat, Sep 28, 2019 at 7:59 AM Nuno Gon=C3=A7alves <nunojpg@gmail.co=
m> wrote:
> > > >
> > > > On 32 bit arm platforms (am335x and sunxi) I get unexpected bytes o=
n
> > > > serial ports after this commit.
> > > >
> > > > I use CTS (so: for input flow control).
> > > >
> > > > I've observed two different issues, one where I get just a few miss=
ed
> > > > or added bytes about once a minute, and another where I get totally
> > > > unexpected chars until I reopen the port.
> > > >
> > > > I will have a hard time to analyse and give a better description of
> > > > how exactly the port is failing, so maybe you have a idea of what i=
s
> > > > the issue with this patch.
> > > >
> > > > I've reverted this on top of 5.3.1 and consistently got the issue f=
ixed.
> > > >
> > > > Thanks,
> > > > Nuno
> > > >
> > > > commit 4a96895f74c9633b51427fd080ab70fa62b65bc4
> > > > Author: Yegor Yefremov <yegorslists@googlemail.com>
> > > > Date:   Thu Jun 20 08:24:20 2019 +0200
> > > >
> > > >     tty/serial/8250: use mctrl_gpio helpers
> > > >
> > > >     This patch permits the usage for GPIOs to control
> > > >     the CTS/RTS/DTR/DSR/DCD/RI signals.
> > > >
> > > >     Changed by Stefan:
> > > >     Only call mctrl_gpio_init(), if the device has no ACPI companio=
n device
> > > >     to not break existing ACPI based systems. Also only use the mct=
rl_gpio_
> > > >     functions when "gpios" is available.
> > > >
> > > >     Use MSR / MCR <-> TIOCM wrapper functions.
> > > >
> > > >     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > >     Signed-off-by: Stefan Roese <sr@denx.de>
> > > >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > >     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > >     Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > >     Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > >     Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >     Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > >     Cc: Yegor Yefremov <yegorslists@googlemail.com>
> > > >     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
