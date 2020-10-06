Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144DCC4727E
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C2320853
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 08:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgJFIiY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 04:38:24 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:39735 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJFIiY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 04:38:24 -0400
Received: by mail-oo1-f66.google.com with SMTP id c4so2996791oou.6;
        Tue, 06 Oct 2020 01:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkyFSVeXPFcsbuoieeW0AUnHq5y84+TIhXt/1+fuFLg=;
        b=cK6h4Anqa0Qh61h0YPNeYzo1WEyJp6bBawNeUMXkA479q6ekTan5hf8GEbVWElvSYE
         ntK00lj4YXqcWG8j+/3QYaH8JKPS8e9VTHE33cFsUkxxFTyZ40qjAQBHouOYPKArd/Rc
         JXROiQJshdRtsa+DkD4/712Tdpxj5j9QaHnV+nBH++/xJjY0SIJkfNBRilmcxxDNw2x6
         CFFZQJUCJbHCFQ1OWfYC8BNGGVQFwgGjAwwsU0NbbwxDircwusnTOkkPpgzXyiHkVYpx
         H2WCJyr9RhU4oOulm+UE5eAW/+CzvL9nPX81UodiJQk06bXZVmYCdhjXYYhLaj/P8CYJ
         BpDw==
X-Gm-Message-State: AOAM532BJPQ/iBP81egM7VjodsRA+pKxBEUB0os1+EMDwh3eS7oNPmTL
        cUEcX8rskaw9x6yLgvg7NoqEgdnv8x8lHFij10Y=
X-Google-Smtp-Source: ABdhPJxKTdpVt2S29hcgjSF7YwOIEIpSgvR01nL/7DU7cwnmD5WMdO5cvi7neBjVDf6QrDPfqECOAzeUzfznhiANCFg=
X-Received: by 2002:a4a:4f17:: with SMTP id c23mr2463324oob.11.1601973519305;
 Tue, 06 Oct 2020 01:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com>
 <20200923120817.1667149-3-mholenko@antmicro.com> <CAMuHMdUBCf8DsRBvXxxrfrQsab3kOwy95u-KwkdvaSY0vXQnXQ@mail.gmail.com>
 <CAPk366TxFJa-rqY6eFoGuMoc_r_=CFQgDMC-j2Pv0=dUR06b9A@mail.gmail.com>
In-Reply-To: <CAPk366TxFJa-rqY6eFoGuMoc_r_=CFQgDMC-j2Pv0=dUR06b9A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Oct 2020 10:38:28 +0200
Message-ID: <CAMuHMdUXxGGHmsUNhuwGPOk1horTs9OWSZa2u0B4pb8zTuUw-Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Mateusz,

On Tue, Oct 6, 2020 at 10:02 AM Mateusz Holenko <mholenko@antmicro.com> wrote:
> On Fri, Sep 25, 2020 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Sep 23, 2020 at 12:10 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > >
> > > This commit adds driver for the FPGA-based LiteX SoC
> > > Controller from LiteX SoC builder.
> > >
> > > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

> > > --- /dev/null
> > > +++ b/drivers/soc/litex/Kconfig
> > > @@ -0,0 +1,15 @@
> > > +# SPDX-License_Identifier: GPL-2.0
> > > +
> > > +menu "Enable LiteX SoC Builder specific drivers"
> > > +
> > > +config LITEX_SOC_CONTROLLER
> > > +       tristate "Enable LiteX SoC Controller driver"
> > > +       depends on OF || COMPILE_TEST
> > > +       help
> > > +         This option enables the SoC Controller Driver which verifies
> > > +         LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > > +         accessors.
> > > +         All drivers that use functions from litex.h must depend on
> > > +         LITEX_SOC_CONTROLLER.
> >
> > I'm wondering if it makes sense to have them depend on a "simpler"
> > symbol instead, e.g. LITEX?
> >
> > Currently the SoC controller is limited to I/O accessors and a simple
> > register compatibility check, but you may want to extend it with more
> > features later, so you probably want to keep the LITEX_SOC_CONTROLLER.
> > Hence you could add
> >
> >     config LITEX
> >         bool
> >
> > and let LITEX_SOC_CONTROLLER select LITEX.
>
> But then if other drivers depend just on LITEX, it would not automatically
> mean that the LITEX_SOC_CONTROLLER is selected, right?. And if it's not selected
> litex_{g,s}et_reg() are not available and the compilation would fail.

As the LITEX config symbol above uses plain "bool", without a
description, it is invisible.  Hence it cannot be enabled by the user,
only be selected by other symbols.
If LITEX_SOC_CONTROLLER is the only symbol selecting LITEX, the
dependency is met.

> I could move the implementation of those functions directly to the
> litex.h header
> and avoid this KConfig dependency, but I'm not sure if they are not
> too big to become a static inline.
> What do you think?

With the spinlock and the loop, they're too large to be inlined, IMHO.

> > > --- /dev/null
> > > +++ b/drivers/soc/litex/litex_soc_ctrl.c

> > > + */
> > > +#define LITEX_REG_SIZE             0x4
> > > +#define LITEX_SUBREG_SIZE          0x1
> > > +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> > > +
> > > +static DEFINE_SPINLOCK(csr_lock);
> > > +
> > > +/*
> > > + * LiteX SoC Generator, depending on the configuration,
> > > + * can split a single logical CSR (Control & Status Register)
> > > + * into a series of consecutive physical registers.
> > > + *
> > > + * For example, in the configuration with 8-bit CSR Bus,
> > > + * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
> > > + * logical CSR will be generated as four 32-bit physical registers,
> > > + * each one containing one byte of meaningful data.
> > > + *
> > > + * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> > > + *
> > > + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> > > + * the logic of writing to/reading from the LiteX CSR in a single
> > > + * place that can be then reused by all LiteX drivers.
> > > + */
> > > +void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> > > +                   unsigned long val)
> > > +{
> > > +       unsigned long shifted_data, shift, i;
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&csr_lock, flags);
> > > +
> > > +       for (i = 0; i < reg_size; ++i) {
> > > +               shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > > +               shifted_data = val >> shift;
> > > +
> > > +               writel((u32 __force)cpu_to_le32(shifted_data), reg + (LITEX_REG_SIZE * i));
> > > +       }
> > > +
> > > +       spin_unlock_irqrestore(&csr_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(litex_set_reg);
> >
> > I'm still wondering about the overhead of loops and multiple accesses,
> > and the need for them (see also BenH's earlier comment).
> > If e.g. the register widths change for LiteUART (currently they're
> > hardcoded to one), would you still consider it using the same
> > programming interface, and thus compatible with "litex,liteuart"?
>
> Since the amount of possible `reg_size` is practically limited we could
> add explicit 8/32/64/128 accessors to eliminate loops.

Good.

(assuming 32-bit physical reg accesses below)

> As for multiple writel/readl I don't really see an option to avoid
> them for the 8-bit bus width.

Sure, 64-bit register accesses consist of two 32-bit accesses on other
32-bit platforms, too.

> > The spinlock access will probably become the source of lock contention
> > later, especially when considering SMP variants.
>
> Do you have any suggestions on how to handle this?
> Dropping locks could lead to the situation when two cores write at the
> same time leaving a wrong (mixed) value in the CSR.

Is this due to the CSR bus or due to the CSR register?
I mean can two 64-bit accesses to different CSR registers be done as
four interleaved 32-bit accesses, or must they not be interleaved?

If (hopefully) they can be interleaved, you just need serialization of
accesses to the same 64-bit register.  As the same register is usually
not accessed from multiple drivers, you can handle the serialization
inside the driver, if it can ever happen at all (e.g. main driver
operation and interrupt handler accessing the same register).
That avoids the need for the spinlock in the generic register accessors.

If they must not be interleaved, you indeed need serialization at the
bus level, but only for the 64-bit accesses?  And I would strongly
suggest to look into changing the CSR bus behavior at the hardware
level, if possible...

> > > +/*
> > > + * Check LiteX CSR read/write access
> > > + *
> > > + * This function reads and writes a scratch register in order
> > > + * to verify if CSR access works.
> > > + *
> > > + * In case any problems are detected, the driver should panic.
> > > + *
> > > + * Access to the LiteX CSR is, by design, done in CPU native
> > > + * endianness. The driver should not dynamically configure
> > > + * access functions when the endianness mismatch is detected.
> > > + * Such situation indicates problems in the soft SoC design
> > > + * and should be solved at the LiteX generator level,
> > > + * not in the software.
> > > + */
> > > +static int litex_check_csr_access(void __iomem *reg_addr)
> > > +{
> > > +       unsigned long reg;
> > > +
> > > +       reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> > > +
> > > +       if (reg != SCRATCH_REG_VALUE) {
> > > +               panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> > > +                       SCRATCH_REG_VALUE, reg);
> >
> > Do you think the user will ever see this panic message? (see below)
>
> On UART most probably not, as broken CSRs mean broken UART driver as well.
> But I believe you can retrieve logs from the memory and analyze them
> post-mortem, isn't that right?

Sure. Been there, done that ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
