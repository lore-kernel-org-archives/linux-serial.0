Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CBC41604
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 07:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E6220797
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 07:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="W84ohUHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJFHBF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgJFHBF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 03:01:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C4C061755
        for <linux-serial@vger.kernel.org>; Tue,  6 Oct 2020 00:01:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so752593pll.11
        for <linux-serial@vger.kernel.org>; Tue, 06 Oct 2020 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLnvcGYBW3K2JHWzUc8H3P/mWmh3X6aiUW1vORxEEk4=;
        b=W84ohUHypmj3DBg8s+ZzDXVQ6kA9mRdTcNoOJkgWPvlicW1CRh+p6VASoV6JT9Lof9
         i2cFX/BdUq1zT+mw/h/8Ekqn69vAzwwDDNWpfSbgbn/hJyJm19TP6hXUliGSLVEYqPmx
         9I9pymggsZ2W2CFEInZUD22uUVY+3ty6L24Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLnvcGYBW3K2JHWzUc8H3P/mWmh3X6aiUW1vORxEEk4=;
        b=IiuGwhHzahbWrEGL5iR2/BF3gEGzoEntutXtw7eD6UJpjtkYwQmQIoloT+5OtPrvs/
         uvTL152/6QWYcC7GJjI+XCM0c7Tcb8vltlz+VkpV9wx2K+5edu3+h/GgDUoIurx72NrD
         zdjrBh1NCr3e4/7aixx+Nv8Zh+1DARHwo1UsflLFQ/S7htNHmtzhNRzjAJISgJ/4jQIw
         fYF5ZubFpxCz+PI3Llrp2iaylGS7Ynb95vjfnpTOz1Ms+PlP4cdnmD/ndVMkckuq3IME
         y17HTr3EjzCi4gHFdDdTIQjRDftoYMwA2L3uQf5HFIZtchvF+TfiJISmn6rtzenRYAEx
         Kngg==
X-Gm-Message-State: AOAM530DJNFrOGnEtsFjN5sd8YW1jUch3VBaNpZNmx/TEqy6KYdkOmJo
        Za0vYwKFe/7dXtoZn5S8damBqbkecsBpYLpYYEg00g==
X-Google-Smtp-Source: ABdhPJyB29qLcQldVmQot4jqrKIxicdkoymtFIjYVQcSuxZVdPXQi6caH4F8RSL3X0MepZkQzzu/+MNsEK9FUgO7seU=
X-Received: by 2002:a17:902:9347:b029:d3:b2c6:1500 with SMTP id
 g7-20020a1709029347b02900d3b2c61500mr2057414plp.5.1601967664699; Tue, 06 Oct
 2020 00:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com>
 <20200923120817.1667149-4-mholenko@antmicro.com> <CAMuHMdXZ4QA4HX8xZJVnnj5P3USpefNn+8OFGz+Yo9T=UpNM4g@mail.gmail.com>
In-Reply-To: <CAMuHMdXZ4QA4HX8xZJVnnj5P3USpefNn+8OFGz+Yo9T=UpNM4g@mail.gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 6 Oct 2020 09:00:52 +0200
Message-ID: <CAPk366TrN0AUp8En6Lf4DHfyor22FyitwzK1K3tYBfei1RsYeA@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] dt-bindings: serial: document LiteUART bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

On Fri, Sep 25, 2020 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Mateusz,
>
> On Wed, Sep 23, 2020 at 12:10 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > From: Filip Kokosinski <fkokosinski@antmicro.com>
> >
> > Add documentation for LiteUART devicetree bindings.
> >
> > Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!

Thanks for your review!

>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LiteUART serial controller
> > +
> > +maintainers:
> > +  - Karol Gugala <kgugala@antmicro.com>
> > +  - Mateusz Holenko <mholenko@antmicro.com>
> > +
> > +description: |
> > +  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports
>
> part of the

Right, will fix that.

> > +  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
> > +
> > +properties:
> > +  compatible:
> > +    const: litex,liteuart
>
> Have you already decided how to handle future LiteUART variants that add
> new features (e.g. CTS/RTS, DMA)?

We were thinking of adding KConfig options, like

[ ] LiteUART serial port support
< >     LiteUART DMA support

and using ifdefs in the code.

The other option could be to extend LiteX itself so that the UART core
provides information about its configuration via the capabilities register.
That way the driver could configure itself automatically at runtime.

This is, however, not decided yet.

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    uart0: serial@e0001800 {
> > +      compatible = "litex,liteuart";
> > +      reg = <0xe0001800 0x100>;
> > +      interrupts = <2>;
> > +    };
> > --
> > 2.25.1
> >
>
>
> --
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

Best regards,
Mateusz


--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
