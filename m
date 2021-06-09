Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB7C48BCD
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 06:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DDB6124C
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 06:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhFIGym (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:54:42 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:41733 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbhFIGyl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Jun 2021 02:54:41 -0400
Received: by mail-vs1-f48.google.com with SMTP id c1so5879517vsh.8;
        Tue, 08 Jun 2021 23:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSoKY793QQP8Lg3KOL1Eq+qF4VFHd0Ap3iIktbWFwKI=;
        b=KSVubdfoeAuqOuX9m1upjOWdRs5t7BQLckzSDREAF52bbf+XY+1MhrVOdGB+zLX2F4
         Q2VciOI8NLZ3i02+nLZ3Vn5OqDcbw6NMfQ325qRHZcqzAADV1/yRZqBjY7coSBvpcZCA
         X9wvq2D4Lt5dpc1a2YgS5Q3ELL32/CtmAFj2gIyxH/ZULg30y3R+tDHm+hhOvK5HoIiL
         /GJDPH/A1NZ45uq8Z4kq9GrRc8MNy0B+ewC2nJjv/AWdjuM7ZBeuNV4YAi5WfiZXf/GX
         gc+oBWvOlmcKMpfJvx87uNmGl2TsEul8JjIRsZNsQuecXwZc79oyawYEB0ssmqn4v05B
         WjZw==
X-Gm-Message-State: AOAM530REf3fVdLLE1/0voOCgthYnteHP4zISfoa26/O4jRpxbRkFGwO
        FKQl1vjsk7iIHxoo0oxF+LcdbnWnM3QNnLvkfq8ZUA/SNgt6Cg==
X-Google-Smtp-Source: ABdhPJygZr/3LQ/D9FOyetVDM2EZnw/62aS6ccgNDCfA/ODtwcs1rC1hedtwimbImN81NOV5Bk77rEP4L35DofRZdSM=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr3828568vss.18.1623221553803;
 Tue, 08 Jun 2021 23:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210603221758.10305-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210603221758.10305-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210603221758.10305-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 08:52:22 +0200
Message-ID: <CAMuHMdW8Nn2q06J0F+zFCFFSGz5TEGus46gc++oKAb8-gKi5fQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] arm64: dts: renesas: Add initial DTSI for
 RZ/G2{L,LC} SoC's
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Prabhakar,

On Fri, Jun 4, 2021 at 12:18 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add initial DTSI for RZ/G2{L,LC} SoC's.
>
> File structure:
> r9a07g044.dtsi  => RZ/G2L family SoC common parts
> r9a07g044l1.dtsi => Specific to RZ/G2L (R9A07G044L single cortex A55) SoC
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> ---
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi   | 119 +++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi |  25 ++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044.dtsi
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi

Don't you still want an r9a07g044l2.dtsi, for symmetry, and to add the
"renesas,r9a07g044l2" root compatible value?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
