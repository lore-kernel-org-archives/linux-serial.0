Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD9C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 23:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiLAX4l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLAX4k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 18:56:40 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6810CC4CD9;
        Thu,  1 Dec 2022 15:56:39 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id c129so3834751oia.0;
        Thu, 01 Dec 2022 15:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIyI39P8SJzCnimdCkeu7VLmpsMh+bZzeALK8ZP35Cg=;
        b=KLcz0Fl/HFaW3k6OvAuNsJFgL/Do9UktJoIOBbWDL0sapM1PgvNZZsM9PCkKcpq9Jc
         cXuQEKkt+AdUPc3Glte9R8TeSGTQkWy3Ye1GJs1OJZnOR1Qag7Vs3kEhAbIAGpgDM10o
         4byAxhSZOrra2gBSQjrwM46cCqHQN2B9V/Znn9i0geuGqAeudvrBeZ46j2XwRR8lAmKB
         2GLbabDNZsG5gNUoujesgK9FPKNeTmSaIUBf2deXBFihkPY1EOcvLrJOwFfXPre+PFHr
         SNlzSM/GPC84U7pESFtvJ04xdvkqcyayl9Gk3q9IUotYdFIokxO7nDwv2ZN3Q36bq4qT
         7pGA==
X-Gm-Message-State: ANoB5pmo9xjBdVlOq4+LTYepBwb+avKdgoEdmZohHnvUoK4KDXudg+Kd
        NvgLl5Dfqsi2y/9CTXqFHQ==
X-Google-Smtp-Source: AA0mqf5dQRZR0sppca3oLs9aYIq4JAf9PNKY3DHEYyF9brvdZb5zz5G4UmAJ/O/ieb5VtNdR8cRfGQ==
X-Received: by 2002:a05:6808:1782:b0:34f:6e46:5b04 with SMTP id bg2-20020a056808178200b0034f6e465b04mr24115882oib.43.1669938998587;
        Thu, 01 Dec 2022 15:56:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x186-20020a4a41c3000000b00494ed04f500sm2310947ooa.27.2022.12.01.15.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:56:38 -0800 (PST)
Received: (nullmailer pid 1718136 invoked by uid 1000);
        Thu, 01 Dec 2022 23:56:37 -0000
Date:   Thu, 1 Dec 2022 17:56:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     kernel@dh-electronics.com, Alexander Dahl <ada@thorsis.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        marex@denx.de, linux-serial@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/4] dt-bindings: serial: rs485: Add GPIO controlling
 RX enable during TX
Message-ID: <166993899697.1718097.6798394044002195647.robh@kernel.org>
References: <20221201110237.7917-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201110237.7917-1-cniedermaier@dh-electronics.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Thu, 01 Dec 2022 12:02:34 +0100, Christoph Niedermaier wrote:
> Add a binding for a generic definition of an output GPIO that sets the
> state of rs485-rx-during-tx. The idea is that the hardware already controls
> the option receiving during sending before it gets to the signal receiving
> hardware. The standard RS485 is a half-duplex bus that in most cases is
> driven by an UART controller. The advantage of using this GPIO is that it
> is independent of the capabilities of the UART core and the UART driver.
> On the hardware side the interface to the bus is controlled by a transceiver,
> that has a pin called RE (RX Enable) or similar, which connects the bus to
> the RX signal of the UART controller. The GPIO can switch between two states
> to control the RE pin via an electrical circuit:
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
> V3: - Rework the binding description
>     - Rework message title
>     - Rework of the commit message
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
