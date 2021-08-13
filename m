Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B255C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A5D610F7
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 18:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhHMSJq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:09:46 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46746 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHMSJq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 14:09:46 -0400
Received: by mail-ot1-f54.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso233360ott.13;
        Fri, 13 Aug 2021 11:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNAJ6CKuegXmSd2Yyh9RqrbADSON9AKbMmt2xHYGKZ0=;
        b=enAd95i+F1XkIoTp5lS6D4lNvzQmu7WQL1kgR+t77upo1YxEgYUVXNZVQs7z440zdE
         AffejsEEwPwBKuvVF1w9dvOi9O1mvAZxQKy2oHOweZgz+QQA5hUaNC/wQn84+pbPMCw7
         L5i/y/+wpQS/lB+5VZiC8RO2v6XiPOokYF70u8Eukhq/f8RmDjGqXn1hT2ROD0KSJitn
         uApM+0HN96+Xnt7PND9jUpHwCPq5X3B7f2NIZl4WxVc2O3G8xIhs9BqtxTOtT/p+CmFq
         X2kM+iH+cB8V7aims2Bn/GOOJlm0jZ7PHwM6nUTlh7Ix/PzHKWdi1L2ixy1qGxabtAl8
         3Ypg==
X-Gm-Message-State: AOAM531vj2VCzmZgI8TWWzxb1Wj4wAosO5R2PDWBUOXhIzVu8I0gnQgK
        d5THD3hKZhN4vmqEDdAr3Q==
X-Google-Smtp-Source: ABdhPJz0uGlikeQEKkF423szyYb04V8X2TX58aZ6PjFZdAZBO9pfrGTtD8c/lMNwUldYLyLlNiyJYg==
X-Received: by 2002:a05:6830:2783:: with SMTP id x3mr3185257otu.37.1628878158745;
        Fri, 13 Aug 2021 11:09:18 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u15sm472572oiu.43.2021.08.13.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:09:18 -0700 (PDT)
Received: (nullmailer pid 3783560 invoked by uid 1000);
        Fri, 13 Aug 2021 18:09:16 -0000
Date:   Fri, 13 Aug 2021 13:09:16 -0500
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
Subject: Re: [PATCH 3/8] dt-bindings: serial: fsl-linflexuart: Add compatible
 for S32G2
Message-ID: <YRa1THsZ/6BFkzo5@robh.at.kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-4-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805065429.27485-4-clin@suse.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 05, 2021 at 02:54:24PM +0800, Chester Lin wrote:
> Add a compatible string for the uart binding of NXP S32G2 platforms. Here
> we use "s32v234-linflexuart" as fallback since the current linflexuart
> driver still works on S32G2.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 26 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> index acfe34706ccb..e731f3f6cea4 100644
> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> @@ -21,10 +21,20 @@ allOf:
>  
>  properties:
>    compatible:
> -    description: The LINFlexD controller on S32V234 SoC, which can be
> -      configured in UART mode.
> -    items:
> -      - const: fsl,s32v234-linflexuart
> +    minItems: 1
> +    maxItems: 2

minItems/maxItems not needed here.

> +    oneOf:
> +      - description: The LINFlexD controller on S32G2 SoC, which can be
> +          configured in UART mode.
> +        items:
> +          - enum:
> +              - fsl,s32g2-linflexuart
> +          - const: fsl,s32v234-linflexuart
> +
> +      - description: The LINFlexD controller on S32V234 SoC, which can be
> +          configured in UART mode.
> +        items:
> +          - const: fsl,s32v234-linflexuart
>  
>    reg:
>      maxItems: 1
> @@ -41,8 +51,16 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    /* S32V234 */
>      serial@40053000 {
>          compatible = "fsl,s32v234-linflexuart";
>          reg = <0x40053000 0x1000>;
>          interrupts = <0 59 4>;
>      };
> +
> +    /* S32G2 */
> +    serial@401c8000 {
> +        compatible = "fsl,s32g2-linflexuart", "fsl,s32v234-linflexuart";
> +        reg = <0x401c8000 0x3000>;
> +        interrupts = <0 82 1>;
> +    };

This doesn't really warrant another example just for a new compatible 
string.
