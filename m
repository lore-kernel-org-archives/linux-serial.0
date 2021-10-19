Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7D1C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 19 Oct 2021 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36518610A1
	for <linux-serial@archiver.kernel.org>; Tue, 19 Oct 2021 22:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJSWuT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:50:19 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:33789 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhJSWuT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Oct 2021 18:50:19 -0400
Received: by mail-oo1-f52.google.com with SMTP id y145-20020a4a4597000000b002b7d49905acso748829ooa.0;
        Tue, 19 Oct 2021 15:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qy225hlqYwRXCtGLKyscMysC+wuepXd23D/7I3vqNfc=;
        b=B3/aSvDOcQ92TP+IkJQovgaDu60ln8LsiB1H3HzHS2vgFIgMy/uywc8d+INVjk7bhM
         BBowuXkMelQtcIsY6/U/0CaiwRebOuCEsl+7Yq3NJlRbp1aMvj5RirgM3Vd7jycOH3G/
         uPkfxIJvcMA8vF2Lv1ORDG96FlC5ViM/KHFKdAXtsJfyhV2C/1rXFRyK3r7FxtyqDBK+
         sPAzBqs/Lzb1j9BSO1BInW4OtfAeEIoO2IEmvgNIOE28jWxFLycYK0Jez/hNdhm4uW6q
         F3FgMJsM0xxgWiYvFIOa77TlILZvDNQKCAhbto3S+bpLeVBKvlsUCLTwOYpf2UM/rRgv
         qX7A==
X-Gm-Message-State: AOAM532dwGTLjK4rwGjaJ2aWFvRdrb/VVVfboYPszdlueHhKwk3Q3m2i
        dpG+5jGh4/w8b1sncB9qBvqMEu24NQ==
X-Google-Smtp-Source: ABdhPJx+7M3+gwkvEccdiQLtE6ApfeIIiJPnK81zPl6XyOGFDwaQcsleOmnfmF9OVJFcsgizIss55Q==
X-Received: by 2002:a4a:ca0f:: with SMTP id w15mr6869426ooq.39.1634683685422;
        Tue, 19 Oct 2021 15:48:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n17sm82181oic.21.2021.10.19.15.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 15:48:04 -0700 (PDT)
Received: (nullmailer pid 968061 invoked by uid 1000);
        Tue, 19 Oct 2021 22:48:03 -0000
Date:   Tue, 19 Oct 2021 17:48:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, Sagar Kadam <sagar.kadam@sifive.com>,
        linux-gpio@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Drew Fustini <drew@beagleboard.org>,
        linux-kernel@vger.kernel.org, Matteo Croce <mcroce@microsoft.com>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 02/16] dt-bindings: timer: Add StarFive JH7100 clint
Message-ID: <YW9LI/scFZtyczt2@robh.at.kernel.org>
References: <20211012134027.684712-1-kernel@esmil.dk>
 <20211012134027.684712-3-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012134027.684712-3-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 12 Oct 2021 15:40:13 +0200, Emil Renner Berthing wrote:
> Add compatible string for the StarFive JH7100 clint.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
