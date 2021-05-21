Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D923C4707A
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 15:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F413E613E4
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhEUPGB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 11:06:01 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:33330 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhEUPF5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 11:05:57 -0400
Received: by mail-vs1-f42.google.com with SMTP id f11so10532033vst.0;
        Fri, 21 May 2021 08:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXuG7KOO5W95jEf2lKiMIqjS8B2a0VXsDtOORCzbLU4=;
        b=W1fsRgNXKReewuM5WHUHe/BmicWBng6XOGSGubvctnyErALZMnYzzOe1v1GPSP+tM1
         NebFjvzRLPJVK+LtlEvtrNaPsKnM0U0NDQ7dHdXQE4YUmVoJaIvMHPam/IiAmu+JKK1l
         C7UVaoht9AKLLKB3lV8CjbDc8TtA3Kexo9LBXq+JYVJXxpd/OnkXIt9sRq7X+GXmx+fy
         h0Tcaiv/yyGqCmi6kL+o58Jd0WOBVXhiNV0pmO38Sd8kqy2lgFz7LAwA35qgbdVIHItR
         AmQJs870NahPXzhh/DtOJlsI7GoAb7FdFIJY4xVswUZW8KcNilxsL0SM+bIyOwjkQw0r
         MVkg==
X-Gm-Message-State: AOAM533BP2sE9aP9fgWlyJgjBKmUS4sQG3DDRApQmRrYHs2HXrekWiV6
        puQclfbdRPAKNkqyIESqX6jGNomdmbjjZgN5ZNo=
X-Google-Smtp-Source: ABdhPJxLCsyebn71tdhuirdA3IxpgHUG0Q3VXGlmAMZm5PbspFWdB+sXj9tCZwpMGlNMbRxZQmyKcXIv6nlgRtRprhs=
X-Received: by 2002:a05:6102:392:: with SMTP id m18mr11126386vsq.40.1621609473060;
 Fri, 21 May 2021 08:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210514192218.13022-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210514192218.13022-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210514192218.13022-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 May 2021 17:04:21 +0200
Message-ID: <CAMuHMdUqpycW5mkX3nNn=q9TCp9gS9EZKTs0qwUAW+T+Ggh=8A@mail.gmail.com>
Subject: Re: [PATCH 11/16] dt-bindings: clock: renesas: Document RZ/G2L SoC
 CPG driver
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Prabhakar,

On Fri, May 14, 2021 at 9:23 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the device tree bindings of the Renesas RZ/G2L SoC clock
> driver in Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/renesas,rzg2l-cpg.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Renesas RZ/G2L Clock Pulse Generator / Module Stop and Software Reset

(Module Standby Mode
> +
> +maintainers:
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description: |
> +  On Renesas RZ/G2L SoC, the CPG (Clock Pulse Generator) and MSTP
> +  (Module Stop and Software Reset) share the same register block.
> +
> +  They provide the following functionalities:
> +    - The CPG block generates various core clocks,
> +    - The MSTP block provides two functions:
> +        1. Module Stop, providing a Clock Domain to control the clock supply
> +           to individual SoC devices,
> +        2. Reset Control, to perform a software reset of individual SoC devices.
> +
> +properties:
> +  compatible:
> +    const: renesas,r9a07g044l-cpg  # RZ/G2L

renesas,r9a07g044-cpg?

I believe it's the same block on RZ/G2L ('044l) and RZ/G2LC ('044c).

> +  '#clock-cells':
> +    description: |
> +      - For CPG core clocks, the two clock specifier cells must be "CPG_CORE"
> +        and a core clock reference, as defined in
> +        <dt-bindings/clock/*-cpg-mssr.h>

<dt-bindings/clock/r9a07g044l-cpg.h>

> +      - For module clocks, the two clock specifier cells must be "CPG_MOD" and
> +        a module number, as defined in the datasheet.

Also in <dt-bindings/clock/r9a07g044l-cpg.h>?

> +    const: 2
> +
> +  '#power-domain-cells':
> +    description:
> +      SoC devices that are part of the CPG/MSTP Clock Domain and can be
> +      power-managed through Module Stop should refer to the CPG device node
> +      in their "power-domains" property, as documented by the generic PM Domain
> +      bindings in Documentation/devicetree/bindings/power/power-domain.yaml.
> +    const: 0
> +
> +  '#reset-cells':
> +    description:
> +      The single reset specifier cell must be the module number, as defined in
> +      the datasheet.

Also in <dt-bindings/clock/r9a07g044l-cpg.h>?

> +    const: 1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
