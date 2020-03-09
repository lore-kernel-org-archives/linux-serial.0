Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E568CC10F27
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 08:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72732083E
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlsaYbna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgCIIn0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:43:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38639 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgCIIn0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 04:43:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id t11so9903415wrw.5;
        Mon, 09 Mar 2020 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dyCaH2EW2/yhe02ff2ihoVbT2xLpKUPZBSJ5O6aTkg=;
        b=UlsaYbnawVwWDoz+SC65neHjnGA3JlFL/BKjzfb3XdecPlJ2q7iXUj/m/CxgL57NwA
         jkWqz4tevZEOYjaAKDASvUCxSrjr2VGEDYyqmAJT+xLeUAb7y7hFIdq6vcduvAJF1RD/
         AKgUtUptLfZUX1zAWluUCPjpqamMBz0lTYkk7hsggrYjyAKvtyFun7n0Tz6hgN/xRgr5
         DCQovat/CwPRfdWIMRfI+WLcX7mmsXk6U+2+bu+clngAvEjOx44jOhlPftJSnReNLhVK
         GYm0MQIS8hdy0fIfwcdQD8cvkgSEuiH1MD+0ro5qMKUgEBdSiJvu0rCWzztJaau7ym76
         sQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dyCaH2EW2/yhe02ff2ihoVbT2xLpKUPZBSJ5O6aTkg=;
        b=I/Jk8m+gkurHPxrTMRGm/864g7Wbz2tDR9ZMFlguex/D1EbD350Na7T5ixy83sGGbn
         jPevE/shyO87DNMjzWtzZL8grnzdrjxZVAIrtQ05qtr9lkYCEzSaeNFFoLQZzHl5/K+l
         2nFePOs96diM0OgA14ufbjdJAMZYz9J8u0KJIB7mJ6dnXBYj3Pifk0RSuC3L25LzBHuG
         9us2kGxpRvrB1xYKGjHq3EBvREkMMKEZuTbaOwWSIybnG2KJbj7FLXvaRA9IPqdDyxti
         41giYkZA/o6q7Z6HLEMKfNzMc7t0W0ncxXDhNyO/AwPZKYt/NjK2N4o+j7jdheJs1SuD
         K9Qg==
X-Gm-Message-State: ANhLgQ2sD+1sDYKv3Tcd3mF9Z6pzWhnlmc9N0YlapdfvgwvVD4KyiMiM
        OQ4OOYqvGDGeSgI3rvEWKQL1omOUDooTlHlw7LW1vw==
X-Google-Smtp-Source: ADFU+vshR/9K1P4joj1qyXF1zngyt9MyksUpJP02ZOzlb7IUD8H4JCMFkF32Q2elfFLlWVYTyw6IrnLfB2TayQgWuk4=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr19960796wrs.370.1583743404409;
 Mon, 09 Mar 2020 01:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <20200305103228.9686-2-zhang.lyra@gmail.com>
 <CAMuHMdU-gAhupHotQTHAZfopkGF_jQc-VrVxb24caw_BfzWd6g@mail.gmail.com>
 <CAAfSe-sonfA=6x9uvQXaHniQaXR8hWZa4uOcWxoo+Z_XT9QNhw@mail.gmail.com> <CAMuHMdUBkS+pPyPid2K=40jaTOSnAE_L-vJP5knmyVr8Fr5_hg@mail.gmail.com>
In-Reply-To: <CAMuHMdUBkS+pPyPid2K=40jaTOSnAE_L-vJP5knmyVr8Fr5_hg@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 9 Mar 2020 16:42:48 +0800
Message-ID: <CAAfSe-uZSYZopDCGxQbGBQQ5+NZK6L79P+T62nfnL9CiZka++g@mail.gmail.com>
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

Hi Geert,

On Mon, 9 Mar 2020 at 16:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Chunyan,
>
> On Mon, Mar 9, 2020 at 2:18 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > On Fri, 6 Mar 2020 at 20:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > Remove the dependency with ARCH_SPRD from sprd serial/console Kconfig-s,
> > > > since we want them can be built-in when ARCH_SPRD is set as 'm'.
> > >
> > > Why would you want a serial driver for a specific platform to be builtin,
> > > while all other platform support is modular?
> >
> > Oh, that's not this patch means.
> >
> > We just want serial driver can be builtin for any platform, so it
>
> What would be the benefit of the user to be able to have the SPRD serial
> driver built-in on any platform?  AFAIU, it supports only Spreadtrum
> platforms.

Right, it does support Spreadtrum platforms only indeed.
Like I said on the replay to patch 1/2, simply because I want serial
driver can be builtin all the time, no matter ARCH_SPRD is m or y.

Regards,
Chunyan

>
> > should not depend on a config which can be set as 'm' (i.e. ARCH_SPRD)
> > , otherwise if the config was set as 'm', the serial driver can't be
> > selected as 'y' then.
>
> I ask about that as a reply to PATCH 1/2.
>
> > That's what I mean.
>
> > > > --- a/drivers/tty/serial/Kconfig
> > > > +++ b/drivers/tty/serial/Kconfig
> > > > @@ -1452,7 +1452,6 @@ config SERIAL_MEN_Z135
> > > >
> > > >  config SERIAL_SPRD
> > > >         tristate "Support for Spreadtrum serial"
> > > > -       depends on ARCH_SPRD
> > > >         select SERIAL_CORE
> > > >         help
> > > >           This enables the driver for the Spreadtrum's serial.
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
