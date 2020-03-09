Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC3C10F27
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF5220727
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYDWaVXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCIOLB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:11:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34456 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCIOLB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 10:11:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id i19so1889086lfl.1;
        Mon, 09 Mar 2020 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DONZyJhzIw61vc2b8VyfHEnmtSL8XmCoaWpkr0Q6yQ=;
        b=ZYDWaVXI+O+RUpYxYfXm8ia4oOLkw/O+R89i+fHtsyE7gL+aPkvQ6/74KlAZ7upBOy
         mVkW/vEl9ymGQtMH96WKfn9Hl9vP2enpx2WSUQVt5eNiOZcBSPMGvWaD1xhAx24j218x
         TssPVDmyorIu6yhB4IZASsU3vvyEwVPLv2jnnokvy9Y5/c7QhkrdURMMpyYom7hAAf83
         0+1LWvmFyikllT7rr9CQOxn7hYse57X0T2WNRzV76ixDvKlEOO/B3d2skZ4yPNRtbbPT
         BMfcq/IX+sZXcbLGV2NFlvHPnT/i864dbduIhTa+QK+inCG7Vr8hhA627LXSrkzIyzMl
         Pcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DONZyJhzIw61vc2b8VyfHEnmtSL8XmCoaWpkr0Q6yQ=;
        b=IX+ZH8980MnJmLCrj/u0QfGrR/1yXcamX1onMf+PcogmqlX6c1P7k3qtyFEhDrEK2v
         Cte+YEAK9oymvKWTagb0Qnzkw2O54zSDIkb8h1aUZINjia9XfW5KjfGS1vCWh4vml+no
         cBMxLzCQ4Ty54y6Mtsy4JA8m4J7IAO8aLLPAWaLi2J+SIrbmnUXwMvH6FXd3lsQe975O
         c79p+QgfX/XlPhM9u3NZ5w1N3uB7DEZwxw0i94+Tq5KBULL5E5qYfLK5UbOmOg68k/66
         zkg/9l6QjhD4v7/Hyw65CtMMsJBixvuLk/u00XoCrsiUBWNx20yNktQrHdg7n97Sj0+m
         5bZg==
X-Gm-Message-State: ANhLgQ14T1ZLB6as7KimGcQkNAl9MJMW5G1nhlBFLbj8TlXWJr04/R2F
        AxlSbpQ3mu4LQeulZ6z5YZYWVIqxw9wW5keuuBM=
X-Google-Smtp-Source: ADFU+vvx9Zry9HVFrw2gJwvh8jIGcVMrga/iTAAcWL9fq/CZaQKdL1vmx4qaRTpNg/N7VZXOUKv1Ct6BP9Ehy3e7OIY=
X-Received: by 2002:ac2:5328:: with SMTP id f8mr9426587lfh.47.1583763059624;
 Mon, 09 Mar 2020 07:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <20200305103228.9686-2-zhang.lyra@gmail.com>
 <CAMuHMdU-gAhupHotQTHAZfopkGF_jQc-VrVxb24caw_BfzWd6g@mail.gmail.com>
 <CAAfSe-sonfA=6x9uvQXaHniQaXR8hWZa4uOcWxoo+Z_XT9QNhw@mail.gmail.com> <CAMuHMdUBkS+pPyPid2K=40jaTOSnAE_L-vJP5knmyVr8Fr5_hg@mail.gmail.com>
In-Reply-To: <CAMuHMdUBkS+pPyPid2K=40jaTOSnAE_L-vJP5knmyVr8Fr5_hg@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Mon, 9 Mar 2020 22:10:41 +0800
Message-ID: <CA+H2tpFBDSGfwYT--G_FsaEceNJW_xBJjjiSMnhZDVhZamj_QQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,


On Mon, Mar 9, 2020 at 4:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
>
Assume there is a all-in-one common kernel binary image say arm64 for
all SoC platform and all
device drivers are built as modules from different vendors for each
specific devices.
But for serial driver it is too late to be initialized as a module if
users want to check early console log.
At this circumstance vendors prefer to set their serial driver to be
built into that all-in-one image as easy
as to only set one config instead of enabling whole platform then
disabling many out of serial.

-Orson

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
