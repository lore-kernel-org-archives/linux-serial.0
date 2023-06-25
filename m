Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D6EB64DD
	for <linux-serial@archiver.kernel.org>; Sun, 25 Jun 2023 15:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFYPkj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 25 Jun 2023 11:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFYPkh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Jun 2023 11:40:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C72C4
        for <linux-serial@vger.kernel.org>; Sun, 25 Jun 2023 08:40:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9a925e9aso113677a12.0
        for <linux-serial@vger.kernel.org>; Sun, 25 Jun 2023 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687707633; x=1690299633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTQp0n2oXhJA5Ac6MISqa3fJgp7uxeLkw3KpR5ufcr4=;
        b=Cd7SgRQi+l52dqC1OE/wwuXDAiJ2UhbVd/Rk9e8oWDT/tQ2l5Y+RBse4O6Q+9/k1Vq
         GxgNDGaCbftz40WMfeIn3HFp5gmmsgbU55++OwSx7GF6WdTmg4FpE+x2+oWcfstFTDoJ
         yNg9+bbXiKdiki/1OxgFJ8agJJvlKuz1mpF1nAbYlQKbgcja6Dk/wjBhO6k8NSOfMf3W
         rgWPQDyHhJiCT/Hv0cjqDfAsWVGi5sZlXil1aw26LWyk3nyn/AioIvZ5ND3qX+/YGOil
         lFUQi0QJRvYrTLSyp91wOopkX05fZcMHphVkkObo9KaXaaTsCcQO/b1W5uJ4NSJFw0Dy
         yc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687707633; x=1690299633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTQp0n2oXhJA5Ac6MISqa3fJgp7uxeLkw3KpR5ufcr4=;
        b=hJjMSJC8abxa/rBQDlqfv1+vfj6M1HGmmJ+I5jTp/zuS/R1OBYermZPX+tATUtFNqk
         FsiT4+i1CE8Q1hko4R6WvnzYWIMGVOHG+4mrjRyUdYXs44TYBDKC8Pk4U2AhsoYxVBNe
         yLlNwsAVBq/o3Bwm91/vXG3PRIXie1d8/zRgG3vHg5D/ce711H8P4wckRbRxEykU6DTE
         Q1FI30ye+TLQO97Q0MtV8whK1jYU8RuXw5jOcg7aSILQvXQlkVOCOXTE6JoEfK9dKQVx
         PujTQGYiOC7m58OhiHKNjVe+nZHc/ExdvvGMzcm5bxSPjkBsKteOR6sYHMplqyIcJu4D
         kBjw==
X-Gm-Message-State: AC+VfDyAXXePf30tZ3R3VmAF3PPTCnFHbFxoO9t4f8KpndXEALOxavJv
        YV/NSqtCkR6+yuJS//PXTD1NRg==
X-Google-Smtp-Source: ACHHUZ4//9aqSdHBFWBy31jPAOHqRPxQmt9OrkOsKtISKlC0LX1C6VDQqpf8tmcL9kDEKcIid6gu3Q==
X-Received: by 2002:a17:906:c359:b0:98d:63c5:d135 with SMTP id ci25-20020a170906c35900b0098d63c5d135mr6987800ejb.54.1687707633619;
        Sun, 25 Jun 2023 08:40:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gr11-20020a170906e2cb00b009884035279bsm2209333ejb.33.2023.06.25.08.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 08:40:32 -0700 (PDT)
Message-ID: <731db330-4a0f-2427-a0ab-318f2d8be73b@linaro.org>
Date:   Sun, 25 Jun 2023 17:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
To:     Sherry Sun <sherry.sun@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230625094857.29644-1-sherry.sun@nxp.com>
 <20230625094857.29644-5-sherry.sun@nxp.com>
 <d990a281-b4a3-1e26-1fdf-dfd35ab9cd24@linaro.org>
 <AS8PR04MB84042EF903689014CC0C33809221A@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AS8PR04MB84042EF903689014CC0C33809221A@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/06/2023 15:12, Sherry Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2023年6月25日 18:18
>> To: Sherry Sun <sherry.sun@nxp.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
>> Shenwei Wang <shenwei.wang@nxp.com>; gregkh@linuxfoundation.org
>> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> kernel@pengutronix.de; linux-serial@vger.kernel.org; linux-
>> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
>> compatible string
>>
>> On 25/06/2023 11:48, Sherry Sun wrote:
>>> LPUART driver adds a new compatible string for imx8ulp, and imx93 is
>>
>> What driver adds or not, is not really correct argument for compatibility.
>> There are plenty of compatible devices which have both device ID entries in
>> the driver. Why would you drop their compatibility between each other? It
>> does not work like that... Provide clear rationale for this.
> 
> Hi Krzysztof, 
> We take imx7ulp lpuart as the basic version IP, then imx8ulp adds some improved features based on the imx7ulp lpuart IP.
> Actually imx8ulp can also work with the imx7ulp version, we can say it is compatible with imx7ulp, but we need to enable those new features by default on imx8ulp, so we added the imx8ulp-lpuart compatible in lpuart driver. So for this case, maybe compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart" is correct for imx8ulp platform, right?
> 
> Then we have the imx93 family with the same lpuart version as imx8ulp, so how should we handle the compatible string for imx93 platform? Maybe compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart"? But three compatible strings looks too long for me, so I want to drop imx7ulp-lpuart and take imx8ulp-lpuart as the basic compatible string for imx93 and later others imx9 series, I am not sure if it is suitable, some suggestions here will be appreciate, thanks!
> 

Wrap your responses.

So write that the reason of this change is because looks too long for
you and we will judge that rationale. Three compatibles is still fine.

Best regards,
Krzysztof

