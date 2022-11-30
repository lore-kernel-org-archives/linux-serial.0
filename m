Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71C8C4321E
	for <linux-serial@archiver.kernel.org>; Wed, 30 Nov 2022 21:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiK3VPl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Nov 2022 16:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3VPk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Nov 2022 16:15:40 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB6862F3;
        Wed, 30 Nov 2022 13:15:39 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id l127so20180356oia.8;
        Wed, 30 Nov 2022 13:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1WUj9zWyrC1e+L03kFAp89FihCih368o6/AwASOyaI=;
        b=RDKOeqRLUAVYO3dfz3TjOsRsDx6rj0q4dYWwvfjXSJAKskBjKX9N7RnS1nqlxHziC8
         TERlUxxGWUvd4RWGj12+XYYAShh9abGr8nAfBI0P4HkK4eOlnzntp7WX6Hy9AV9HMgEh
         dpZkixxTC63wI8sv5BjCAUR32PVhT8Gg7D25ngwH4/aBMjUpLuyAizLB3lYcOCz7dMMY
         GeJJdVnsYspZ6gW2F4S+qwkFZH9hNgojKuAHNlU8MP6faqOCgnOruX5g/TMAFknO8DPP
         UbvEpDmYJrqmhzjllkbDsUYmwes3Hw8PMm1N+wTLMbxQNx/VXIy+kQUFVYyoWaMeQQeX
         dRfw==
X-Gm-Message-State: ANoB5pkyKbUudRqa4fbM4vN9eZxl0eIT33Gw101gzmOexI181512XikT
        qTpIFVEiE1d+JxtKArQjCA==
X-Google-Smtp-Source: AA0mqf7zSC9P3R1awSY68MbRIxwFiUbYKx3tCXC89GAfio9L+8bZVQDPRbJusHthEFH2YarrfOv9Rg==
X-Received: by 2002:a05:6808:120f:b0:359:d3d6:45d2 with SMTP id a15-20020a056808120f00b00359d3d645d2mr31033386oil.132.1669842938657;
        Wed, 30 Nov 2022 13:15:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w22-20020a9d77d6000000b0066c495a651dsm1350898otl.38.2022.11.30.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:15:37 -0800 (PST)
Received: (nullmailer pid 2940448 invoked by uid 1000);
        Wed, 30 Nov 2022 21:15:37 -0000
Date:   Wed, 30 Nov 2022 15:15:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, marex@denx.de,
        jirislaby@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Dahl <ada@thorsis.com>, kernel@dh-electronics.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/4] dt_bindings: rs485: Add binding for GPIO that
 controls Rx enable during Tx
Message-ID: <20221130211537.GA2926121-robh@kernel.org>
References: <20221123123004.7216-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221123123004.7216-1-cniedermaier@dh-electronics.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 23, 2022 at 01:30:01PM +0100, Christoph Niedermaier wrote:
> This patch adds a binding for a generic definition of an output GPIO that
> indicates the state of rs485-rx-during-tx. The idea is that the hardware
> already controls the option receiving during sending before it gets to the
> signal receiving hardware. The standard RS485 is a half-duplex bus that in
> most cases is driven by an UART controller. The advantage of using this
> GPIO is that it is independent of the capabilities of the UART core and
> the UART driver. On the hardware side the interface to the bus is
> controlled by a transceiver, that has a pin called RE (RX enable) or
> similar, which connects the bus to the RX signal of the UART controller.
> The GPIO can switch between two states to control the RE pin via an
> electrical circuit:
> - Active:
>   The RE pin is always active. The UART RX see everything on the bus and
>   therefore also what happens with the TX signal on the bus.
> - Inactive:
>   The RE pin is always active, but during sending on the bus the pin RE is
>   inactive. So basically the receiving during sending is suppressed.
> 
> A possible circuit diagram could look like this:
>                                   ┌──────────────────┐
>                                   │       RS485      │
>                 TX ───────────────┤D                 │
>                                   │    Transceiver   │
>                RTS ────┬──────────┤DE                │
>                        │          │                  │
>                        │ ┌─────┐  │                  │
>                        └─┤&    │  │                  │
>                          │     ├──┤!RE               │
> !rx_during_tx_gpio ──────┤     │  │                  │
>                          └─────┘  │                  │
>                                   │                  │
>                 RX ───────────────┤R                 │
>                                   │                  │
>                                   └──────────────────┘
> 
> Here the RTS pin of the UART core is used to control TX via the transceiver
> pin DE (Drive Enable). RE and rx_during_tx_gpio are active low.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Alexander Dahl <ada@thorsis.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: devicetree@vger.kernel.org
> To: linux-serial@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Rework of the commit message
>     - Rework GPIO property comment
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> index 90a1bab40f05..6d780911e342 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -51,6 +51,10 @@ properties:
>      description: GPIO pin to enable RS485 bus termination.
>      maxItems: 1
>  
> +  rs485-rx-during-tx-gpios:
> +    description: Output GPIO pin that indicates the state of rs485-rx-during-tx.

An output sets the state. An input samples or indicates the state.

This should include something about the active state: The active state 
enables RX during TX.

> +    maxItems: 1
> +
>  additionalProperties: true
>  
>  ...
> -- 
> 2.11.0
> 
> 
