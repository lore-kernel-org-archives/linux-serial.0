Return-Path: <SRS0=gGpx=DC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90094C4363D
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C142389E
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 13:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgIYNQf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:16:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44332 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgIYNQf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Sep 2020 09:16:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id 185so2704867oie.11;
        Fri, 25 Sep 2020 06:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B0zGuwlE5IXq5+CRBTpyf20tfnqDJ9kkPftjlq2jcs=;
        b=EISQ2D5Vq5SoCUH3NrQkvFAOwMcU27X+m5SogcBvwjG8fGv8XRO6bHRPv5t2JNZIvD
         lXc8uO6DBFrGQ4OhRo4IAUgTuTaIXVC/ptIcAa1C9Pl69lIb8ruLJ7b9Xfz7Oyq/W8MS
         ol7dtod6GccR9CdMTABRGZKeMayLj9nZcpqAEV5IPiSgHehuxgXFgtJpgVBSpF23lurG
         Ez6NuPtsmg+vMHqfHv8MQ1V7rx9ZLUOrszHJMxygzQAg/iHo4Uirs4VX1IcWr8C90v6j
         C8NnLli6MY69z6LatkwcCq4cmQWnlEfYnqsHy/T7SviAIkk+wZTe0T9PYJzUoghCxOXy
         jpsA==
X-Gm-Message-State: AOAM532vqdoS5PnlUikgWqAn5RbMeI9Tz4fXO26/YkZF257PWvtooUGa
        72C3CBLHAmUpZp2jPilM7fH2OLpEUHcUmWw/9Sg=
X-Google-Smtp-Source: ABdhPJyGPTsmkodXXmXipVIfYg0SJYTSh9mpOHX1TQ8oOk0omx6zJdHRI8eC6aY6pMzpl6nYHQqv6rUWxzTyfmLsMeA=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr203649oia.148.1601039794520;
 Fri, 25 Sep 2020 06:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com> <20200923120817.1667149-4-mholenko@antmicro.com>
In-Reply-To: <20200923120817.1667149-4-mholenko@antmicro.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Sep 2020 15:16:23 +0200
Message-ID: <CAMuHMdXZ4QA4HX8xZJVnnj5P3USpefNn+8OFGz+Yo9T=UpNM4g@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] dt-bindings: serial: document LiteUART bindings
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

On Wed, Sep 23, 2020 at 12:10 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> From: Filip Kokosinski <fkokosinski@antmicro.com>
>
> Add documentation for LiteUART devicetree bindings.
>
> Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LiteUART serial controller
> +
> +maintainers:
> +  - Karol Gugala <kgugala@antmicro.com>
> +  - Mateusz Holenko <mholenko@antmicro.com>
> +
> +description: |
> +  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports

part of the

> +  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
> +
> +properties:
> +  compatible:
> +    const: litex,liteuart

Have you already decided how to handle future LiteUART variants that add
new features (e.g. CTS/RTS, DMA)?


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    uart0: serial@e0001800 {
> +      compatible = "litex,liteuart";
> +      reg = <0xe0001800 0x100>;
> +      interrupts = <2>;
> +    };
> --
> 2.25.1
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
