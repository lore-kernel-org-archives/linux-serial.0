Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EB4C10F27
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 08:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B4220728
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 08:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIIDW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:03:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35604 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIIDW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 04:03:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id c1so9270934oiy.2;
        Mon, 09 Mar 2020 01:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlxhLCzBWLBcTK+nyEBCaSV9wLdQnn+A1WWbazSD9FQ=;
        b=rPFL2MfES7IiWTY8Bsaxd5pvF6mnvHWFxpvFJvlFP2W3KbqonEv2RoQS7v+IFFFpgd
         Wssv4CpZOjWf9oeNB7NLlyARb1vOKPVF3piObGyKcYhAKmvJYYXdT9WaEpyOH46aKX2l
         qsYuWNPsTEI01BU0Em+ssRcmA+5h2fY16mxJrxDf39jpo8VvpzcLM46RT4YRPIRVVLGJ
         j/JbyZRrD6crUlLoopxQbDJ9Noznm6oQVCSLlKmeAP+tsYDT4ztNBq6hPJ7ygFN7OrfJ
         WQG1cVgs7y3bg3UnAK90Z/ZXG/N8Ljew/WOpk7/dBKlW578b4JWvFxY3zTnr98ev0yV8
         pE/w==
X-Gm-Message-State: ANhLgQ3DJbfB5Eu9OGpBXKvdgoTkw8A6POBTgSj9yBb9TXs7CW8Pcnqe
        ljF1FYhGoxrLMwfoXOXJB/G1ynSxNu6OSugTjWg=
X-Google-Smtp-Source: ADFU+vsEnvEXz092Ba8rHTDMlFV+mJV7f1t+H+q6yO9aRXpnLYyqXDaEvw5trHzcZDuV1wPX+OKtcn4+88iZFeSMFyk=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr10074950oia.148.1583741001068;
 Mon, 09 Mar 2020 01:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com>
In-Reply-To: <20200305103228.9686-1-zhang.lyra@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Mar 2020 09:03:09 +0100
Message-ID: <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: change ARCH_SPRD Kconfig to tristate
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

Hi Chunyan.

On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> The default value of Kconfig for almost all sprd drivers are the same with
> ARCH_SPRD, making these drivers built as modules as default would be easier
> if we can set ARCH_SPRD as 'm', so this patch change ARCH_SPRD to tristate.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Can you actually boot a kernel on a Spreadtrum platform when all platform
and driver support is modular?

> +++ b/arch/arm64/Kconfig.platforms
> @@ -249,7 +249,7 @@ config ARCH_TEGRA
>           This enables support for the NVIDIA Tegra SoC family.
>
>  config ARCH_SPRD
> -       bool "Spreadtrum SoC platform"
> +       tristate "Spreadtrum SoC platform"
>         help
>           Support for Spreadtrum ARM based SoCs

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
