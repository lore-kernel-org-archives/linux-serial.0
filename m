Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA2C4708B
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 11:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93DC613DC
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 11:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhE0Lbd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 May 2021 07:31:33 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:33465 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhE0Lbb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 May 2021 07:31:31 -0400
Received: by mail-ua1-f44.google.com with SMTP id c6so29901uat.0;
        Thu, 27 May 2021 04:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4s2CSTG9vi+vLVdGlcoUOiNvjm5f1IzjvzNeN2//YSA=;
        b=H1ttFigXxTWmDaI9yFUjaq1FWIVw7dULutA7pPIRrM8J8KhqOnbj0B+5krQz5N/3iR
         el2z/nE+14ytH4DqiwtAna7pYRrdgaFzGnfCqHdL99Mse0QJ1A0EeZD6kOx4u45jnAVN
         4ad3YTIBjc4Qq4KJibUoMwOgfSFk8o/gvh9j0+4f2NlyPncXCWcUG4ud6T4NGdT0TkYF
         5VHJC8h2sY2uBbaiZFSl911YPLqFPfRiZdPuP4RLKjL67FQAbFzSysmTRTQ6hUoaAlcD
         8NeaNPQ//IMxrtWpcaM4MMbCXW13syiVZ29UBHr1ysyyngShUWLtyDuSsx15xbYozDkH
         JNIA==
X-Gm-Message-State: AOAM532u14ONtXEZcrjhFifqDRDCtPn9wPXzDrSX1oBXfXE9u/FjdmVH
        SrP50bAwF/h1rjf9CdQO5jqQ42XJl2DNXRfxSok=
X-Google-Smtp-Source: ABdhPJwwvgVZz7RlABNPzgpJPYcMGcUihUCr/TwHmo7U2MFE5g+i4/PgG8aawKP1goeRBrVGSoRiKaoZSZ3rGkjEQyE=
X-Received: by 2002:a1f:9505:: with SMTP id x5mr1443751vkd.6.1622114997309;
 Thu, 27 May 2021 04:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210514192218.13022-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210514192218.13022-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdU40pLb3LvEghkT0pryLtHdXj+U1R7Y7L6-_6euVohyUw@mail.gmail.com> <CA+V-a8tFsAO2yYqURT1gYS14_Eax1VqJ1YbgcnfZADtOMLXFMA@mail.gmail.com>
In-Reply-To: <CA+V-a8tFsAO2yYqURT1gYS14_Eax1VqJ1YbgcnfZADtOMLXFMA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 May 2021 13:29:45 +0200
Message-ID: <CAMuHMdWc-ZdrpsOu_QhUvh7D3ap7ZC4LM_vKwnLnGCAEmAoryA@mail.gmail.com>
Subject: Re: [PATCH 01/16] dt-bindings: arm: renesas: Document Renesas RZ/G2UL SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Prabhakar,

On Fri, May 21, 2021 at 6:54 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, May 21, 2021 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, May 14, 2021 at 9:23 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add device tree bindings documentation for Renesas RZ/G2UL SoC.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> > > @@ -302,6 +302,12 @@ properties:
> > >                - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
> > >            - const: renesas,r9a06g032
> > >
> > > +      - description: RZ/G2UL (R9A07G043)
> > > +        items:
> > > +          - enum:
> > > +              - renesas,r9a07g043u11 # Single Cortex-A55 RZ/G2UL
> >
> > Is there any specific reason you're including the final "1", unlike the
> > RZ/G2{L,LC} binding?
> >
> To be consistent with the RZ/G2L family of SoC's "1" is appended to
> the compatible string.

No, for RZ/G2L you have:

    renesas,r9a07g044c1 for r9a07g044c12
    renesas,r9a07g044c2 for r9a07g044c22
    renesas,r9a07g044l1 for r9a07g044l13 and r9a07g044l14
    renesas,r9a07g044l2 for r9a07g044l23 and r9a07g044l24

i.e. the compatible value lacks the final digit.

For RZ/G2UL, I do not know if we have to distinguish between
r9a07g043u11 and r9a07g043u12.

> > As RZ/G2UL is always single-core, perhaps this compatible value can be
> > dropped?
> >
> Do agree with you.

In light of the continued discussion for [PATCH 02/16], perhaps it's
good to keep it anyway?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
