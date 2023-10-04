Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B119E8FDDA
	for <linux-serial@archiver.kernel.org>; Wed,  4 Oct 2023 08:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbjJDILb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Oct 2023 04:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjJDILa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Oct 2023 04:11:30 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01A4A6;
        Wed,  4 Oct 2023 01:11:27 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59e77e4f707so22540467b3.0;
        Wed, 04 Oct 2023 01:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696407087; x=1697011887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNgqb3ogEHljK/s/zCJeiDzbGvte6UXqv8/D2qJ2ym4=;
        b=ZYK5m64MOnGA8YTAeV2tiORL9AdLx+4BXWrpEWgCPvGU1iFdKoTSHRV8jLvzlLSWLq
         LLfTGWFxXqh5vjm8fw69MPC0XJkLEI3Ig5V21BIdk3BA1T9CIs4VxwE9+UdyZCNpfi+A
         zs09hajQpWTwDVY+vdKZFqlDQJI3oYwR+yXBd9KtgOatUkapR1bMWi8P9p0eRNIlBrm8
         Ea3pWSDExvuXZjnJub+dXDCS4NZzYNXrUtx/KUkoZebs3S9qAhnBeGIAk6l3zoVqMNzC
         LLOYWGj3Nh6QzABN3WXGquzF2o+sILLslqrptA5AwVFOvV7R2pg3zN/v76agdAm6Ae+F
         1LYw==
X-Gm-Message-State: AOJu0YwY5mCRbNBSyEGQpnYEUuoUK2nLzETetO/ssUue5KuB04T6GIQP
        BKgt0oiSkVXQwuJA2ak0/42A/2e7wIWPDA==
X-Google-Smtp-Source: AGHT+IFeroNisVnSgtZNX1YFfffHyQZ0Z4NTkeg2rgkAf7MQgLzryT6LktpCzDxf7u83desFvnesWQ==
X-Received: by 2002:a81:a008:0:b0:59f:5041:bedb with SMTP id x8-20020a81a008000000b0059f5041bedbmr1838913ywg.8.1696407086812;
        Wed, 04 Oct 2023 01:11:26 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id a74-20020a0dd84d000000b005a20ab8a184sm995752ywe.31.2023.10.04.01.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 01:11:26 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59e77e4f707so22540287b3.0;
        Wed, 04 Oct 2023 01:11:26 -0700 (PDT)
X-Received: by 2002:a0d:d7cc:0:b0:584:4bbb:963b with SMTP id
 z195-20020a0dd7cc000000b005844bbb963bmr1795264ywd.15.1696407085921; Wed, 04
 Oct 2023 01:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-7-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-7-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 10:11:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgVfxWrVP51b3nbeDThedjzWGJb95-oU5bdPeTTjWu8Q@mail.gmail.com>
Message-ID: <CAMuHMdUgVfxWrVP51b3nbeDThedjzWGJb95-oU5bdPeTTjWu8Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] clk: renesas: rzg2l: remove critical area
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> spinlock in rzg2l_mod_clock_endisable() is intended to protect the accesses
> to hardware register. There is no need to protect the instructions that set
> temporary variable which will be then written to register. With this only
> one write to one clock register is executed thus locking/unlocking rmw_lock
> is removed.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - removed also the spinlock
> - s/reduce/remove in patch title

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
