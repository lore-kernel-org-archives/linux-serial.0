Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F939C10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A02084E
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgCFMl0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:41:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46451 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCFMlZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 07:41:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id a22so2333545oid.13;
        Fri, 06 Mar 2020 04:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7/8UfpcQCiN90TR5rRqxibvlhXF5Mt2BA1c7KeP18M=;
        b=Jvy1Af74iMiqRleNjcT1vAEE4fmVK1Wz6t+x70h4GgyrFDTD1wBWKlPRNp2/Dr24Ys
         DcVxlQpwZTqlIDXiwZAVjaEKXODo9Z31ZlcjYt5Rp9t377lqPxD4YBVTfSlUkXhfl+mB
         kFGQ9mparWndpuOfehbj3FOKFkv8OxXayh55mcf7VcH/4Qn3FtLY5223/frbq4M2N+WZ
         hwmLal7mVPdvh+kDoUXzeo1ip0Ur4/WYugltyY4tGsEzZsZ+5FCrD0NoBMTqN26TjfX2
         9Vc7pw+oPNr+MkgQ5cuj9LDFcyPGegZTql0vQjEWwZZKgyOkjMoOH/t0fzeXytnt7UA+
         rQmQ==
X-Gm-Message-State: ANhLgQ06y5ozGBWv6vr6UJcAyVYzw+fiLI72IZ6YhdOBARfc/RfR0/T2
        wTqoEYbJTgVCy/Q4MMXq7qTmr8t2DtJWpF+kkWw=
X-Google-Smtp-Source: ADFU+vvFX93FQt/K5Y/NK1W5n/Rkjy+IGlDMjymnBd+wtV2G0VFU7RzvCgKX4HHOXk86z4FvGXCbRuKcufXWvp0EUZE=
X-Received: by 2002:aca:ac4c:: with SMTP id v73mr2492413oie.102.1583498483747;
 Fri, 06 Mar 2020 04:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <20200305103228.9686-2-zhang.lyra@gmail.com>
In-Reply-To: <20200305103228.9686-2-zhang.lyra@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Mar 2020 13:41:11 +0100
Message-ID: <CAMuHMdU-gAhupHotQTHAZfopkGF_jQc-VrVxb24caw_BfzWd6g@mail.gmail.com>
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

On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Remove the dependency with ARCH_SPRD from sprd serial/console Kconfig-s,
> since we want them can be built-in when ARCH_SPRD is set as 'm'.

Why would you want a serial driver for a specific platform to be builtin,
while all other platform support is modular?

> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 52eaac21ff9f..2b9addc0afb5 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1452,7 +1452,6 @@ config SERIAL_MEN_Z135
>
>  config SERIAL_SPRD
>         tristate "Support for Spreadtrum serial"
> -       depends on ARCH_SPRD
>         select SERIAL_CORE
>         help
>           This enables the driver for the Spreadtrum's serial.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
