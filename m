Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4BFC6FD1F
	for <linux-serial@archiver.kernel.org>; Sat, 11 Mar 2023 13:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCKNpc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Mar 2023 08:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCKNpb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Mar 2023 08:45:31 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD1E12A159;
        Sat, 11 Mar 2023 05:45:17 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id e21so6414805oie.1;
        Sat, 11 Mar 2023 05:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/yxGBjJWYHSDKTiHFSEDygkdbxssA9wfkJfJYmMlGw=;
        b=f3Ia6fSh3iUXXz9mzcmteVYI0LDwDEH2hWimdh6Z9Eb1Mf2rDxYgxQ1UuJdcyKYLkz
         urZollDXBZkRo71ybwgDr4XpHj2dJTdF77wu/7dpuvjL7GafrrkkRFjcuPlv76PT/i0b
         +indmC/R/QHCAlVJEStrmt/IAOr6c2Tdx94zLrumnGLGgP+jTrZlaDoWKBq/JIC8H4Hr
         m1lwbXrOY7DuR9APACOmNhc7ar4PMg9VIyyjFzd5u22BZiLlFsbUdb2jF0f1FWjABx7g
         WKnhRnlrsYzHmpwfkctoapN+ZjSGnJJ/SrvfsATrl/K9nZvCVE/hRnE1Xfc/kI8xIkN3
         uSxQ==
X-Gm-Message-State: AO0yUKXnpeweCMHVE7Lfd/CRPsuZEmFxOoFIynZZdYM0ayffWdztJQdG
        gcI4l5cnfyh4KEOJD9E1eA==
X-Google-Smtp-Source: AK7set832JJbSMM00eLNYQW7qdwTXKNOJD+8e5BwJxEJiJKYv+ZhJ1MVeE7vGwHtwXoHgfdJlO/7vA==
X-Received: by 2002:a05:6808:b12:b0:384:18f4:1536 with SMTP id s18-20020a0568080b1200b0038418f41536mr13462686oij.32.1678542316277;
        Sat, 11 Mar 2023 05:45:16 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:ec2:d840:96d4:1bbf:55f])
        by smtp.gmail.com with ESMTPSA id s188-20020acadbc5000000b003847ca255fasm1054934oig.30.2023.03.11.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:45:15 -0800 (PST)
Received: (nullmailer pid 31469 invoked by uid 1000);
        Sat, 11 Mar 2023 13:45:13 -0000
Date:   Sat, 11 Mar 2023 07:45:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v11 2/3] dt-bindings: serial: mediatek,uart: add MT8365
Message-ID: <167854230361.31217.14194578578496265497.robh@kernel.org>
References: <20230309213501.794764-1-bero@baylibre.com>
 <20230309213501.794764-3-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309213501.794764-3-bero@baylibre.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Thu, 09 Mar 2023 22:35:00 +0100, Bernhard Rosenkränzer wrote:
> Add binding description for mediatek,mt8365-uart
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

