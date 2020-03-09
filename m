Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769ABC10F27
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DAC20409
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 10:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCIKcj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:32:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38862 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCIKcj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 06:32:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id i14so9037566otp.5;
        Mon, 09 Mar 2020 03:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W04cd8gXdHqCmadUdyg5wxomjkoAadthvQ2P3gMSd+8=;
        b=VenxMpC4NJdiKmHAUl+WZItPzOKwfDxhxwZmqqx/Fiu4buEOTwBD3XJdR2B8eQCqE/
         XYg/XQrEVWKJuGTBtHa8tOw/YPZNGt6ymrRdvMM85Yp1/DbWIAK0LrL/gt3EVBlLI0R/
         mg7ulM3fATDKw5j4ruKbM+qSwO6xePcOGjfTRY1on+Bk+4V0Z/c5p4nUPR5Z39vspOyO
         Do4HIa1wtKT/iUWUtP5BdibDTx9Df74aHdT3ZqD7RRLO6UNeUtQrcegOT6S+c92f3xty
         5Q62TTOQQf6Xdo3TIXu9t3dMrCLBqf7c3at8e62B9VhrM5pkG1z3srcANX3kSUWvjzYb
         gPpg==
X-Gm-Message-State: ANhLgQ2F59feRebgmGH+riuRa5txRasqAYYs74SlMfRplJVjmJ8+lcj3
        2BHyW8CihIif/O1XUfyvz+E7rpctpt/NBtAfdnY=
X-Google-Smtp-Source: ADFU+vuVh6fkJGhu+5hmMbyrYecsnL9gWVa5R6t/lywxheWDLQwPc4My1fEjTIzo75HPjSFXa2cg380naqShaRyyTng=
X-Received: by 2002:a9d:1708:: with SMTP id i8mr10206182ota.250.1583749957218;
 Mon, 09 Mar 2020 03:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <20200305103228.9686-2-zhang.lyra@gmail.com>
 <CAMuHMdU-gAhupHotQTHAZfopkGF_jQc-VrVxb24caw_BfzWd6g@mail.gmail.com>
 <CAAfSe-sonfA=6x9uvQXaHniQaXR8hWZa4uOcWxoo+Z_XT9QNhw@mail.gmail.com>
 <CAMuHMdUBkS+pPyPid2K=40jaTOSnAE_L-vJP5knmyVr8Fr5_hg@mail.gmail.com> <CAAfSe-uZSYZopDCGxQbGBQQ5+NZK6L79P+T62nfnL9CiZka++g@mail.gmail.com>
In-Reply-To: <CAAfSe-uZSYZopDCGxQbGBQQ5+NZK6L79P+T62nfnL9CiZka++g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Mar 2020 11:32:25 +0100
Message-ID: <CAMuHMdXY5=QS4FA0T55_G=ARPs9V0NLbWwF3hd76rwO=8ahZbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chunyan,

On Mon, Mar 9, 2020 at 9:43 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> On Mon, 9 Mar 2020 at 16:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Mar 9, 2020 at 2:18 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > On Fri, 6 Mar 2020 at 20:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > >
> > > > > Remove the dependency with ARCH_SPRD from sprd serial/console Kconfig-s,
> > > > > since we want them can be built-in when ARCH_SPRD is set as 'm'.
> > > >
> > > > Why would you want a serial driver for a specific platform to be builtin,
> > > > while all other platform support is modular?
> > >
> > > Oh, that's not this patch means.
> > >
> > > We just want serial driver can be builtin for any platform, so it
> >
> > What would be the benefit of the user to be able to have the SPRD serial
> > driver built-in on any platform?  AFAIU, it supports only Spreadtrum
> > platforms.
>
> Right, it does support Spreadtrum platforms only indeed.
> Like I said on the replay to patch 1/2, simply because I want serial
> driver can be builtin all the time, no matter ARCH_SPRD is m or y.

OK.

So shouldn't the dependency become

    depends on ARCH_SPRD || ARCH_SPRD=m || COMPILE_TEST

instead, to avoid asking the question when you're not building a kernel
plus modules for Spreadtrum platforms?


> > > should not depend on a config which can be set as 'm' (i.e. ARCH_SPRD)
> > > , otherwise if the config was set as 'm', the serial driver can't be
> > > selected as 'y' then.
> >
> > I ask about that as a reply to PATCH 1/2.
> >
> > > That's what I mean.
> >
> > > > > --- a/drivers/tty/serial/Kconfig
> > > > > +++ b/drivers/tty/serial/Kconfig
> > > > > @@ -1452,7 +1452,6 @@ config SERIAL_MEN_Z135
> > > > >
> > > > >  config SERIAL_SPRD
> > > > >         tristate "Support for Spreadtrum serial"
> > > > > -       depends on ARCH_SPRD
> > > > >         select SERIAL_CORE
> > > > >         help
> > > > >           This enables the driver for the Spreadtrum's serial.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
