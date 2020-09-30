Return-Path: <SRS0=IvhS=DH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA53C2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 30 Sep 2020 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C86D2075F
	for <linux-serial@archiver.kernel.org>; Wed, 30 Sep 2020 07:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgI3Hce (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:32:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44324 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Hcd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Sep 2020 03:32:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id 185so668194oie.11;
        Wed, 30 Sep 2020 00:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Di7RoKxtlCsHNqdu2fUShJ/bb3qkgNCgnSZuxvsrITE=;
        b=Sb9iRtI8J3/HZ4WG2SnZxzScPj6PvsSmdlgFlRGli07anwk6wxkavBx6QH6OMzB+3C
         8J/mNd9IzPKElC9l0bkbqaBy++pHlRP0h0W2cXsdMT5jPWR2EvwpvsIpdZOP/GX5NBcM
         1JOsCt53wV4f5n0MZjhB2qsHleU1ZXfxkqrjTwvNaSN14BkriA3YkarN0RtH5XlGKkxg
         A9zUrkj9rl3pc8nwO7mWU3ZIZTp/4GqicfIHJTbktyRgyAw5Bq2/FxSumWoAPKgT/6s1
         XSBmLnHbFIt+ZUfmgyMdN/11rwrI80Sv2xMlNEkulU3o8w+YSXREOnOcCb+Xtc+PZbiE
         AFbQ==
X-Gm-Message-State: AOAM530MFDjTMk13KjHKBwJfwx1gFfszCxcTTaJS0+OQ5pnvo+XT0fyv
        emy1EoNecLHBWFKKeQIi3HcZRNyfXgx16CLJeaE=
X-Google-Smtp-Source: ABdhPJwNuNRiaVw/HxCfJfu6FgIyni+3Z9zm+cH2Yyh+tUsq0otg25Duoe0be95d0oR+J8wrnnvBsJ1QcSvPSCROFK0=
X-Received: by 2002:aca:4441:: with SMTP id r62mr666749oia.153.1601451152383;
 Wed, 30 Sep 2020 00:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUBCf8DsRBvXxxrfrQsab3kOwy95u-KwkdvaSY0vXQnXQ@mail.gmail.com>
 <20200925150607.GB470906@errol.ini.cmu.edu>
In-Reply-To: <20200925150607.GB470906@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Sep 2020 09:32:21 +0200
Message-ID: <CAMuHMdXvimaMROGFsLwC6COU4EPGden7w58r+N8JHA93EB6=+Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Mateusz Holenko <mholenko@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Florent Kermarrec <f.kermarrec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Gabriel,

On Fri, Sep 25, 2020 at 5:06 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Fri, Sep 25, 2020 at 03:16:02PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Sep 23, 2020 at 12:10 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
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
> There's been talk within the LiteX dev community to standardize on a
> LITEX_SUBREG_SIZE of 0x4 (i.e., using all 32 bits of a 32-bit
> (LITEX_REG_SIZE) aligned MMIO location). Early 32-bit (vexriscv based)
> Linux capable LiteX designs started out with only the 8 LSBits used
> within a 32-bit MMIO location, but 64-bit (Rocket chip) based LiteX SoCs
> use 4-byte aligned, fully populated MMIO registers (i.e., both
> LITEX_SUBREG_SIZE *and* LITEX_REG_SIZE are 4). There's also been talk of
> deprecating LITEX_SUBREG_SIZE == 0x1 for "linux-capable LiteX builds",
> but nothing definitive yet AFAIK.

That sounds like a good idea to me.
Having 8-bit accesses may be worthwhile on a small microcontroller, but a
full-fledge Linux system can use more and wider MMIO.

> Geert: note that LiteX has wider-than-32-bit registers spread across
> multiple 32-bit aligned, 8- or 32-bit wide "subregisters", so looping
> and shifting will still be necessary, even with LITEX_SUBREG_SIZE 0x4.

Can these be different than 64-bit (and 128-bit)?
That's not unlike accessors on other 32-bit platforms.
Still, no loop needed, just doing two (or four) 32-bit accesses in a row
is fine (but requires using inlines instead of your current single
out-of-line function).

> > > --- /dev/null
> > > +++ b/include/linux/litex.h

> > > +void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
> > > +
> > > +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
> >
> > Perhaps you can add static inline litex_{read,write}{8,16,32}() wrappers,
> > so drivers don't have to pass the reg_sz parameter explicitly,
> > and to make it look more like accessors of other bus types?
>
> Seconded -- perhaps simply cut'n'paste and/or adapt from
> https://github.com/litex-hub/linux/blob/litex-rocket-rebase/include/linux/litex.h#L78
> (from the 64-bit port of the LiteX linux patch set)

Yes, you definitely want the 32-bit and 64-bit ports to agree ;-)
Note that these are using the "old" "bwlq" convention (with "l"
predating 64-bit long on 64-bit platforms) instead of the more modern
explicit {8,16,32,64}, but that's a minor detail.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
