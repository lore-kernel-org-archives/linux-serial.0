Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA1C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 14:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbiCKOxx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349439AbiCKOxw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 09:53:52 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA619CCC5;
        Fri, 11 Mar 2022 06:52:48 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so10752922ooc.4;
        Fri, 11 Mar 2022 06:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XouDAonvXlO6XU2IHSFCooSQTQ5SzgR1sMybojkfzAI=;
        b=EgY27qioBEkTd8PkRaG91a6dO58+0mM0YqJZbufrDf+r2acEGmywtBFL+mwM/YN9iP
         GnuHRhJ6jRxZXkq8P0pfbFeUZd4Zn+PHz4jpwn57vjY7iA+aeR59C7UzUlHgurDw0UYQ
         0aIarLUAhdvbTHUIiTR4jfZNc9iDG1Jj36m/CPb0XK/lSmO9aaJwTGySM+TRN6glpRRA
         XHzfeLmHAhiuroYzESqa9OOpES38e61np89jTkHby/N0xDPtccBMpdOCtu/1L1TV2185
         mVOZzm7wnkwGkLXDOV3UCi1iS+KZojIThTMy4KvJ3YEhCmw3pLQQtt6Qv1F20HS/pvUT
         H1Ng==
X-Gm-Message-State: AOAM532z8ewZSADPxQDfzg2jL7PY2WIO9u8LdIZA3n4+iwhNivW/zsbK
        x1gVWwjGAySV2m9td8oiag==
X-Google-Smtp-Source: ABdhPJwVM00FBPusKKPXsuJpjuUgFPFT6v1xv+HzGc+G1sqBrbm5F+Ukz/YBeNSj5BBqeajDFr8FEg==
X-Received: by 2002:a05:6870:3927:b0:da:34c1:560c with SMTP id b39-20020a056870392700b000da34c1560cmr10991064oap.176.1647010367441;
        Fri, 11 Mar 2022 06:52:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b63-20020acab242000000b002d9ddf4596fsm3929216oif.49.2022.03.11.06.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:52:46 -0800 (PST)
Received: (nullmailer pid 3772694 invoked by uid 1000);
        Fri, 11 Mar 2022 14:52:45 -0000
Date:   Fri, 11 Mar 2022 08:52:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     krzysztof.kozlowski@canonical.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, jirislaby@kernel.org,
        kernel@axis.com, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
Message-ID: <YitiPSZp4thtal8D@robh.at.kernel.org>
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
 <20220311094515.3223023-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311094515.3223023-2-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 11 Mar 2022 10:45:14 +0100, Vincent Whitchurch wrote:
> Add a compatible for the UART on the ARTPEC-8 SoC.  This hardware block
> is closely related to the variants used on the Exynos chips.  The
> register layout is identical to Exynos850 et al but the fifo size is
> different (64 bytes in each direction for all instances).
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v2:
>     - Expand commit message.
>     - Define required clocks.
> 
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
