Return-Path: <SRS0=s89U=ID=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9F4C433E9
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE916509B
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 20:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCEUt4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 15:49:56 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:42879 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCEUtk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 15:49:40 -0500
Received: by mail-oo1-f43.google.com with SMTP id g46so743627ooi.9;
        Fri, 05 Mar 2021 12:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnTipdodrhezdr0qtRmFWS1eLHElQWNq0/37BBeYMdE=;
        b=ATOXTDDwJ2lZQ0rVZFsmxM0xdP0JLo5wYvcdz1JSz7tBaaCui/SVuurDvA4RoHKlwu
         pr392Yj1RlLhOyOh6vNUqiEHT0TYKPRgTftZTIAMe3CM+itXruyhLL9iUkY91CkXykbP
         grzwqAD6zTo1Kw3ddEK6gkJd59RBSrWqf1szjWZzACbhMWsgqk4soRcP5gdVTvQJ081n
         Dh1RXHdA8NbJnkv7yGL0/0hi7BgZtTdhnA8M7OrngPp7G3k9OIBYhPk433FXybkqbGsy
         DkiHvj5rujf+CHXhVIJEgjzdYgUw062v73FB3QSP9wc/y7fGp7Fgl4d0TS3uRGSzv2s+
         4yrQ==
X-Gm-Message-State: AOAM5305pe6AeqZ0kY3VXUgcE9BoKCMjj/rd/XnZCgEnMSwxUVngsypt
        2gcxJTh7UWFh88aEEsAK7aqxUrbDWw==
X-Google-Smtp-Source: ABdhPJzo6ZfNqVjcYA3VmxyzGIsyYKo4B3883JMz6dmzdwvUn5AZno6ENRQgxm/A+KC06hqpfYhYcA==
X-Received: by 2002:a4a:e1e4:: with SMTP id u4mr9254495ood.41.1614977379986;
        Fri, 05 Mar 2021 12:49:39 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v22sm822524otj.57.2021.03.05.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:49:39 -0800 (PST)
Received: (nullmailer pid 620933 invoked by uid 1000);
        Fri, 05 Mar 2021 20:49:38 -0000
Date:   Fri, 5 Mar 2021 14:49:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: serial: samsung: include generic
 dtschema to match bluetooth child
Message-ID: <20210305204938.GA613254@robh.at.kernel.org>
References: <20210212163905.70171-1-krzk@kernel.org>
 <20210212163905.70171-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212163905.70171-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 12, 2021 at 05:39:05PM +0100, Krzysztof Kozlowski wrote:
> Include the generic serial.yaml dtschema so the child node like
> "bluetooh" will be properly matched:
> 
>   arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
>     serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/serial/samsung_uart.yaml         | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 3e29b561223d..f4faf32ab00f 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -78,9 +78,11 @@ required:
>    - interrupts
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  allOf:
> +  - $ref: /schemas/serial.yaml#
> +
>    - if:
>        properties:
>          compatible:
> @@ -134,3 +136,25 @@ examples:
>                   <&clocks SCLK_UART>;
>          samsung,uart-fifosize = <16>;
>      };
> +
> +  - |
> +    #include <dt-bindings/clock/exynos4.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    serial@13800000 {
> +        compatible = "samsung,exynos4210-uart";
> +        reg = <0x13800000 0x100>;
> +        interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
> +        clock-names = "uart", "clk_uart_baud0";
> +        dmas = <&pdma0 15>, <&pdma0 16>;
> +        dma-names = "rx", "tx";
> +        pinctrl-0 = <&uart0_data &uart0_fctl>;
> +        pinctrl-names = "default";
> +
> +        bluetooth {
> +            compatible = "brcm,bcm4330-bt";

Do we need a whole new example for this?

I'm also trying to get rid compatibles without a schema so we can turn 
on warnings for that, but fortunately Linus is converting Broadcom BT. 
And looks like it should pass.

Rob
