Return-Path: <SRS0=5/AJ=YK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6485FA3735
	for <linux-serial@archiver.kernel.org>; Thu, 17 Oct 2019 13:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B942089C
	for <linux-serial@archiver.kernel.org>; Thu, 17 Oct 2019 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KoXi67O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfJQNe4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:34:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43849 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfJQNez (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Oct 2019 09:34:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id b1so1575045vsr.10
        for <linux-serial@vger.kernel.org>; Thu, 17 Oct 2019 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C5+TmQVQS998VubTxcOceutOBLnwucDz7rmPN8Lfbng=;
        b=KoXi67O0j6g5Ab217wWWplpuMnks7/YI/fMBU0toKsGb1rB6seTNc/t1cksUHkub0M
         ZSb4wgDc2Z8coytAqytDC/9mbre/BjDcDwwoLskM7xqh575k/qMyU+BIidW6+38ftMkB
         s0fIy7CBIbOb5uVxLP0HcmsuY8WTCsij7VUCYJ5cLwq7xlRZ5aiHpbHMaGycNSCIcTkt
         Os7wje8Jo2wPbbFIX9G5uyJdBMts0kdixgdoV4O8hKr1KOsB9GkqFL4v09lOwabXuVXi
         LkpNBNQysgsQ1qhpoZUOJRmBh/VIQOO3oInyEIbcik6ZngBiQP4Zw6t3AVn1zYmk/ggN
         SBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C5+TmQVQS998VubTxcOceutOBLnwucDz7rmPN8Lfbng=;
        b=hNI/d+dWiLIYqK4tC+lbok/1mdFbpmM4XwwronXTwWYOumWO9hdCVzIcuoqHCMM38A
         IoDPkdVICAJE/86Ym8vwixScjP3r7H06dzvN9HEzanXQUVmwUVgZN/sQcOvU3s0n/QWI
         rbcUx5LsLWFztoOPyZf+Iod51t/8xCzvIQ6syVbZ3lKyT09iJKXoe93f6MPzSY96pfxt
         /HDuDVoL23rgDaOvCggOlt8jYcaSqs4KRi1FclnBXTTmMuhWL2YqC8wc8SviCS1R567W
         3V8Uc0xWwjbFj32PKIw5HpueCjVBqJU5CNfXQjfSwle/fpjAl3p7byqRe1fxEajP4Ez0
         bxoQ==
X-Gm-Message-State: APjAAAWdg+f3fYMHPmRgtLo79VahoYBaLUw6YaoL0f3LCZPQ3WcTjgqh
        PnNvq+lW6whqJhaRGjwtJA5OvSSKzXLZ34xkHc4=
X-Google-Smtp-Source: APXvYqx5nAla+aBg2s58R6P9M8eCSzkClyHCJwd6Bj1VXjffA9DqOj44ef9HCNuzprkzPa73zAHIHQAfQ17nHa4X7Eg=
X-Received: by 2002:a67:c995:: with SMTP id y21mr1910931vsk.143.1571319294249;
 Thu, 17 Oct 2019 06:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
 <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
 <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com> <CAEXMXLSkNXPYQtzLtnxTzeVAL5MvafsG1yUZHjn8Stg-UZyT=g@mail.gmail.com>
In-Reply-To: <CAEXMXLSkNXPYQtzLtnxTzeVAL5MvafsG1yUZHjn8Stg-UZyT=g@mail.gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Thu, 17 Oct 2019 15:34:41 +0200
Message-ID: <CAGm1_ksD6UDdW-3B4KkkoP1QYhp307YMyzf-GPx1Vu1oCFka+A@mail.gmail.com>
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

On Thu, Oct 17, 2019 at 11:19 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com> wr=
ote:
>
> Hi Yegor,
>
> I'm not sure if by your previous message you think I have some kind of
> hardware or DT issue or if this is being handled as a regression.

There were some upstreamed fixes recently. See commits [1], [2]. Also,
make sure DMA for OMAP-8250 driver is disabled. Let me know if RTS/CTS
is working as expected on am335x. See this discussion [3].

[1] https://marc.info/?l=3Dlinux-kernel&m=3D157037963426476&w=3D2
[2] https://marc.info/?l=3Dlinux-kernel&m=3D157037964726483&w=3D2
[3] https://marc.info/?l=3Dlinux-omap&m=3D157018333915769&w=3D2

Yegor

> Thanks,
> Nuno
>
> On Tue, Oct 1, 2019 at 11:03 PM Nuno Gon=C3=A7alves <nunojpg@gmail.com> w=
rote:
> >
> > Yes, I remember seeing those warnings.
> >
> > On Tue, Oct 1, 2019 at 10:02 PM Yegor Yefremov
> > <yegorslists@googlemail.com> wrote:
> > >
> > > Hi Nuno,
> > >
> > > On Sun, Sep 29, 2019 at 8:46 AM Nuno Gon=C3=A7alves <nunojpg@gmail.co=
m> wrote:
> > > >
> > > > I have since found that I am affected by two apparently different
> > > > regressions since 5.3.
> > > >
> > > > 4a96895f74c9633b51427fd080ab70fa62b65bc4 is only confirmed to affec=
t
> > > > me on a omap8250 where the issue is that there are a few char error=
s
> > > > every few seconds. I can't confirm if chars are added, removed or
> > > > changed, for now I only can confirm my state machine looses trackin=
g.
> > >
> > > Can you see kernel warnings about an overrun on OMAP UART?
> > >
> > > > I will make a separate report from the problem identified on sunxi.
> > > >
> > > > On Sat, Sep 28, 2019 at 7:59 AM Nuno Gon=C3=A7alves <nunojpg@gmail.=
com> wrote:
> > > > >
> > > > > On 32 bit arm platforms (am335x and sunxi) I get unexpected bytes=
 on
> > > > > serial ports after this commit.
> > > > >
> > > > > I use CTS (so: for input flow control).
> > > > >
> > > > > I've observed two different issues, one where I get just a few mi=
ssed
> > > > > or added bytes about once a minute, and another where I get total=
ly
> > > > > unexpected chars until I reopen the port.
> > > > >
> > > > > I will have a hard time to analyse and give a better description =
of
> > > > > how exactly the port is failing, so maybe you have a idea of what=
 is
> > > > > the issue with this patch.
> > > > >
> > > > > I've reverted this on top of 5.3.1 and consistently got the issue=
 fixed.
> > > > >
> > > > > Thanks,
> > > > > Nuno
> > > > >
> > > > > commit 4a96895f74c9633b51427fd080ab70fa62b65bc4
> > > > > Author: Yegor Yefremov <yegorslists@googlemail.com>
> > > > > Date:   Thu Jun 20 08:24:20 2019 +0200
> > > > >
> > > > >     tty/serial/8250: use mctrl_gpio helpers
> > > > >
> > > > >     This patch permits the usage for GPIOs to control
> > > > >     the CTS/RTS/DTR/DSR/DCD/RI signals.
> > > > >
> > > > >     Changed by Stefan:
> > > > >     Only call mctrl_gpio_init(), if the device has no ACPI compan=
ion device
> > > > >     to not break existing ACPI based systems. Also only use the m=
ctrl_gpio_
> > > > >     functions when "gpios" is available.
> > > > >
> > > > >     Use MSR / MCR <-> TIOCM wrapper functions.
> > > > >
> > > > >     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > > >     Signed-off-by: Stefan Roese <sr@denx.de>
> > > > >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.c=
om>
> > > > >     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com=
>
> > > > >     Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > > >     Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > >     Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > >     Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > >     Cc: Yegor Yefremov <yegorslists@googlemail.com>
> > > > >     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org=
>
