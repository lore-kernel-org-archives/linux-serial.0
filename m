Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F0C4707C
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 15:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE7C613E4
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 15:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhEUPVN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 11:21:13 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:41682 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhEUPVM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 11:21:12 -0400
Received: by mail-ua1-f50.google.com with SMTP id 105so6766090uak.8;
        Fri, 21 May 2021 08:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaGnLwqlOlyhl0AWwuELPMnCurKFWAPWY7fD9j7KWdQ=;
        b=IEU+LUkC/6sShvqrDPNRrVXS1S1keSHH6L1GmkN8gyHZsTpGpwDZgyOWEwwMr/Xo2M
         Q+MmYNHg2zWYsiV4zcRz+zTT0ohfMcMoCbaF1QoEmHccMXFTJpzsZGBy6XWCs6b+kNNj
         m4xTYHIDOqaHVYFf3zcj6WcWkAt11lsRRi6m7wDgKwm1dRAnmPUtkvifz5yYp8iq3tA1
         K7tgNbaRsOzkvQWWWWgIRYPrFbMguZQP6Rbuq5SQgTXkY4orhhsqvNOn1cgM7QCGzWqc
         OjWSf5Aw1I04UH4FZcrLw3L4jgCiq6Z5AQhehibafRm9hM4k/7yjW0yAt3AlznoYseT3
         hANQ==
X-Gm-Message-State: AOAM530/2hq9kUWAKmqWV/uX2v5xQZ0dQdjQZhpQOsO/7tYC3EkDsLG+
        o8Pd1xvNDFSozXZ0idsE7D2o9L/h774rBzxwzqo=
X-Google-Smtp-Source: ABdhPJxtovmRj7Gh/Y3mZB1El4cZvhybaYa7JI1zkW9soJ7q+xDYjJJiwZAVnA8hsC98Zhg4VNqsctMbBpXtJH1//DU=
X-Received: by 2002:a9f:24b4:: with SMTP id 49mr1636978uar.100.1621610388488;
 Fri, 21 May 2021 08:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210514192218.13022-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210514192218.13022-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210514192218.13022-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 May 2021 17:19:37 +0200
Message-ID: <CAMuHMdXPfpp3omsx8MjQ9W4mFmW0KJ1GcHXx+y5DcXobxLcw_A@mail.gmail.com>
Subject: Re: [PATCH 12/16] clk: renesas: Define RZ/G2L CPG Clock Definitions
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
> Define RZ/G2L (R9A07G044) Clock Pulse Generator Core Clock
> and module clock outputs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  include/dt-bindings/clock/r9a07g044l-cpg.h | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 include/dt-bindings/clock/r9a07g044l-cpg.h
>
> diff --git a/include/dt-bindings/clock/r9a07g044l-cpg.h b/include/dt-bindings/clock/r9a07g044l-cpg.h
> new file mode 100644
> index 000000000000..2bc13f4e575b
> --- /dev/null
> +++ b/include/dt-bindings/clock/r9a07g044l-cpg.h

I think the filename should be r9a07g044-cpg.h, as this is
shared by RZ/G2L ('044l) and RZ/G2LC ('044c).

> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2021 Renesas Electronics Corp.
> + */
> +#ifndef __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__
> +#define __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__

The include guards are fine ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
