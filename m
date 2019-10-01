Return-Path: <SRS0=YMt1=X2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A24BC352AA
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 21:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B58A2133F
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 21:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiZv8kIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfJAVEK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:04:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43858 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJAVEK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Oct 2019 17:04:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so17147301wrx.10
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2019 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IKxwNKVCGoOFq7PLTyZUaq0OWsFWc0xSZ20qMEmvp58=;
        b=iiZv8kIAadf8BZobX5ql33GEntRG0PJax5hsu6/AoOq4lmM9MlRikucZQYcx1/Fr0c
         uYS0HsJ2ALG1U3DHLaHMc5l+ODfW0v83x0G5KU9L2AQG8rTakIR4P1D+uTcoDpwLmTJL
         W1p6QWmpZNBDxI7YqbqpEspAUkDqH3JnK22fA/3lv98sIY96e5Gy5MibdIABVSOeFFAD
         XbCe6JTpVRTHQQlttu357hkFR0iNs83SGjYRZ7PA8882FPk5mE4kFUkwsg49FAS7+feA
         1utLi56mm3oe7VoP7ESgErqg47WiIJ9tn7xvazm0kq6AXXllfS9vX/XjrNipzhnTmJht
         +5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IKxwNKVCGoOFq7PLTyZUaq0OWsFWc0xSZ20qMEmvp58=;
        b=s5AXbcCtNXWjkQCd0DFsiZATDyzP9miwZn144+Vcm3obagnp3oHmyi9n7XNy23KI2s
         l+ZW+DRhhpk3PpMM12cPJLaWitnNvVSELPGwtZV2Ux3ZlT55UmVcBhRmwlTLVB7oM5Pe
         xNNYrv1LMiFWaCTl4KcY5LUqhZf7LvSz1VWgbNtVmbXl8WcuR9HQ6EFfSKKEmcVwxGS/
         Wtz6xNAQ6fCa+DC6s4UEVtPA6M99pAUQfXSz4PavBXslhw6lLZnBfc6l4xOfi6rvZkIg
         AnrhVq5dcM9/c6jFN19a2CTzm0csSe49fi24p3RQIbVe06a8fOaPWZ3k1HfvgF40fYRw
         FkGQ==
X-Gm-Message-State: APjAAAVnhTa5Hz8tRUYC6G+7gPFWd/Lsu9w11yqWVY6zvDXV+NM384Zx
        4+PesrX5gZ+8lZ36VZQVjrT+wjxSK7l//q02qeU=
X-Google-Smtp-Source: APXvYqyxgrMIEtKlhJi0cOwNXL0p1u7LYvMGd72B4HfGu8aO1veGRrDrsa8SamqAWhoNzpc9N16Qk1kv7Yih6SBUq+0=
X-Received: by 2002:a5d:428d:: with SMTP id k13mr19486608wrq.305.1569963846364;
 Tue, 01 Oct 2019 14:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com> <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
In-Reply-To: <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Tue, 1 Oct 2019 23:03:55 +0200
Message-ID: <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com>
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

Yes, I remember seeing those warnings.

On Tue, Oct 1, 2019 at 10:02 PM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> Hi Nuno,
>
> On Sun, Sep 29, 2019 at 8:46 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com> w=
rote:
> >
> > I have since found that I am affected by two apparently different
> > regressions since 5.3.
> >
> > 4a96895f74c9633b51427fd080ab70fa62b65bc4 is only confirmed to affect
> > me on a omap8250 where the issue is that there are a few char errors
> > every few seconds. I can't confirm if chars are added, removed or
> > changed, for now I only can confirm my state machine looses tracking.
>
> Can you see kernel warnings about an overrun on OMAP UART?
>
> > I will make a separate report from the problem identified on sunxi.
> >
> > On Sat, Sep 28, 2019 at 7:59 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com>=
 wrote:
> > >
> > > On 32 bit arm platforms (am335x and sunxi) I get unexpected bytes on
> > > serial ports after this commit.
> > >
> > > I use CTS (so: for input flow control).
> > >
> > > I've observed two different issues, one where I get just a few missed
> > > or added bytes about once a minute, and another where I get totally
> > > unexpected chars until I reopen the port.
> > >
> > > I will have a hard time to analyse and give a better description of
> > > how exactly the port is failing, so maybe you have a idea of what is
> > > the issue with this patch.
> > >
> > > I've reverted this on top of 5.3.1 and consistently got the issue fix=
ed.
> > >
> > > Thanks,
> > > Nuno
> > >
> > > commit 4a96895f74c9633b51427fd080ab70fa62b65bc4
> > > Author: Yegor Yefremov <yegorslists@googlemail.com>
> > > Date:   Thu Jun 20 08:24:20 2019 +0200
> > >
> > >     tty/serial/8250: use mctrl_gpio helpers
> > >
> > >     This patch permits the usage for GPIOs to control
> > >     the CTS/RTS/DTR/DSR/DCD/RI signals.
> > >
> > >     Changed by Stefan:
> > >     Only call mctrl_gpio_init(), if the device has no ACPI companion =
device
> > >     to not break existing ACPI based systems. Also only use the mctrl=
_gpio_
> > >     functions when "gpios" is available.
> > >
> > >     Use MSR / MCR <-> TIOCM wrapper functions.
> > >
> > >     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > >     Signed-off-by: Stefan Roese <sr@denx.de>
> > >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >     Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> > >     Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >     Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >     Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > >     Cc: Yegor Yefremov <yegorslists@googlemail.com>
> > >     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
