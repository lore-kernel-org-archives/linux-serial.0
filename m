Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56CCC4332F
	for <linux-serial@archiver.kernel.org>; Sun, 20 Nov 2022 14:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKTO5r (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Nov 2022 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKTO5p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Nov 2022 09:57:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D74962C4
        for <linux-serial@vger.kernel.org>; Sun, 20 Nov 2022 06:57:37 -0800 (PST)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD4C13F222
        for <linux-serial@vger.kernel.org>; Sun, 20 Nov 2022 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668956255;
        bh=EAN+jo73jsNjm6NxFzDUZqmJuYIU7qlxt8bnncU4Mvs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EweKhtbH0S4qHM3v9TJZWO4zW5LGRlwI3e55xlQOmYfJBZPVcIwG43FJah3h9/Loo
         VUaMHTXJQodT2fa7ASDA+f2Cnn0kyGB8seZ0KGs0dPC/V0Xx1+Lyp+6gaXrL5Ma8V1
         fjPf35TYhk+BVklKXQulT2RPxAAFQ8ZbBfbjSqKKJ6CKkaeaZ+oU3oLTCD+bX2+2Hq
         vzjGc8C1azmt4LubMx3RyAaWd4Wbw/NUSKnj9K5tw4zgM4uXn6TElTwCIaWqLSYwtD
         U5+xOW/shvAzj21CB1VmDChL76vMreGSMBOyyhB2wGccZ9x9Ct23rh3cclEpXu902F
         Oa6dm4htjpYfw==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-3a15bec5d25so7387477b3.19
        for <linux-serial@vger.kernel.org>; Sun, 20 Nov 2022 06:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAN+jo73jsNjm6NxFzDUZqmJuYIU7qlxt8bnncU4Mvs=;
        b=aXpwnkTuqxyjJXImz2+iGN25xVwxZdsvW6tYIEegx3ZfB2LgtBhQF2GZH43Kc4KbSn
         DxNmIQEUWHKXYSO1vN0cHG5F+j3BIDqAovxLKS6N6uPq6/OxJCVQT7Lld/fR7TLkE/4m
         6mFvpO9ewwqLj4wkJ4Ipeh0Eqsl0DqMQNm/x5exXM3k5Sr7u7no1499UMv2Z0X1hoRuX
         hbjQ4NZR0wYtfnKw4XmDgejflzzsgr2HbexWSYQj9JAXPxvbSZ8joeJLPJRq91ezvlZF
         b+p6RvtHNTiNTNQybvqVQV+Joxvn6zRQH2DHhxhMYkyCFwP6xYzar9KWUPc3ej0ceWoD
         ck7A==
X-Gm-Message-State: ANoB5pm9dey0EuouHHahocYydp0YzVN+dwvsQoY+z9PKM5lzHn4G+GuU
        vcRDAYEanXoP/UPkUAqhtWeK9JwdG0P6n9c7mqsQRViTnL9hJVyqPx8XVtTeThGYZUyI2/FJw1U
        aKH5pSz5dEA/yyQNEOnzx3uA9dNKhqAeQV9+9XSsxeLxkciDYhxS2R1MTdg==
X-Received: by 2002:a25:ce45:0:b0:6de:39c1:9cb3 with SMTP id x66-20020a25ce45000000b006de39c19cb3mr3991250ybe.469.1668956254623;
        Sun, 20 Nov 2022 06:57:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6QE5DtMEWnYNqTxZPXyHbUY3mIe3kVEW/kzSrOH//tkMR00zlzUTh2qwSJqJcuQ+yytC0Ib4Ivku6ASbIQfe0=
X-Received: by 2002:a25:ce45:0:b0:6de:39c1:9cb3 with SMTP id
 x66-20020a25ce45000000b006de39c19cb3mr3991228ybe.469.1668956254419; Sun, 20
 Nov 2022 06:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20221120082114.3030-1-jszhang@kernel.org> <20221120082114.3030-6-jszhang@kernel.org>
In-Reply-To: <20221120082114.3030-6-jszhang@kernel.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sun, 20 Nov 2022 15:57:17 +0100
Message-ID: <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com>
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 20 Nov 2022 at 09:32, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Add a baisc dtsi for the bouffalolab bl808 SoC.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/Makefile               |  1 +
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ff174996cdfd..b525467152b2 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +subdir-y += bouffalolab
>  subdir-y += sifive
>  subdir-y += starfive
>  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> new file mode 100644
> index 000000000000..c98ebb14ee10
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       compatible = "bouffalolab,bl808";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       cpus {
> +               timebase-frequency = <1000000>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {
> +                       compatible = "thead,c906", "riscv";
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <256>;
> +                       d-cache-size = <32768>;
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <128>;
> +                       i-cache-size = <32768>;
> +                       mmu-type = "riscv,sv39";
> +                       riscv,isa = "rv64imafdc";
> +
> +                       cpu0_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #address-cells = <0>;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +       };
> +
> +       xtal: xtal-clk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <40000000>;

This was discussed many times before, but I think the conclusion was
that the frequency is a property of the crystal on the board, so this
should be 0 in the SoC dtsi, and then overwritten in the board device
tree.

> +               clock-output-names = "xtal";
> +               #clock-cells = <0>;
> +       };
> +
> +       soc {
> +               compatible = "simple-bus";
> +               ranges;
> +               interrupt-parent = <&plic>;
> +               dma-noncoherent;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               uart0: serial@30002000 {
> +                       compatible = "bouffalolab,uart";
> +                       reg = <0x30002000 0x1000>;
> +                       interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&xtal>;
> +                       status = "disabled";
> +               };
> +
> +               plic: interrupt-controller@e0000000 {
> +                       compatible = "thead,c900-plic";
> +                       reg = <0xe0000000 0x4000000>;
> +                       interrupts-extended = <&cpu0_intc 0xffffffff>,
> +                                             <&cpu0_intc 9>;
> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       riscv,ndev = <64>;
> +               };
> +       };
> +};
> --
> 2.37.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
