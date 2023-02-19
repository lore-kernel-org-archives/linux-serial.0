Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF83C636CC
	for <linux-serial@archiver.kernel.org>; Sun, 19 Feb 2023 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBSJqM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjBSJqJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Feb 2023 04:46:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A7A10A83
        for <linux-serial@vger.kernel.org>; Sun, 19 Feb 2023 01:45:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ek25so965586edb.7
        for <linux-serial@vger.kernel.org>; Sun, 19 Feb 2023 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JneDP0bDgvfKWdaW0KK9oGWtetqft4yeKn5WzSIp1ys=;
        b=mbHq3fnGOuobcYacSXEe+X6xgkxM6tuv6Vqygv+5nZxzU6MbeSPDdQ2DcV8Hby0gCb
         Sf4+5fJBWqJA+rocfWIWdm5RACDdwltZ7C+GcAzbAG/DkL1PwDnlqy8P0byIELTzdqh3
         DV0VMD+WvL7p13tMWPT2YJxeP4+SYr3qW76EHctuEviKchVFQbQISXYNlWguTDZS+Dj1
         aWJMVMVXnKKeuL28aphGNBOW7MVLlDccDUx50FegwSS7uc1AHoghgON4U5Mf9ccQ+abt
         SZVd2PwMaHdqWuKBDzCODpFYBk4nOpFAt6vp+0x04zRMz9AMJCmyfq1NKY727E+B5ON+
         dKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JneDP0bDgvfKWdaW0KK9oGWtetqft4yeKn5WzSIp1ys=;
        b=GBdQq02O0Rw0/q98hBJi7q+fbDfep3huIfNOQu0Sw7ej0NpcG207jfhb/cQD0f+sON
         BlupgP3anp7ftXuyXuKUJa8kLUY670tq9mQJmbyPFHXJrnuWuhGXPQNgDOG/a112beme
         vfn+FJK57mm8OJhvSQEs2kvoj7Sj1OIPiB52SWR4lAu3CcW9v8DDr/cBLjbaycoxJRNb
         KAq3TjOEu1OHonZnanFIZFMu1GideZDcR9BOjrYWFrg7aSun9rSEIwfbJWHBrGfCB/9n
         KkiH+9qRqOI5pxw2c41MqW6aCbnk0YQYV2Bz/+LEhY++c1Tb6xgOIDJ/z7fJo+gXH1+y
         ilTQ==
X-Gm-Message-State: AO0yUKW/zg8Ci09qt1M7EYRaUblbi491DSFEKaUSfzQYDMmBlldhvvnA
        DgcgpCHnYHDyz1nwR1LfMvEo1w==
X-Google-Smtp-Source: AK7set/QSoNWU/UHpK7LD0UqpZO7pjmUjbX5gc7W0yLGyo9zGmZqOsphF3gvtb9jYAiTpTj3ot7ZuA==
X-Received: by 2002:a17:906:35d5:b0:8b1:e791:faef with SMTP id p21-20020a17090635d500b008b1e791faefmr7015856ejb.67.1676799844361;
        Sun, 19 Feb 2023 01:44:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090671c100b0087bdae9a1ebsm4316472ejk.94.2023.02.19.01.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 01:44:03 -0800 (PST)
Message-ID: <cc771b27-cc59-de1f-02da-a2818c12e8b8@linaro.org>
Date:   Sun, 19 Feb 2023 10:44:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] dt-bindings: serial: imx: Document mandatory clock
 properties
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20230218223959.116358-1-marex@denx.de>
 <20230218223959.116358-2-marex@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230218223959.116358-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/02/2023 23:39, Marek Vasut wrote:
> The UART IP must be connected to clock, document the properties in DT bindings.
> Update example to match Linux arch/arm/boot/dts/imx51.dtsi .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-serial@vger.kernel.org
> ---
>  .../bindings/serial/fsl-imx-uart.yaml         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
> index c22aab8c55f83..d42061331aba3 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
> @@ -49,6 +49,18 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  assigned-clocks: true
> +  assigned-clock-rates: true
> +  assigned-clock-parents: true

You shouldn't need these three.

> +
> +  clocks:
> +    maxItems: 2
> +


Best regards,
Krzysztof

