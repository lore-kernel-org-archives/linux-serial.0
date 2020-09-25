Return-Path: <SRS0=gGpx=DC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B192C4741F
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 12:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106592072E
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 12:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIYMsi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:48:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34911 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgIYMsh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Sep 2020 08:48:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id s66so2168186otb.2;
        Fri, 25 Sep 2020 05:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZdQoGJq4BMnKc0+GHhmzKbwi3eQut4rt4DQHIPPa00=;
        b=jgSDdKNOXBbGuMQpk/z4ET9PqM2NrpilZyt7jGFqWyhXtB8izZQuuhN3xZNoNBMqnp
         uXUgx4C6jwd4mtAK9GCg0gQNMTnpCY6ezczuW7dSUOIh7Yz6UfRBsy/K9Lp7ZsTD7YdG
         i6mn1e2vIgjkHUiDd/7/byquT15BOxaUsNc4mtQPtGJOkKBA1vjprNtaEqCC+3qEboZN
         jrfPgJzJ1Z2b+DTqHMvI17Styj2vvumaE1vsoW8CtlKfhNTpf8YbPaBXDQl4nXCjUFdS
         LFceTHR7PkVE4p7phtntSPq0ZcBTxtV71w48PruvFkqKYyusjTqGyIBuyoj91wL1Gsq1
         XW5Q==
X-Gm-Message-State: AOAM532L8xyBBUURSeDoJA6j5XxV59KXTE+LyYRij4XTzuG31A/K7h5Q
        gZ20hVwXbi86BT9mvLOtBJeKgtNYBgbli2x+hfU=
X-Google-Smtp-Source: ABdhPJyEECiGqQ4YhtmGHK4PB9VlUvTAmsww4fPctvrIYquFM8s2Gj+bjXohqp8HxxUs4QGzfupoX7xnA8O+y65QA7Y=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr161216otb.250.1601038116851;
 Fri, 25 Sep 2020 05:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com> <20200923120817.1667149-2-mholenko@antmicro.com>
In-Reply-To: <20200923120817.1667149-2-mholenko@antmicro.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Sep 2020 14:48:25 +0200
Message-ID: <CAMuHMdWCTg7g=Zu7Wp1Aee9A6Zr+yFguR-szywvm0ObPfH1cwg@mail.gmail.com>
Subject: Re: [PATCH v11 2/5] dt-bindings: soc: document LiteX SoC Controller bindings
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

On Wed, Sep 23, 2020 at 12:09 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
>
> Add documentation for LiteX SoC Controller bindings.
>
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright 2020 Antmicro <www.antmicro.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/litex/litex,soc-controller.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: LiteX SoC Controller driver
> +
> +description: |
> +  This is the SoC Controller driver for the LiteX SoC Builder.
> +  It's purpose is to verify LiteX CSR (Control&Status Register) access

Its

> +  operations and provide function for other drivers to read/write CSRs

functions

> +  and to check if those accessors are ready to use.

be used

> +
> +maintainers:
> +  - Karol Gugala <kgugala@antmicro.com>
> +  - Mateusz Holenko <mholenko@antmicro.com>
> +
> +properties:
> +  compatible:
> +    const: litex,soc-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    soc_ctrl0: soc-controller@f0000000 {
> +        compatible = "litex,soc-controller";
> +        reg = <0xf0000000 0xC>;

Please be consistent w.r.t. lower/upper case: "0xc".

> +        status = "okay";
> +    };

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
