Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A739C05027
	for <linux-serial@archiver.kernel.org>; Sun, 19 Feb 2023 09:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBSJqu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjBSJqu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Feb 2023 04:46:50 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2A12F33
        for <linux-serial@vger.kernel.org>; Sun, 19 Feb 2023 01:46:09 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c65so1110578edf.11
        for <linux-serial@vger.kernel.org>; Sun, 19 Feb 2023 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJntxz4d8bIHPiBQgUEYlKd1uQSFWcfmni6Frb9jtyc=;
        b=N/2XDyiDAGlKgc3TaLq6KMju7SZX9eEOoRTxfStQuvL3wKrYIO3Nj7Tn59TqcUUNKu
         54BtUE99hMbv4KVdMm4NqZ4w35ALd2eJW5XLuTTf9/f6eWTwet93ZZLjAlf9W39gM0Zz
         yR6MZeTrqz8sl9hFR4ndLQLWy1s/hsqgd1sju39oxGVRTzD6aK8qNTiZHHXmGWp/cejL
         Q4TYdi40igr+oL5OJHz9l8NpKOD43ZDaR1GAVTGIb4duy97o2fRe0wPI0HgMwG0z+8wc
         7Q0VKHZ4/SYRkfa9ClVhCLqyO93695DwcbwMv9vDSz81u7xoGYZQpGwgmiwZiHVcnpgk
         MeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJntxz4d8bIHPiBQgUEYlKd1uQSFWcfmni6Frb9jtyc=;
        b=SG2HqYan0jAKZXHLiKyost5ZuIUOZ5uUgw8d2qomyR98SE86/oedV6a/VqZFtnCYb2
         256D4aqIUxs4hbD08luGzqi8g0tJoYKjSo6vQSBa8mqkmgp80ZGY58TfffCN224yG4sQ
         j+gO8cbyRZ7sbot+jE4UOgJgpbrWB/QBlMpTpq0mS3V5r6UcCoXlIyWCTQ7+bLUOCn5R
         TYV9FwmBTNBNbtGkWUYZIfFHomGqmwXW/EZ0cK/pnWogQHkglVhNVCgvBzRN6WerkJDI
         wdLZN7oAdJ9kE89oyZt+mEd2ZKiJKJQMBYO3RulnEE03Wx1yvOAFJS2kNmS1Qbs87L99
         GdSg==
X-Gm-Message-State: AO0yUKV3HIpDjfB0uQNftLZ57ufD6jA2WrpcQPs+UJrz70NkzOkqCF99
        rauiXqvjhcJEv2+xUfSSJsK8zQ==
X-Google-Smtp-Source: AK7set+/2plUttzZDp75JGZ7GVwRhhqqjohq/sBAYcfGQoYHobm18Ehjwa/hC8zBO98Lb5s0Pooq7A==
X-Received: by 2002:a17:906:2894:b0:8a0:7158:15dc with SMTP id o20-20020a170906289400b008a0715815dcmr6745616ejd.74.1676799879212;
        Sun, 19 Feb 2023 01:44:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s21-20020a1709060c1500b00887f6c39ac0sm4315263ejf.98.2023.02.19.01.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 01:44:38 -0800 (PST)
Message-ID: <dfbb244b-576b-a664-3d2b-996aadc39175@linaro.org>
Date:   Sun, 19 Feb 2023 10:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: serial: imx: Document optional DMA
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230218223959.116358-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/02/2023 23:39, Marek Vasut wrote:
> The UART IP can be connected to DMA engine, document the properties in DT bindings.
> Update example to match Linux arch/arm/boot/dts/imx51.dtsi .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Fabio Estevam <festevam@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

