Return-Path: <SRS0=1MuI=YV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC289CA9EC0
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 11:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CA9208C0
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 11:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Fo6TaA3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfJ1LJf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:09:35 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44694 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LJe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Oct 2019 07:09:34 -0400
Received: by mail-vs1-f68.google.com with SMTP id j85so6017874vsd.11
        for <linux-serial@vger.kernel.org>; Mon, 28 Oct 2019 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FPYg5WewQGTR8sh3JGfyt5orVasGP09N/lcRtCQwclQ=;
        b=Fo6TaA3t1A981WfgtW7teuK7kYqbZlXHgRVP4IVFtiEA1zh9aVMvmbkPcVbRodG9pr
         hUhSSLoVBTAELuu/uAn+uwJoztLhCQgFotscJYwUx4QiSog+rhkTJTIBHM5UocS6RO+X
         ky9TdvtQwi5g2tJcvu4aX+Udiqf7nPr7bInbMiRwnB+JeZHZHHEi4BGu5lycWnGKMAP5
         KYCxw4f/DxYr2LUnFAbcDJ7rqiiLc3qIT1L/TMPLqsqCUscEyi5KFRPyOMgANe13qNR1
         bIIR5Ft+umgNVtSeK2vhCq7thW98EZo3+yvSCXWBj61j8ZSINHhf5lDboE9BHLqhztW8
         khHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FPYg5WewQGTR8sh3JGfyt5orVasGP09N/lcRtCQwclQ=;
        b=tiwsvMO3zBqh9W9ari3VxsreHd1uFcw9hic7A2BA6bbqNUtnMVvUvEqRDSUk81w2bD
         y+92YL4eZHnknGdloS8bnqx83qQSMUliQG6vKtNDPfkxVovEvIZzFfxS1az8aV7FKPWs
         5wRDE5FAh4m4bAhW5zxu1UTH3vRQ5u1bPl9rGWY+PaVpPuR/4D2CQR0HROxrglv3KGCb
         UuaCJSJxNTCFQpdUtWDwLz7HtgkDqEkvDe3KVCukkDOtwoh10aWfcq1Jg+f5hrk4GE0E
         TFDiHlZqsfrLS3aFF83ZDT3DvM1Tf93tWirdAJEaSujg4w4rgfI2IOaCvUZnrKdWHw31
         QSww==
X-Gm-Message-State: APjAAAXxsanNk/0miFqbr72kLw/wmn5Q6AVL7QvrYxAcbmkZs9Lxv8jo
        9gf2L0i6C5q0STRTJ3snfHQ9ofnhFaxGqEA9jRo=
X-Google-Smtp-Source: APXvYqwqnnZh/+8hqvtt1FfewutxbxCbfYntkZtu1ouBsgiANUm0mny/4sCEFp8UQoyOAqXeP796FgMQu/gNPOTRvCI=
X-Received: by 2002:a67:b648:: with SMTP id e8mr8749169vsm.164.1572260973130;
 Mon, 28 Oct 2019 04:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
 <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
 <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com>
 <CAEXMXLSkNXPYQtzLtnxTzeVAL5MvafsG1yUZHjn8Stg-UZyT=g@mail.gmail.com> <CAGm1_ksD6UDdW-3B4KkkoP1QYhp307YMyzf-GPx1Vu1oCFka+A@mail.gmail.com>
In-Reply-To: <CAGm1_ksD6UDdW-3B4KkkoP1QYhp307YMyzf-GPx1Vu1oCFka+A@mail.gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 28 Oct 2019 12:09:01 +0100
Message-ID: <CAGm1_ksb7tG3xux1yery5qya7UAGYyMBz0xbVgG6pKxaR2Nf3A@mail.gmail.com>
Subject: Re: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Nuno,

On Thu, Oct 17, 2019 at 3:34 PM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> Hi Nuno,
>
> On Thu, Oct 17, 2019 at 11:19 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com> =
wrote:
> >
> > Hi Yegor,
> >
> > I'm not sure if by your previous message you think I have some kind of
> > hardware or DT issue or if this is being handled as a regression.
>
> There were some upstreamed fixes recently. See commits [1], [2]. Also,
> make sure DMA for OMAP-8250 driver is disabled. Let me know if RTS/CTS
> is working as expected on am335x. See this discussion [3].
>
> [1] https://marc.info/?l=3Dlinux-kernel&m=3D157037963426476&w=3D2
> [2] https://marc.info/?l=3Dlinux-kernel&m=3D157037964726483&w=3D2
> [3] https://marc.info/?l=3Dlinux-omap&m=3D157018333915769&w=3D2

could you already try at least 5.4-rc4 and test whether the hardware
flow control is fixed for am335x and your application?

Regards,
Yegor

> > Thanks,
> > Nuno
> >
> > On Tue, Oct 1, 2019 at 11:03 PM Nuno Gon=C3=A7alves <nunojpg@gmail.com>=
 wrote:
> > >
> > > Yes, I remember seeing those warnings.
> > >
> > > On Tue, Oct 1, 2019 at 10:02 PM Yegor Yefremov
> > > <yegorslists@googlemail.com> wrote:
> > > >
> > > > Hi Nuno,
> > > >
> > > > On Sun, Sep 29, 2019 at 8:46 AM Nuno Gon=C3=A7alves <nunojpg@gmail.=
com> wrote:
> > > > >
> > > > > I have since found that I am affected by two apparently different
> > > > > regressions since 5.3.
> > > > >
> > > > > 4a96895f74c9633b51427fd080ab70fa62b65bc4 is only confirmed to aff=
ect
> > > > > me on a omap8250 where the issue is that there are a few char err=
ors
> > > > > every few seconds. I can't confirm if chars are added, removed or
> > > > > changed, for now I only can confirm my state machine looses track=
ing.
> > > >
> > > > Can you see kernel warnings about an overrun on OMAP UART?
> > > >
> > > > > I will make a separate report from the problem identified on sunx=
i.
> > > > >
> > > > > On Sat, Sep 28, 2019 at 7:59 AM Nuno Gon=C3=A7alves <nunojpg@gmai=
l.com> wrote:
> > > > > >
> > > > > > On 32 bit arm platforms (am335x and sunxi) I get unexpected byt=
es on
> > > > > > serial ports after this commit.
> > > > > >
> > > > > > I use CTS (so: for input flow control).
> > > > > >
> > > > > > I've observed two different issues, one where I get just a few =
missed
> > > > > > or added bytes about once a minute, and another where I get tot=
ally
> > > > > > unexpected chars until I reopen the port.
> > > > > >
> > > > > > I will have a hard time to analyse and give a better descriptio=
n of
> > > > > > how exactly the port is failing, so maybe you have a idea of wh=
at is
> > > > > > the issue with this patch.
> > > > > >
> > > > > > I've reverted this on top of 5.3.1 and consistently got the iss=
ue fixed.
> > > > > >
> > > > > > Thanks,
> > > > > > Nuno
> > > > > >
> > > > > > commit 4a96895f74c9633b51427fd080ab70fa62b65bc4
> > > > > > Author: Yegor Yefremov <yegorslists@googlemail.com>
> > > > > > Date:   Thu Jun 20 08:24:20 2019 +0200
> > > > > >
> > > > > >     tty/serial/8250: use mctrl_gpio helpers
> > > > > >
> > > > > >     This patch permits the usage for GPIOs to control
> > > > > >     the CTS/RTS/DTR/DSR/DCD/RI signals.
> > > > > >
> > > > > >     Changed by Stefan:
> > > > > >     Only call mctrl_gpio_init(), if the device has no ACPI comp=
anion device
> > > > > >     to not break existing ACPI based systems. Also only use the=
 mctrl_gpio_
> > > > > >     functions when "gpios" is available.
> > > > > >
> > > > > >     Use MSR / MCR <-> TIOCM wrapper functions.
> > > > > >
> > > > > >     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > > > >     Signed-off-by: Stefan Roese <sr@denx.de>
> > > > > >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel=
.com>
> > > > > >     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.c=
om>
> > > > > >     Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > > > >     Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > >     Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > >     Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > > >     Cc: Yegor Yefremov <yegorslists@googlemail.com>
> > > > > >     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg>
