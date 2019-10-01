Return-Path: <SRS0=YMt1=X2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E8ECE587
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 20:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BB52133F
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 20:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TrzFS3dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJAUCr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:02:47 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34755 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfJAUCr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Oct 2019 16:02:47 -0400
Received: by mail-vs1-f67.google.com with SMTP id d3so10322747vsr.1
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2019 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=00oETwDebYpK8/nV7L0s5h+t6r8WFpQOYF0lxMgRn/M=;
        b=TrzFS3dv3FfqHY0u/FSqLiK8Ls/FXt+1QXqn6DO1XAZJlHeqokp2wZtpjifOImOKRY
         cDJ4nWS6v73xbXn8/0Iwc601xo+s69MXrwHvTesVqSxooxxlUfdunn77mhH5FSM9kLyQ
         Oz/yY3uoSPTxjwz8hTEhbjIy1apSeCI5qiA62tNdWCLZcDvGOlG5IsQ2K90IwYmBssBR
         Av+SGV9C1bYGzaDs7ibTF9MmuVe7Pjuvty9cY9YgQTP45j7xcOfvHWBfl2yv+CJRMXTO
         CdKT2NLfrwpusCniwUFJFZNVoAkZc8UnDfGPz0JMxE2IcMQHW3aYnu9Aaka/KS2rfN/U
         tM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=00oETwDebYpK8/nV7L0s5h+t6r8WFpQOYF0lxMgRn/M=;
        b=eJRG0FLTJFDiy5EeDufsP895AUFIo4HFb7qbwbfSw1MZawKzlqJT0xG7t1x9t65hJ+
         +AtY8cXlACOTg5256Lr3RVkHKAtUErbmK+uLPG18PSL/5ELdYMpRG8Em33V1nKznrDSj
         lMUYh2NR6zpNXDugaIjTNHuT2iAbR6bYM8iYbRs8/jmVPNxcZPjvoEHfYtBowuvD4onQ
         zPcSw3yTPxQhQsKEfVw90UoNkhxA5Lpfjmmxrp3amw9/nPDaOYbcvp/mD69Uzego7CBv
         LlFh0WhaomI6fL4WwI7z2ETSBZNsgDa651KVEV8TjCclGy3tiHcE+uW6esRFNMU9MIiw
         xzOA==
X-Gm-Message-State: APjAAAUVtiTHS+zFouuKkHXgIYg6WwZH09HNKuQ/vaL5pAJnyD2WO+x/
        xSnPaNyyz8SCE1MIGwYsqzrm5V2yP6ib/McwyAA=
X-Google-Smtp-Source: APXvYqw+sYO5n42/03XEONB7R7PJ3hZzQDKZW2lyOOdLbJfELUbAyvirCTySXUOlFhpRnNOMtDecPGUkRnerfVUrWMo=
X-Received: by 2002:a67:fe0b:: with SMTP id l11mr14098759vsr.68.1569960166327;
 Tue, 01 Oct 2019 13:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
In-Reply-To: <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Tue, 1 Oct 2019 22:02:35 +0200
Message-ID: <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
Subject: Re: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
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

Hi Nuno,

On Sun, Sep 29, 2019 at 8:46 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com> wro=
te:
>
> I have since found that I am affected by two apparently different
> regressions since 5.3.
>
> 4a96895f74c9633b51427fd080ab70fa62b65bc4 is only confirmed to affect
> me on a omap8250 where the issue is that there are a few char errors
> every few seconds. I can't confirm if chars are added, removed or
> changed, for now I only can confirm my state machine looses tracking.

Can you see kernel warnings about an overrun on OMAP UART?

> I will make a separate report from the problem identified on sunxi.
>
> On Sat, Sep 28, 2019 at 7:59 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com> w=
rote:
> >
> > On 32 bit arm platforms (am335x and sunxi) I get unexpected bytes on
> > serial ports after this commit.
> >
> > I use CTS (so: for input flow control).
> >
> > I've observed two different issues, one where I get just a few missed
> > or added bytes about once a minute, and another where I get totally
> > unexpected chars until I reopen the port.
> >
> > I will have a hard time to analyse and give a better description of
> > how exactly the port is failing, so maybe you have a idea of what is
> > the issue with this patch.
> >
> > I've reverted this on top of 5.3.1 and consistently got the issue fixed=
.
> >
> > Thanks,
> > Nuno
> >
> > commit 4a96895f74c9633b51427fd080ab70fa62b65bc4
> > Author: Yegor Yefremov <yegorslists@googlemail.com>
> > Date:   Thu Jun 20 08:24:20 2019 +0200
> >
> >     tty/serial/8250: use mctrl_gpio helpers
> >
> >     This patch permits the usage for GPIOs to control
> >     the CTS/RTS/DTR/DSR/DCD/RI signals.
> >
> >     Changed by Stefan:
> >     Only call mctrl_gpio_init(), if the device has no ACPI companion de=
vice
> >     to not break existing ACPI based systems. Also only use the mctrl_g=
pio_
> >     functions when "gpios" is available.
> >
> >     Use MSR / MCR <-> TIOCM wrapper functions.
> >
> >     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> >     Signed-off-by: Stefan Roese <sr@denx.de>
> >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >     Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> >     Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> >     Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >     Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> >     Cc: Yegor Yefremov <yegorslists@googlemail.com>
> >     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
