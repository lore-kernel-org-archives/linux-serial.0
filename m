Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A3C10F27
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 11:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650582051A
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 11:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEhO9+lH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCILPo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:15:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54369 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILPn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 07:15:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so5356771wmc.4;
        Mon, 09 Mar 2020 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Z9IntIaAH0gIeT3+u7wpsy0raBlZ5rU0UOJH1kx/N0=;
        b=fEhO9+lHjep+JjEc7uneYDDO1Ri2n5X4rLu0msbWHrfcEJqgwj9DhmiKriYDiubLiT
         qv53KMLQWdh0dcpQNfWct4l8BAN5EoKiDxpMBIpOotQxG5tDyY3UHKuvU5eexPsnE0yS
         sbhz0+n37JoEC2FCjVAm7CnL31Bzfch3QPsyyyaGlUYc8HhRNmEKtD143hbaBigob3ZZ
         kfkLzgP03LxK+JojSmpe4X7sOuXTScbKtYzUObY7+cmjeSDoUHA2qhYZtiC5bPRvrRf4
         QpUva4ZsnEVH86ZuGdN1BxxEUKfVjrVpRf4nPGCTWWfn5Zv2iY0CKNVNLEI7y3lKpNrr
         sinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Z9IntIaAH0gIeT3+u7wpsy0raBlZ5rU0UOJH1kx/N0=;
        b=kaV8kr8de9phBNh/ZhKUSqPdqLs0I1zw4QDlawg46gvJ9zTh46iHolVKFep+UgWP6d
         XXTkH5uu05aB8/2tir/OLC2qKFPkppIGzUaLjjtbieMb0cGX1EA3oCnGr8NxEBzUvlAv
         bBthz/mabHMoWivLvzyRhaSOHgXXLwHH5nEljTe9U2nX5At5usMx+Ey36lR0fmt+j7oE
         gTqL/yX5EciM7kWXkZXgWf63+yXkDsz7N4NYXOmzJ/46MslihxU0ACbN9rSZvArd1Lxj
         pr9+rf9GhFNh7RIhFC9iCQfLP1mxS4VKrkq5PzUzrO+Wc3LgXOZeE3hbCgnAdpPvVGB3
         vwyQ==
X-Gm-Message-State: ANhLgQ0m68++lQmg7BCHWAQqBus0jE+ipY2f8ERVhVR1C4Y7p5fVZnlV
        7ECOXA7f8yyKK2Dx0M2ee1zqmYGpajOzVyuCzfk=
X-Google-Smtp-Source: ADFU+vt6I91CwVNgM6NGjmlLea01N4tLsGPz6lgr4s6/6dSnTK0Eo+uQT+uUNJ7Qxquzez1kNQV5507pUbSD/R0ONSY=
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr5445439wmc.166.1583752541669;
 Mon, 09 Mar 2020 04:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <20200305103228.9686-2-zhang.lyra@gmail.com>
 <CAMuHMdU-gAhupHotQTHAZfopkGF_jQc-VrVxb24caw_BfzWd6g@mail.gmail.com>
 <CAAfSe-sonfA=6x9uvQXaHniQaXR8hWZa4uOcWxoo+Z_XT9QNhw@mail.gmail.com>
 <CAMuHMdUBkS+pPyPid2K=40jaTOSnAE_L-vJP5knmyVr8Fr5_hg@mail.gmail.com>
 <CAAfSe-uZSYZopDCGxQbGBQQ5+NZK6L79P+T62nfnL9CiZka++g@mail.gmail.com> <CAMuHMdXY5=QS4FA0T55_G=ARPs9V0NLbWwF3hd76rwO=8ahZbA@mail.gmail.com>
In-Reply-To: <CAMuHMdXY5=QS4FA0T55_G=ARPs9V0NLbWwF3hd76rwO=8ahZbA@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 9 Mar 2020 19:15:05 +0800
Message-ID: <CAAfSe-tbKVQX=796q-8vM=_B9JbDj0q9F514D3bG0+WMZ6Sacw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Mon, 9 Mar 2020 at 18:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Chunyan,
>
> On Mon, Mar 9, 2020 at 9:43 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > On Mon, 9 Mar 2020 at 16:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Mar 9, 2020 at 2:18 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > On Fri, 6 Mar 2020 at 20:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > >
> > > > > > Remove the dependency with ARCH_SPRD from sprd serial/console Kconfig-s,
> > > > > > since we want them can be built-in when ARCH_SPRD is set as 'm'.
> > > > >
> > > > > Why would you want a serial driver for a specific platform to be builtin,
> > > > > while all other platform support is modular?
> > > >
> > > > Oh, that's not this patch means.
> > > >
> > > > We just want serial driver can be builtin for any platform, so it
> > >
> > > What would be the benefit of the user to be able to have the SPRD serial
> > > driver built-in on any platform?  AFAIU, it supports only Spreadtrum
> > > platforms.
> >
> > Right, it does support Spreadtrum platforms only indeed.
> > Like I said on the replay to patch 1/2, simply because I want serial
> > driver can be builtin all the time, no matter ARCH_SPRD is m or y.
>
> OK.
>
> So shouldn't the dependency become
>
>     depends on ARCH_SPRD || ARCH_SPRD=m || COMPILE_TEST

Oh, right, this's better than just removing dependency to ARCH_SPRD,
but considering that this patch has been merged into Greg's tree, I
will post another patch to add this.

Thanks for your comments!
Chunyan

>
> instead, to avoid asking the question when you're not building a kernel
> plus modules for Spreadtrum platforms?
>
>
> > > > should not depend on a config which can be set as 'm' (i.e. ARCH_SPRD)
> > > > , otherwise if the config was set as 'm', the serial driver can't be
> > > > selected as 'y' then.
> > >
> > > I ask about that as a reply to PATCH 1/2.
> > >
> > > > That's what I mean.
> > >
> > > > > > --- a/drivers/tty/serial/Kconfig
> > > > > > +++ b/drivers/tty/serial/Kconfig
> > > > > > @@ -1452,7 +1452,6 @@ config SERIAL_MEN_Z135
> > > > > >
> > > > > >  config SERIAL_SPRD
> > > > > >         tristate "Support for Spreadtrum serial"
> > > > > > -       depends on ARCH_SPRD
> > > > > >         select SERIAL_CORE
> > > > > >         help
> > > > > >           This enables the driver for the Spreadtrum's serial.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
