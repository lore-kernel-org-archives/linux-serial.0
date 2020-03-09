Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E234C10F28
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 08:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FBE21739
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 08:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avi03q8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCIIcp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:32:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34521 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCIIcp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 04:32:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so9881756wrl.1;
        Mon, 09 Mar 2020 01:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=af2cfZjf9x1S9FZ9MDXkYOztGP6qP0GOneEhB/eEIC0=;
        b=Avi03q8clgrFOrP5q3tRQewNL0Fw0MR443djbetfTNlO/BnS3HlkfETHL3Tu63qtNv
         gvsi9LD2DzFzpVf0OPveF87+GFgPH4S16hoDLA+KSBIhEpn+v56HrnhqkgWcnzwpcvs0
         xzcKX1XCRmZUfGbbDPLo5wyOzbQ6H8f6Ieo8y4XmMs+tN1NWsU8gvW4yOLLK39rBcji8
         yqan3UVUJ9K/wW4TknQtHZ5r/iuBzOqAxVNMQHHG8VtjKlnfOv0OHlqVW595w/AWK7rP
         K2D6GjaTeqgQ6o99g8I6aOPQ/Jbc/HVZlJ24l+VrsYYumIbiXLL69FiR7dwrVhrCGWsC
         kPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=af2cfZjf9x1S9FZ9MDXkYOztGP6qP0GOneEhB/eEIC0=;
        b=VYSlpNIpbYAHLoBXH8xo4ZEkAfJLL5mMqJPMOzLrc1ESKzVfkWR5a+fafBD0RL6Sh7
         06nUmTPz4c55lpQJTcWPOstMmrlPjtbh/l+ElrLu9eCVWIQNF1di/1e66kOcGUxNCf4Y
         M95ShbbJgPPOINe//wf8f1gWM8akl/0yNswkVu//WtipLZNEQ1lZ7LtkASiEQ69lfFe1
         x9WZxU+Eg6ZxTox+RqpdgMw4i/Leu9TJgAxc7jN76q9zdzTWnfChjOHKPMniYVBlkzI4
         Ot7Gh7Qk5VWaBMJZIWNPILPEBO8Zu1FVGACmPHYZix4r2CBh3VL9VZp086hYOUHVrX5j
         YD2g==
X-Gm-Message-State: ANhLgQ3AsJhxXh1DWLyz+SV+p2SKcUyaWPShI/LTHwWyqk2L/MIpCRsH
        Aw1bvCjGsrp0arfY/lc4QkIbMiSzJz1ZlUrX/RY=
X-Google-Smtp-Source: ADFU+vse2mrhpQWQ46FGqAThVW5dYVYVNTdtnUQxbnZFtx6sP4gIg5N4+80B7pi4VKVVc7UzQq04sWlnL39gJJ/hXbs=
X-Received: by 2002:adf:e408:: with SMTP id g8mr20764712wrm.198.1583742761475;
 Mon, 09 Mar 2020 01:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
In-Reply-To: <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 9 Mar 2020 16:32:04 +0800
Message-ID: <CAAfSe-spu2oNmfEYt+WQvRQy1bCC0e1MFjbUyBAFzghd5XNBfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: change ARCH_SPRD Kconfig to tristate
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Mon, 9 Mar 2020 at 16:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Chunyan.
>
> On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > The default value of Kconfig for almost all sprd drivers are the same with
> > ARCH_SPRD, making these drivers built as modules as default would be easier
> > if we can set ARCH_SPRD as 'm', so this patch change ARCH_SPRD to tristate.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Can you actually boot a kernel on a Spreadtrum platform when all platform
> and driver support is modular?

Yes, even if all drivers are modular.
But I hope serial can be builtin, then I can have a console to see
kernel output before loading modules.
Also, this's what Google GKI [1] asked :)

Regards,
Chunyan

[1] https://arstechnica.com/gadgets/2019/11/google-outlines-plans-for-mainline-linux-kernel-support-in-android/

>
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -249,7 +249,7 @@ config ARCH_TEGRA
> >           This enables support for the NVIDIA Tegra SoC family.
> >
> >  config ARCH_SPRD
> > -       bool "Spreadtrum SoC platform"
> > +       tristate "Spreadtrum SoC platform"
> >         help
> >           Support for Spreadtrum ARM based SoCs
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
