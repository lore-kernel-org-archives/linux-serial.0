Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBBFEB64D7
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jun 2023 15:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFZPq4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZPqz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jun 2023 11:46:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284DAA
        for <linux-serial@vger.kernel.org>; Mon, 26 Jun 2023 08:46:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa99b57a38so9244465e9.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Jun 2023 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687794412; x=1690386412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuyd+JwwqaO421Phj2bcif4AP94MQRTvv+PwrSFLFR4=;
        b=Fpd1/uc/n1/Ajw2dWe2J7i7v9Gm9dFqHeILW7ruQxvPPhmF450sMKmpPGRpfGyKGyT
         J3V7+0U0F2rQVmpfK/SDhupwA2yxKg0/orp3c93+JPDFFG9drtlrLPJxh2av9hxHriHe
         qln1XYis3OYB6Rpqd/m6MmaI/GXec/COr3JhIgUJwq/8SgYO7B1k2Q4mcZ6Nz6Avt8Ip
         a2Xv5ER6QCzMfWY51qNs+No/lB3XXzQb7kvsvVHO6msN7FyvAx4pim2HmjBMd93gmCPy
         RIghya+k2XIcyhGMC8tM53o/kRI2I81WwQCgVFcTZDBrPF9RFULR3czc023oTPmOdCMJ
         U1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794412; x=1690386412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuyd+JwwqaO421Phj2bcif4AP94MQRTvv+PwrSFLFR4=;
        b=VRtfLFJCrImB8+81d6gtTFgkdNy253ctAxCb7y950JhV+Kuzzw8pD9mmo7NfDI2Fdc
         ItMolXBPS5MAlwG1KRjXSrxcHnh5t8m7k+hHVQvIocljEccz1bj+S0FDWBXoJwBTeRlH
         +thbVhX+G7vs1M9SnO8ZfyKqCUgtkXSkc+G51tDUnPqW9CdCeyf9d5SG6T2XpLqecrWc
         G0XXCiR2Y3iM7cKmPl1mQT5feFTwP+64554aKMCkAMJvHGfgou4DDMwyxKZdSmqnNEwm
         MAHOlWfkx61m1Czf8aSI8fUlnUy3RYO+dSgAC7rik2sa1M/FzaisObLJ5bv63TiSmbhf
         unAQ==
X-Gm-Message-State: AC+VfDyX4mb82eYGyRQFRqx9gJRoHuQG/CtCeBMzArHTuE8EcHgOguPT
        D6gYJidcufz8HZt4t7NOTsob5g==
X-Google-Smtp-Source: ACHHUZ4IciPsQ27k+EaZUw+CnlYv/gil5R552nx9wEUsptp1MsH241H58P77k7otlXySwpStb8DMDA==
X-Received: by 2002:a1c:f70a:0:b0:3f7:34dc:ed0d with SMTP id v10-20020a1cf70a000000b003f734dced0dmr20350694wmh.25.1687794412614;
        Mon, 26 Jun 2023 08:46:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdd4c000000b0030903d44dbcsm7765005wrm.33.2023.06.26.08.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:46:52 -0700 (PDT)
Message-ID: <989b42c2-8b5f-5eb5-d61b-dc3f29b374b2@linaro.org>
Date:   Mon, 26 Jun 2023 17:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 3/3] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20230626044848.4417-1-sherry.sun@nxp.com>
 <20230626044848.4417-4-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626044848.4417-4-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 26/06/2023 06:48, Sherry Sun wrote:
> Add imx8ulp compatible string in lpuart dt-binding, also correct the
> imx93 compatible here, imx93/imx8ulp add some new features based on
> imx7ulp lpuart, so need to add "fsl,imx8ulp-lpuart" for imx93 to enable
> those new features.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index 93062403276b..272bfbb1cdfc 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -21,12 +21,15 @@ properties:
>            - fsl,ls1021a-lpuart
>            - fsl,ls1028a-lpuart
>            - fsl,imx7ulp-lpuart
> +          - fsl,imx8ulp-lpuart

I don't understand this. Commit msg also does not explain this.

>            - fsl,imx8qxp-lpuart
>            - fsl,imxrt1050-lpuart
>        - items:
> -          - enum:
> -              - fsl,imx93-lpuart
> -              - fsl,imx8ulp-lpuart

This could have stayed as enum with one entry which would make your diff
more readable.

> +          - const: fsl,imx8ulp-lpuart
> +          - const: fsl,imx7ulp-lpuart


Best regards,
Krzysztof

