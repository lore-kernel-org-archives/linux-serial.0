Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD940C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E3D60FF2
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbhI1R7E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241884AbhI1R7B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Sep 2021 13:59:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C9BC6135A;
        Tue, 28 Sep 2021 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632851841;
        bh=IitLXklH5pgGwr/QxPgyows3Ty/G/eCRW21HC4763yA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IcngGpWRpGd+pEp0EoEj8AWUcEw4iLr4bdM8zMoEu1dEl9BiF1zn4Lv3iiwuZLr6M
         L/zvOGm5g6EO2DB0rPEimsRHoZ9LfMNPMS+6hILAVqCKgFmLpkOQcaTkPzgNxmwxOY
         nhZF/phcOVg6ryvwhFgLpWeJAsNM6Sup6M0Qv8RgoG/xKInbOJuCtrdgU7itcNaYNF
         VUaIKJ+BLaRexubuQEiwBn2uXXPV0DlKMhh/w/9kW5wHRg6SVzDxrKDy6/+f2KAZaW
         kHftLdkcEP84jtDxvCjOsyEiu0LGYQGmkHcD8NDANSNUmZgu0s6jpO9x1YKn76GCFZ
         tqBiFcPRFASSA==
Received: by mail-ed1-f52.google.com with SMTP id v10so82374804edj.10;
        Tue, 28 Sep 2021 10:57:21 -0700 (PDT)
X-Gm-Message-State: AOAM531zB5dABm2mlBlvF6cpqUs/EHmusix4dCefjkrwOmhAom2gxOBp
        xgXP2xDzKNCdQmN5EETVn72pu+kA7wnLEY6jGw==
X-Google-Smtp-Source: ABdhPJxGg63yaAfVj6Hw2Ha6WrM0OzBtt3Hp0wo5IT3s8Xlx+9+izUEL1EukP7tKL0Tfo42roHR06T16AhTyWVT0aYM=
X-Received: by 2002:a50:d887:: with SMTP id p7mr9357826edj.164.1632851840048;
 Tue, 28 Sep 2021 10:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210922105433.11744-1-pali@kernel.org> <20210922105433.11744-4-pali@kernel.org>
 <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com> <20210927203423.o7aulgj7osaaksxr@pali>
In-Reply-To: <20210927203423.o7aulgj7osaaksxr@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Sep 2021 12:57:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ9UU8Q6LNha35uM6ie5-T1pd-FNSMuaf9ZBghU+KBfPA@mail.gmail.com>
Message-ID: <CAL_JsqJ9UU8Q6LNha35uM6ie5-T1pd-FNSMuaf9ZBghU+KBfPA@mail.gmail.com>
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

On Mon, Sep 27, 2021 at 3:34 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 27 September 2021 15:17:59 Rob Herring wrote:
> > On Wed, Sep 22, 2021 at 5:56 AM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > This change adds DT bindings documentation for device nodes with comp=
atible
> > > string "marvell,armada-3700-uart-clock".
> >
> > Please resend to the DT list so that checks run and this gets reviewed
> > in a timely manner.
>
> OK
>
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  .../bindings/clock/armada3700-uart-clock.yaml | 57 +++++++++++++++++=
++
> > >  1 file changed, 57 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/armada370=
0-uart-clock.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-=
clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.=
yaml
> > > new file mode 100644
> > > index 000000000000..5bdb23e0ba3e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.y=
aml
> > > @@ -0,0 +1,57 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > Dual license. checkpatch will tell you which ones.
>
> OK
>
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-cl=
ock#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +title: Marvell Armada 3720 UART clocks
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: marvell,armada-3700-uart-clock
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: UART Clock Control Register
> > > +      - description: UART 2 Baud Rate Divisor Register
> > > +
> > > +  clocks:
> > > +    description: |
> > > +      List of parent clocks suitable for UART from following set:
> > > +        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
> > > +      UART clock can use one from this set and when more are provide=
d
> > > +      then kernel would choose and configure the most suitable one.
> > > +      It is suggest to specify at least one TBG clock to achieve
> > > +      baudrates above 230400 and also to specify clock which bootloa=
der
> > > +      used for UART (most probably xtal) for smooth boot log on UART=
.
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: TBG-A-P
> > > +      - const: TBG-B-P
> > > +      - const: TBG-A-S
> > > +      - const: TBG-B-S
> > > +      - const: xtal
> > > +    minItems: 1
> > > +    maxItems: 5
> >
> > Don't need maxItems equal to length of 'items'.
>
> OK
>
> > > +
> > > +  '#clock-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - '#clock-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    uartclk: uartclk@12000 {
> >
> > clock-controller@12010
> >
> > > +      compatible =3D "marvell,armada-3700-uart-clock";
> > > +      reg =3D <0x12010 0x4>, <0x12210 0x4>;
> >
> > However, looks like this is part of some other block.
>
> Yes, it is part of UART block.
>
> Explanation is in commit message of patch 2/6.
>
> And also discussed here:
> https://lore.kernel.org/linux-serial/20210812200804.i4kbcs6ut27mapd3@pali=
/
>
> > The whole block
> > needs a binding (or at least the parent and whatever sub-functions you
> > know about).
>
> Whole UART block has already binding. Clock driver just needs access to
> these clock bits of these two registers which are in UART block. HW
> designers decided that clock which drives UART2 has configuration in
> UART1 address space. As explained in commit message of patch 2/6 there
> is no easy way how to deal with it in DTS backward compatible way. So
> clock and UART driver shares mutex for accessing these two shared
> registers, and these two registers are defined in all 3 DT nodes: UART1,
> UART2 and UART-clock.

That's awful. I guess I don't have a better suggestion.

Rob
