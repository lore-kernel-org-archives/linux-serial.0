Return-Path: <SRS0=DW7M=6V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD65BC47257
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 07:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E572078C
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 07:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="c1QbtHwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGHgr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 May 2020 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgEGHgq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 May 2020 03:36:46 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0BDC0610D5
        for <linux-serial@vger.kernel.org>; Thu,  7 May 2020 00:36:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w4so166590ioc.6
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2020 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izaC0j97DaEKeWCVsCGRwOFQb7MeNG6AyPzpQh6sfPU=;
        b=c1QbtHwkMQwm1lStyF86Ezx5rzlYQTI7Gd32BWAMTad1lET7RxRG96/ZyNAa0lWZgi
         jAKxt+Z8dD53SeH0xJDt3n4hoiJfIdVzYLiumVXiPvdwhw4uRfCScA028Z8nmu+CgGAy
         Qrl4Qy6OUmThArCylKm6AbYDL2ohS7DjGGSkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izaC0j97DaEKeWCVsCGRwOFQb7MeNG6AyPzpQh6sfPU=;
        b=Lx1s6PU3MvKNS/h6UALbaB/2sgPWAyYsI1r/X6xJSldig+pRGuicqY+Jn0CtaAZM7A
         D1tRsH5vCd0v4mz5JmkIWX4Fc9dBhV9So8rnfFLOAa2Kls4dnKNkuXtgoMpV/fqN+9jW
         VNomfh6gnsf2JrhNkCWHaRCQUBdy0wEZIRo4X1mz4cj7Idly+Zl7VkHCj3epigz+0tcb
         AzS2jW6TWAOkHm0jBcEKn2dmXjFJB2Q4PKrvv/VJ9ybdqJMs5zniqIcYTjNHiygeMn8p
         guAyxHut5N8qoXiVue5d8wH1C0DAjeVyjOVnczIYMHXPeAmDvlCwFdK2QUd7sBGktx4g
         vySw==
X-Gm-Message-State: AGi0PuZPeX8TuT8ptFLSRt6v0r3X5nsnIOqsxLv8bsMa3NVAoQwMpJQ4
        6p3O6wDOewayg+q3qTiMzonw70RDJ/xkgUfn/7H4zQ==
X-Google-Smtp-Source: APiQypLpq8huNxkhKDsHKb6+tSygwEJaTcwboqexXdJmXAAKs6Kn4dvmnWL1eZ5wk46A23oHuVJmrRRiqSUQuHS+m9g=
X-Received: by 2002:a02:6983:: with SMTP id e125mr12598539jac.47.1588837005803;
 Thu, 07 May 2020 00:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200425133939.3508912-0-mholenko@antmicro.com>
 <20200425133939.3508912-3-mholenko@antmicro.com> <aa7c915310753b042be35758893dee91d3651ffc.camel@kernel.crashing.org>
In-Reply-To: <aa7c915310753b042be35758893dee91d3651ffc.camel@kernel.crashing.org>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Thu, 7 May 2020 09:36:34 +0200
Message-ID: <CAPk366T3ACKrKX=RZwcN3D+Gy43-EGA+6vpwvOh5SKLXd1BM1Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 29, 2020 at 5:12 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Sat, 2020-04-25 at 13:42 +0200, Mateusz Holenko wrote:
> > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > This commit adds driver for the FPGA-based LiteX SoC
> > Controller from LiteX SoC builder.
>
> Sorry for jumping in late, Joel only just pointed me to this :)
>
> > + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> > + * the logic of writing to/reading from the LiteX CSR in a single
> > + * place that can be then reused by all LiteX drivers.
> > + */
> > +void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> > +                 unsigned long val)
> > +{
> > +     unsigned long shifted_data, shift, i;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&csr_lock, flags);
> > +
> > +     for (i = 0; i < reg_size; ++i) {
> > +             shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             shifted_data = val >> shift;
> > +
> > +             __raw_writel(shifted_data, reg + (LITEX_REG_SIZE * i));
> > +     }
> > +
> > +     spin_unlock_irqrestore(&csr_lock, flags);
> > +}
> > +
> > +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
> > +{
> > +     unsigned long shifted_data, shift, i;
> > +     unsigned long result = 0;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&csr_lock, flags);
> > +
> > +     for (i = 0; i < reg_size; ++i) {
> > +             shifted_data = __raw_readl(reg + (LITEX_REG_SIZE * i));
> > +
> > +             shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             result |= (shifted_data << shift);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&csr_lock, flags);
> > +
> > +     return result;
> > +}
>
> I really don't like the fact that the register sizes & sub sizes are
> #defined. As your comment explains, this makes it harder to support
> other configurations. This geometry should come from the device-tree
> instead.

This is a valid point - putting those parameters into DT would indeed allow
for more flexibility. Currently we are focusing on supporting a single LiteX
configuration (32-bit/8-bit bus) and that's why those parameters got fixed.

Adding support for other configurations however is not just changing those
two parameters (which should be fairly easy by itself), but also
handling different
registers layout for a single peripheral (in different configurations
CSRs offsets and sizes may differ).

Since this adds another layer of complexity we want to start with a simpler
version that can be extended in the future.

> Also this while thing is rather gross (and the lock will not help
> performance). Why can't CSRs be normally memory mapped always instead ?

Using a different LiteX configuration 32-bit/32-bit bus would solve
the problem -
a single LiteX CSR would map nicely to a single 32-bit memory pointer and no
loop/locks would be needed.

In the default configuration (32-bit/8-bit bus) there are gaps between bytes
(as Gabriel Somlo already explained in his mail) which need to be handled
"manually".

> Even when transporting them on a HW bus that's smaller, the HW bus
> conversion should be able to do the break-down into a multi-breat
> transfer rather than doing that in SW.
>
> Or at least have a fast-path if the register size is no larger than the
> sub size, so you can use a normal ioread32/iowrite32.

Again - this is possible, but using a non-default 32-bit/32-bit bus LiteX
configuration.

> Also I wonder ... last I played with LiteX, it would re-generate the
> register layout (including the bit layout inside registers potentially)
> rather enthousiastically, making it pretty hard to have a fixed
> register layout for use by a kernel driver. Was this addressed ?

TBH I never experienced bit layout inside a register to change by itself,
but I agree that using different bus width configurations causes CSRs
to be splitted into 4/2/1 32-bit registers (changing de facto the layout
from the SW perspective) - that's why we provide helper functions
in this file.

It is possible to have different configurations of a peripheral
in LiteX that e.g, turns features on/off - this might cause some CSRs
to shift and result in incompatibilities. There are ways in LiteX
to avoid such problems if the model is properly designed, though.

Another aspect of LiteX is that the order in which separate peripherals
(modules) are created results in a different memory map of the whole SoC.
This, however, is easily addressed by using a dynamically generated DT
and do not require the code of drivers to be altered in any way.

> Cheers,
> Ben.
>
>

Thanks for your comments!


-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
