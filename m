Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6260C4707D
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 18:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919EE613E6
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 18:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhEUSXB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhEUSXA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 14:23:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC7AC061574;
        Fri, 21 May 2021 11:21:37 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w1so17377578ybt.1;
        Fri, 21 May 2021 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNr1AlAWjbURkDNkMBPm+j+8zno+WRBAtQ1awt0lpEk=;
        b=CuIVR6FG7TvH+3ts4H/CBIy+7p4gVqF+12mC7QjIPhVQMrYeaQB5u9BUUqtAwOlZxq
         CFffa5JMcwhnW85h5rL1rGXL1ZKKWK9UW3mLtgI5L+WeJ1Oi2/mfmJNjJx1x0GXCF4FW
         fpJrc3pFkUFv9LavWfngX76Xz1ncT8njudk+fgz30FLdUshXfsH1j7IO4Tl10Da/HG5Y
         KHovnY0aG0msX+l/MBSnZt+kQHYEkjQ7VPIU0ALo3T96D0XNEpyo8+7osA/l0kUpQjew
         aKPQzJHedalkyAVH0ePaD4fAvlSaiJwECeuSBMieEjVKsi1j6n30ZLb/SyP0FsMQMupT
         PPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNr1AlAWjbURkDNkMBPm+j+8zno+WRBAtQ1awt0lpEk=;
        b=S/nTQ703Shf5s7Gn8q1EYnJCEoOOkeRhjf+xnaVWr77VZsS5k0CUaqTuyDWFhxL2q2
         0HFIx6clbqYiiYBNV1qVgKYoJ81pLKqZW+0ZjqkuSoFXOTrzMaYpTFsJGRc5+EKTNstG
         T0nLntItJm31crFxke8EPyYHHeV79AsQh6VGnbcQaAhjQy5tqZsuGYfyOmKrEkJi1XSU
         vFTfTHGgAo/H5FG7RWKawcqrg1oEjRDrPa2sjRmSTCS4g4OZhK1hEeNkNryec/4VBGVi
         IjxHaED1H1eyF9nM4exuXQSjZxnSVtpShEhkCsSJjfTT7VCgz4aexoXGfmeLzw0QjfXL
         SqrQ==
X-Gm-Message-State: AOAM530/gk7nzJQv9nvP6ueAp/L83Nkz8nwY6NPUYYhXx5+Yr0o/32T9
        wrhgiafABwPYQPZA02ArP5F4X/S8id3lGDNWhf0=
X-Google-Smtp-Source: ABdhPJwX+TyzvMJ9UQaDzoql/G/nXuhsMgzOlaA/l19HXtJIJObl0NNIu4fY7nFzH71NwlvdiTvFhXOCboQHbbnbvlU=
X-Received: by 2002:a25:f20f:: with SMTP id i15mr16055169ybe.119.1621621296645;
 Fri, 21 May 2021 11:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210514192218.13022-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210514192218.13022-17-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXZEB6JretasVj7xpN2Gbp2y9dHh_Eiq03BEevRK8Zy9Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXZEB6JretasVj7xpN2Gbp2y9dHh_Eiq03BEevRK8Zy9Q@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 21 May 2021 19:21:10 +0100
Message-ID: <CA+V-a8s+nae_PaHXo2=1Ongyxv_V_NJphKVJoX_WJHnukYPPxw@mail.gmail.com>
Subject: Re: [PATCH 16/16] arm64: dts: renesas: Add initial device tree for
 RZ/G2L SMARC EVK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

Thank you for the review.

On Fri, May 21, 2021 at 4:41 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, May 14, 2021 at 9:24 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add basic support for RZ/G2L SMARC EVK (based on R9A07G044L2):
> > - memory
> > - External input clock
> > - SCIF
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/Makefile
> > +++ b/arch/arm64/boot/dts/renesas/Makefile
> > @@ -62,3 +62,5 @@ dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
> >  dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
> >
> >  dtb-$(CONFIG_ARCH_R8A779A0) += r8a779a0-falcon.dtb
> > +
> > +dtb-$(CONFIG_ARCH_R9A07G044L) += r9a07g044l2-smarc.dtb
> > diff --git a/arch/arm64/boot/dts/renesas/g2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/g2l-smarc.dtsi
> > new file mode 100644
> > index 000000000000..9b95d73fb798
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/g2l-smarc.dtsi
>
> rzg2l-smarc?
>
Agreed will do.

Cheers,
Prabhakar

> The rest looks good to me (taking into account compatible value
> discussions).
>
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
