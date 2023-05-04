Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF674C77B7C
	for <linux-serial@archiver.kernel.org>; Thu,  4 May 2023 06:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjEDGaB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 May 2023 02:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjEDG37 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 02:29:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D72684
        for <linux-serial@vger.kernel.org>; Wed,  3 May 2023 23:29:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659e9bbff5so11760166b.1
        for <linux-serial@vger.kernel.org>; Wed, 03 May 2023 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181790; x=1685773790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKDghn2BEzef2X05qs9Bay+N6tZZ6zhNZbbQNcDAi/s=;
        b=jY89SL8jkoTW1rehE16YV3Kv+XZi1ga80FlmYc5KdWLuT82lWIXEy+kT9npuNhhTCC
         IVot5eVw3iWlvT0GTziyqWYH6TvE00ZADAQJY1NZEWJ7bqW/NJe3ElgS5wCQoGVeqsNb
         UtrRvgeWsa5E9ugG6lSiSFsLiiVey7DHiUBbGnyq2RzpM1VsCPzep/9ibQbBqnFm+UN2
         ChSSx8C4Oh6MCGU97uQEkuZhinBqXKyPCSYJxdV/nU0WIe1+l2Sh2XzfDpUWTLq6GXVv
         PM+xudNzGugw5W3T4rgJtlON+rjYAJor0ezqCJ4/kEkwT+Ojq7rfb+oHUQ+6ywbC5ySz
         MKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181790; x=1685773790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKDghn2BEzef2X05qs9Bay+N6tZZ6zhNZbbQNcDAi/s=;
        b=WRLUg/AAHPfmORojFI/io+7GCpF3MnXrLeIBbbCG43DKFaF+cMxVUWcq4DcKlYGBIi
         iDpUMyxqugq5qdk6bqoCAmUE2XKWcV5pH2B0XoNKYiYzZMukzYeUqzEvmANBbHt6JKRB
         CTnAsTv9XK8GI0ORdBrWuSFNnFlvgiDDZfDDosHl2UYZIlzR48LywxW7FMtoasDSlzt2
         54B/1PTl6eZLSk3hDMoYunaxafSNsvsV0fJx0c3fEsCKyYscjdqygRp+oPMWXDrEYJRS
         E8+XsuxRxvUpY6shw85mdstkOT0VYJkml8Tt5ts8whHZYz9bVk/MdSC3NCNqsUtMf2R9
         kvqA==
X-Gm-Message-State: AC+VfDwzJhBhliwhl9R70k7sQA5UPs0ID3Lf8wFWhVMlXQFWEq1ZYb6u
        95D2vtKtUzvkuv78e+apeNqMFA==
X-Google-Smtp-Source: ACHHUZ4L72kydfTXaK8lkI4sPCk/X09R0evirbNAkxA8WqVqFLyJgSHDJUl5pxE7BcYaMscALWexzA==
X-Received: by 2002:a17:907:1693:b0:94e:4c8f:758 with SMTP id hc19-20020a170907169300b0094e4c8f0758mr6212909ejc.76.1683181789930;
        Wed, 03 May 2023 23:29:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id gt11-20020a1709072d8b00b0094f07545d40sm18151574ejc.220.2023.05.03.23.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:29:49 -0700 (PDT)
Message-ID: <4ee1f249-ad75-273b-f8f0-e5b00a3d77a3@linaro.org>
Date:   Thu, 4 May 2023 08:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v9 01/10] arm64: Kconfig.platforms: Add config for Nuvoton
 MA35 platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-2-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504033726.93-2-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/05/2023 05:37, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

