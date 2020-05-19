Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8407C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 13:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8911220829
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 13:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="P5GGg8FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgESNYE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESNYD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 09:24:03 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF0C08C5C0
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 06:24:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so11239509lfd.7
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J1EagSeqT/3hRw9PlSOk/6Jo3bCIp/4AjuBFz8qTGQo=;
        b=P5GGg8FTAebv5YHBzDwy/NA+Pb0/hhk5tGhHN/6Zp35VJvAyb2VNannMq+B9Gky3rB
         TGTu+1BOjz8xRPMmJ3vlPBcFvlV192DO/UxajGeDKfgTD6bfKqBmegQbXLHAa6rINe05
         YbRFZ/AH4i+2GZ4rAOCYBsMpAFM0I5P4av+SdCVYUrhLolCa+j6qEAgbWHYLy9l0RW8O
         atIn2xCgeQS8U+6VO18HirD8WfWsMWgTaKABHicANTgapLgQDFzslokXMZ9qUBz7Gpvo
         e7c8FzuIQT1uiJkX24OxVb6YXu4ZP07P2CCI9GtIawRld5ALutKcxm8lVJrK6ZYUs085
         07IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J1EagSeqT/3hRw9PlSOk/6Jo3bCIp/4AjuBFz8qTGQo=;
        b=KIzeLAYc5KO0/Zjc8AtRwU2+7kegO0E7l7TCLSw9xdUeM/BIW0fqMSWtVLme9izEWX
         4itT7X+/ri3F2ZXLghQMeP/LVzl9pF9fxrMuGcV51DQRuJRkeOR7R/17ahM/iQ7vaU2/
         d6tpQoQ0ssKwcSxd6OZnbsqhDLLUdqbpF9Auqc4emaR2He4q0htyybQZRf2RXuRLfTuM
         5o6Vy81USZTLDRgx/EnlKas25QHRwrd4CB7mfz/Q0hDexg+fMUXGCWKCl3pRsF1vc+Pu
         SazwjvHvJ+Qrg/ZvE9jXJ+zDyGADSCKUj4MVxwTDBCZaYWfK10DAHkwBaqeKo9T4RUNm
         Nlgg==
X-Gm-Message-State: AOAM53101DMXeA+rKXUEztKmyKvEmdEG6r53a5GJbg8XriQGWn2zJajO
        6OYoOOVbSzGR9ym41PfRIDYs0g==
X-Google-Smtp-Source: ABdhPJwHiLIqIrqU451dZhunm6Wgq2SvF8KYkSJemlDv966oh3Pe4JnO+at5+ht1brskAcIWPtJMLw==
X-Received: by 2002:a19:c751:: with SMTP id x78mr10756302lff.82.1589894641624;
        Tue, 19 May 2020 06:24:01 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id y8sm7435855ljh.83.2020.05.19.06.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 06:24:00 -0700 (PDT)
Date:   Tue, 19 May 2020 15:24:00 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Add renesas,em-uart bindings
Message-ID: <20200519132400.GC470768@oden.dyn.berto.se>
References: <20200519080945.28798-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519080945.28798-1-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-05-19 10:09:45 +0200, Geert Uytterhoeven wrote:
> Document Device Tree bindings for the Renesas EMMA Mobile UART
> Interface.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  .../bindings/serial/renesas,em-uart.yaml      | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
> new file mode 100644
> index 0000000000000000..82aefdb0d45e5f1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/renesas,em-uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Renesas EMMA Mobile UART Interface
> +
> +maintainers:
> +  - Magnus Damm <magnus.damm@gmail.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: renesas,em-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: sclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    uart0: serial@e1020000 {
> +            compatible = "renesas,em-uart";
> +            reg = <0xe1020000 0x38>;
> +            interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&usia_u0_sclk>;
> +            clock-names = "sclk";
> +    };
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
