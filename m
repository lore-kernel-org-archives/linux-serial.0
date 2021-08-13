Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66AEC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963E7610EA
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhHMSHs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:07:48 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39830 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHMSHq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 14:07:46 -0400
Received: by mail-ot1-f48.google.com with SMTP id v10-20020a9d604a0000b02904fa9613b53dso12994446otj.6;
        Fri, 13 Aug 2021 11:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iihg9oRsXmwP2LhA3OLBni38vE7IHeZGut4WUp0feJE=;
        b=YOTdLIbLF6otxkpG+XL/zC7TZbZ9kgjZRJtRxQuu+b0fKelwTum4dFkDdHZW64CIxE
         RIGFFQvwAibxKFQ8hIhiTLITRsgz7wROdQWf1KhRnrlzNZUvgoWrjZ9WRKOWiAK8phNy
         8itNpfKmeePEKNuLze3numVDYAuK6XCcCEUKsAlukFZ6vHAJQGV71BHP8p4K1bVVMYBJ
         l8evuA0JQaRJj8d2ZmUHEv49WHPDcjv73y+mJg9K+4x7nzodGo52uxBVzSUSoS/DBHEE
         kAU3xxBPxRwZeTWOjf4ZktC24IaWqhKXaPcEwVbkU3hH9kfdmMngxbaHVGXH2gYZKq2H
         yOFA==
X-Gm-Message-State: AOAM531Qj0SUYcIamovC9+qd0Dn/DC251tzGjZuybeA1v6A16hBsxKtF
        RoJXiIML16hYQZmoWjsBxg==
X-Google-Smtp-Source: ABdhPJwjoyNFeYNurFTeKCKi0twKkY7fxrdc9/HBCH8Vet1bzVMNhHbiW8MFbwKmkDJ0MC3q6mH5Lw==
X-Received: by 2002:a9d:4806:: with SMTP id c6mr577839otf.210.1628878039192;
        Fri, 13 Aug 2021 11:07:19 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm457340otl.48.2021.08.13.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:07:18 -0700 (PDT)
Received: (nullmailer pid 3780434 invoked by uid 1000);
        Fri, 13 Aug 2021 18:07:17 -0000
Date:   Fri, 13 Aug 2021 13:07:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 2/8] dt-bindings: serial: fsl-linflexuart: convert to
 json-schema format
Message-ID: <YRa01Xj1i9bF2xbR@robh.at.kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-3-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805065429.27485-3-clin@suse.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 05, 2021 at 02:54:23PM +0800, Chester Lin wrote:
> Convert the FSL LINFlexD UART binding to json-schema.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> deleted file mode 100644
> index f1bbe0826be5..000000000000
> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -* Freescale LINFlexD UART
> -
> -The LINFlexD controller implements several LIN protocol versions, as well as
> -support for full-duplex UART communication through 8-bit and 9-bit frames.
> -
> -See chapter 47 ("LINFlexD") in the reference manual[1].
> -
> -Required properties:
> -- compatible :
> -  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, which
> -    is compatible with the one integrated on S32V234 SoC
> -- reg : Address and length of the register set for the device
> -- interrupts : Should contain uart interrupt
> -
> -Example:
> -uart0: serial@40053000 {
> -	compatible = "fsl,s32v234-linflexuart";
> -	reg = <0x0 0x40053000 0x0 0x1000>;
> -	interrupts = <0 59 4>;
> -};
> -
> -[1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> new file mode 100644
> index 000000000000..acfe34706ccb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/fsl,s32-linflexuart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale LINFlexD UART
> +
> +description: |
> +  The LINFlexD controller implements several LIN protocol versions, as well
> +  as support for full-duplex UART communication through 8-bit and 9-bit
> +  frames. See chapter 47 ("LINFlexD") in the reference manual
> +  https://www.nxp.com/webapp/Download?colCode=S32V234RM.
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +  - Rob Herring <robh@kernel.org>

Someone that cares about this h/w, not who applies patches.

> +
> +allOf:
> +  - $ref: "serial.yaml"
> +
> +properties:
> +  compatible:
> +    description: The LINFlexD controller on S32V234 SoC, which can be
> +      configured in UART mode.

Drop 'on S32V234 SoC' so we're not editting for every new SoC.

> +    items:
> +      - const: fsl,s32v234-linflexuart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial@40053000 {
> +        compatible = "fsl,s32v234-linflexuart";
> +        reg = <0x40053000 0x1000>;
> +        interrupts = <0 59 4>;
> +    };
> -- 
> 2.30.0
> 
> 
