Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4635C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BB1600CC
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhI0UTv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236897AbhI0UTu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Sep 2021 16:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A23C61074;
        Mon, 27 Sep 2021 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632773892;
        bh=Gs+/jugXgFBEVUEQP969f6W9qTFGmf4wj4z8f1JV4VU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbyRnn2SGnhj3MN1EsX3ZsL+prigNd/uxi9U3EB4jylO1DhVuMrAdLzPAgZRfOUWc
         igIAfHcRbYeHogdcQ846vlDNO13A7v+5NYwutT3EJm6UogYAMHSLluJz6BjHzBS4Ut
         vFoS7Apd5IJ58V46t34Sl8nDbXBe33yQNVNldpPscx1+qExG0YB0zQhXSU8Owg9GVJ
         T1npBt8aRYrm/X3wbtUSt5KrztSjkqLRIheaGc09aHJ4M0YxANgK1KXQPVEVWh93SA
         qzH/K3Cz6nCAO2XtW0OZ5zv0p5huRx6Z7Y1RFazLwpMh8z/Ae23rzCBcBty0KGjHOY
         I8mvXx/SZb9gg==
Received: by mail-ed1-f51.google.com with SMTP id dj4so74292684edb.5;
        Mon, 27 Sep 2021 13:18:12 -0700 (PDT)
X-Gm-Message-State: AOAM530b7mPDaMSp+zKFUN33jlYrsRrOsJiKsDj1JwMj3P0LEtsy/cl8
        WgtjAC8ExAzvLUvgAbFMfMB14gB/s6Byang/kQ==
X-Google-Smtp-Source: ABdhPJx0Mpijz4OFjl1AoyHZXg/DFW1ppxpHuYunciGgByTgzv3v9mmruih5DIWeWlR97gwvuIOauI6bZqVzKzBJ2Vw=
X-Received: by 2002:a17:906:fa8a:: with SMTP id lt10mr2286444ejb.320.1632773890868;
 Mon, 27 Sep 2021 13:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210922105433.11744-1-pali@kernel.org> <20210922105433.11744-4-pali@kernel.org>
In-Reply-To: <20210922105433.11744-4-pali@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Sep 2021 15:17:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com>
Message-ID: <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/6] dt-bindings: mvebu-uart: document DT
 bindings for marvell,armada-3700-uart-clock
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 22, 2021 at 5:56 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This change adds DT bindings documentation for device nodes with compatib=
le
> string "marvell,armada-3700-uart-clock".

Please resend to the DT list so that checks run and this gets reviewed
in a timely manner.

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  .../bindings/clock/armada3700-uart-clock.yaml | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-ua=
rt-clock.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-cloc=
k.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> new file mode 100644
> index 000000000000..5bdb23e0ba3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license. checkpatch will tell you which ones.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +title: Marvell Armada 3720 UART clocks
> +
> +properties:
> +  compatible:
> +    const: marvell,armada-3700-uart-clock
> +
> +  reg:
> +    items:
> +      - description: UART Clock Control Register
> +      - description: UART 2 Baud Rate Divisor Register
> +
> +  clocks:
> +    description: |
> +      List of parent clocks suitable for UART from following set:
> +        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
> +      UART clock can use one from this set and when more are provided
> +      then kernel would choose and configure the most suitable one.
> +      It is suggest to specify at least one TBG clock to achieve
> +      baudrates above 230400 and also to specify clock which bootloader
> +      used for UART (most probably xtal) for smooth boot log on UART.
> +
> +  clock-names:
> +    items:
> +      - const: TBG-A-P
> +      - const: TBG-B-P
> +      - const: TBG-A-S
> +      - const: TBG-B-S
> +      - const: xtal
> +    minItems: 1
> +    maxItems: 5

Don't need maxItems equal to length of 'items'.

> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    uartclk: uartclk@12000 {

clock-controller@12010

> +      compatible =3D "marvell,armada-3700-uart-clock";
> +      reg =3D <0x12010 0x4>, <0x12210 0x4>;

However, looks like this is part of some other block. The whole block
needs a binding (or at least the parent and whatever sub-functions you
know about).
> +      clocks =3D <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> +      clock-names =3D "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"=
;
> +      #clock-cells =3D <1>;
> +    };
> --
> 2.20.1
>
