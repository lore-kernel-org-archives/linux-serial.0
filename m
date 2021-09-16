Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC15BC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D896120C
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 08:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhIPI5Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:57:24 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:33502 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhIPI5W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Sep 2021 04:57:22 -0400
Received: by mail-vs1-f41.google.com with SMTP id p24so5490629vsg.0;
        Thu, 16 Sep 2021 01:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EQOzi6GoX/Ngw6/fSChQOM/x46HyAvx0gYxin2/a30=;
        b=IWOQAGjOqs4NAyVK8KpBI8yo8azPUub8f4mRBsZZRHxfiS5AVSFRVsdVmJBTaG2/ac
         nlpIdz+uOrrlZtn+WczOwkeQaNnCQQI+ZQGZvxaTygJ7/jMlOuUB3nGfR59vrl+QafCM
         kbkplTzgJqkc84iCiV/HZN8KY886Kr2yQhMLkNKdjwhMpy9YuJsgKrImGCg0D99y/TRw
         XP4KUzHK0UoG/vK6l/DhXlEGBcs4fRVwlylljlMBQOoOB7gv+EGEuEGvamVmXHBZ4/Cx
         avtRysraAC758MEjPngNcPzYxc2bM5yKxMcPvmVlgYrMz9iLeDppoVTSqNYa0I3LvsPv
         zHXg==
X-Gm-Message-State: AOAM530Oj0+9NfrqY15v6mQypf7yRrByrVGyWqFFj4YXe1OoBPNd64Fb
        XwRidD3Cdmfx2Bqs2Y8FRmxAtOJkx1kG6PWsOaw=
X-Google-Smtp-Source: ABdhPJyvOyxa/pmzGY2Bx+ipIQAdYpVoYfpJmNto/Se29JgkEW5BfsmTxPaq1OwYBhfxiruK4W7wSZsYRWnpM3+5lho=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr3281079vsl.9.1631782561209;
 Thu, 16 Sep 2021 01:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <c5f8aa5c081755f3c960b86fc61c2baaa33edcd9.1631710216.git.geert+renesas@glider.be>
 <YUMESxr907YHM3ZT@hovoldconsulting.com>
In-Reply-To: <YUMESxr907YHM3ZT@hovoldconsulting.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Sep 2021 10:55:49 +0200
Message-ID: <CAMuHMdX7_AOuGEjvTHpQ-4KHMH+m800KTu7wads6UTfMZiu9BQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: SERIAL_8250_FSL should not default to y
 when compile-testing
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Scott Wood <oss@buserror.net>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On Thu, Sep 16, 2021 at 10:46 AM Johan Hovold <johan@kernel.org> wrote:
> On Wed, Sep 15, 2021 at 02:56:52PM +0200, Geert Uytterhoeven wrote:
> > Commit b1442c55ce8977aa ("serial: 8250: extend compile-test coverage")
> > added compile-test support to the Freescale 16550 driver.  However, as
> > SERIAL_8250_FSL is an invisible symbol, merely enabling COMPILE_TEST now
> > enables this driver.
> >
> > Fix this by making SERIAL_8250_FSL visible.  Tighten the dependencies to
> > prevent asking the user about this driver when configuring a kernel
> > without appropriate Freescale SoC or ACPI support.
>
> This tightening is arguable a separate change which risk introducing
> regressions if you get it wrong and should go in a separate patch at
> least.

Getting it wrong would indeed be a regression, but not tightening
that at the same time would mean I have to send a separate patch with
a Fixes tag referring to this fix, following this template:

    foo should depend on bar

    The foo hardware is only present on bar SoCs.  Hence add a
    dependency on bar, to prevent asking the user about this driver
    when configuring a kernel without bar support.

> > Fixes: b1442c55ce8977aa ("serial: 8250: extend compile-test coverage")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Yes, it's ugly, but I see no better solution. Do you?
> >
> >  drivers/tty/serial/8250/Kconfig | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > index 808268edd2e82a45..a2978b31144e94f2 100644
> > --- a/drivers/tty/serial/8250/Kconfig
> > +++ b/drivers/tty/serial/8250/Kconfig
> > @@ -361,9 +361,13 @@ config SERIAL_8250_BCM2835AUX
> >         If unsure, say N.
> >
> >  config SERIAL_8250_FSL
> > -     bool
> > +     bool "Freescale 16550-style UART support (8250 based driver)"
> >       depends on SERIAL_8250_CONSOLE
> > -     default PPC || ARM || ARM64 || COMPILE_TEST
> > +     depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || (ARM64 && ACPI) || COMPILE_TEST
> > +     default FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || (ARM64 && ACPI)
>
> I'd suggest just doing
>
>         bool "Freescale 16550-style UART support (8250 based driver)"
>         depends on SERIAL_8250_CONSOLE
>         default PPC || ARM || ARM64
>
> Since neither of the symbols you add to that "depends on" line is an
> actual build or runtime dependency.

They are.

> Then you can refine the "default" line in a follow up (or argue why you
> think there should be a "depends on FSL_SOC || ...").
>
> > +     help
> > +       Selecting this option will add support for the 16550-style serial
> > +       port hardware found on Freescale SoCs.
> >
> >  config SERIAL_8250_DW
> >       tristate "Support for Synopsys DesignWare 8250 quirks"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
