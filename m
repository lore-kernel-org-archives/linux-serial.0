Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF0C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiJZU7P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiJZU7P (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 16:59:15 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FAD1217F6;
        Wed, 26 Oct 2022 13:59:13 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso3855132otn.0;
        Wed, 26 Oct 2022 13:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SGTpGJ14IzV3mTWmW98EDecB40xRhD+qIv4J7Ibrzc=;
        b=YPIlQzxmQNLVhT9Iq6roNrPwOMlfCCFpekAVKLwJyKZChoJhsHdqxBSa1TuTQV/V03
         tBnfKKWFVmdTYHQybSESDQIK/srCKuxQyDEm+5a/cZWbM7mcNPTtBLo6FH3/2DrQxJEO
         p6AGoe0ZPw6uJfie4xbiVBGFDaKNMVLFkQOzn/tY2K0RLzoJSLRcev3glTVCb6uenCvu
         vV9YEeG71GqiMo12QuNppmGAz8T/TPxR3iBPuZtLyM8kPU4XLT0YzUrGaZQBqwp2YIqu
         KGEmQfJDvVU08ENHANqwMj3Puc75iQOOwbJbmrXTan/gROP50P12nCsaqKPEb6US6whS
         PYNQ==
X-Gm-Message-State: ACrzQf3QrJQCGz5j1cplYkzgAKGa14WGRp6pB+dPcwoeL2M4fF0VBRaP
        gWqQP5t1umJ3XW8xHBvddA==
X-Google-Smtp-Source: AMsMyM5kHygF1C7avKvdsYNEhsTiUfv1gpzHowhVZYUGRV2ZVyQ3RIJeLUWjNOlgHtBfx6JMZxuF2g==
X-Received: by 2002:a05:6830:3987:b0:661:b516:6a61 with SMTP id bs7-20020a056830398700b00661b5166a61mr22873954otb.303.1666817953187;
        Wed, 26 Oct 2022 13:59:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p1-20020a4a95c1000000b0047f72b6988fsm2563862ooi.45.2022.10.26.13.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:59:12 -0700 (PDT)
Received: (nullmailer pid 1303800 invoked by uid 1000);
        Wed, 26 Oct 2022 20:59:14 -0000
Date:   Wed, 26 Oct 2022 15:59:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, marex@denx.de,
        jirislaby@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt_bindings: rs485: Add binding for GPIO that
 controls Rx enable during Tx
Message-ID: <20221026205914.GA1294440-robh@kernel.org>
References: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
 <20221026165049.9541-2-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026165049.9541-2-cniedermaier@dh-electronics.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 26, 2022 at 06:50:46PM +0200, Christoph Niedermaier wrote:
> Add the binding for a generic definition of a GPIO, that controls whether Rx
> is connected or disconnected by an electrical circuit to have the ability
> to receive the signals on the bus during sending or disable receiving during
> sending.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: devicetree@vger.kernel.org
> To: linux-serial@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> index 90a1bab40f05..0ebd7690f85d 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -51,6 +51,10 @@ properties:
>      description: GPIO pin to enable RS485 bus termination.
>      maxItems: 1
>  
> +  rs485-rx-during-tx-gpios:
> +    description: GPIO pin to control RS485 Rx enable during Tx.

Active state means do what? And inactive? This is an output gating the 
RX signal or an input telling the receiver what to do during tx? The 
description is not adequate.

How does this property relate to 'rs485-rx-during-tx' Any combination of 
the 2 being present or not is okay? If not, you need some constraints.

Rob
