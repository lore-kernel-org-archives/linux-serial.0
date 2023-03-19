Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F55C7618A
	for <linux-serial@archiver.kernel.org>; Sun, 19 Mar 2023 11:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCSLGV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Mar 2023 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCSLGT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Mar 2023 07:06:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4831234D0
        for <linux-serial@vger.kernel.org>; Sun, 19 Mar 2023 04:06:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so36536076edo.2
        for <linux-serial@vger.kernel.org>; Sun, 19 Mar 2023 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679223975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBClyZjqzsvX4XcfHoxPbXuLX0hX3wAS1PzOKSKD6qY=;
        b=ceb14UefHIQse6qb+4nApgrCDxC15oK3YeIPm2+MmmsGD8IwI0epyP4s1DrZRVh4+z
         tDMNWO8qp2S/FF3ZEHUiYhrXpnGblatsi3NTCkdn2zlwft/GR2xbZZAmP5MKQilvO+YL
         iYMiFFzQZeMdlJBZEevViB0gbnkaXeorGwfdenxCnmIzAiu263JG/VKI5Ww2jCcSKYHS
         fOkJZBuu8JZE2tKdnGw15pq8s5nNQMcuHm+C6TEi+aJ+j3C0spIAt0wP4OQFrSNV6lV4
         atEKzpj+jSIZ35pcza41zU6NmuZ0H0qp/cakvd5pgYJJQXICgZlF4lekabXndN2ijX2H
         bGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679223975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBClyZjqzsvX4XcfHoxPbXuLX0hX3wAS1PzOKSKD6qY=;
        b=2pWF8OG5eFKDY8WY19rl2+eg/UOVY5bYzs9rkhF0TDStNvo0ThGg3fS7E6otwCT5Ty
         2cohT9o1Qq+HqFRp215tBJpekEPm0WzRWo/GYvDs5d+4efUOek2+cqkhNSW7yiZSEGr5
         t+48glt6U+TS5esQ/XSchvEt3QtqE5RK56PO934L7nGDg3J3TG4+uP6lwra02KyMz+GW
         C2fj4CMmkCvwfr1fzyJd8WDSDiWL4zJVdJf26bp4S493oCHxGc6hh/0I3f9VlHRsalvr
         1RcFofd5st1S0ggNHzauFNt24Tg13XbayXoKV2+2aAOCYwWPzujP/zQfEcPkKWcnKWqP
         lfxw==
X-Gm-Message-State: AO0yUKXfcro9hH3up0MV3WZ4RYt3envztDDdroENXXjvgqzC+/vQ9Pu6
        Hno2+dngZ0yl0/nj6W6uR567SA==
X-Google-Smtp-Source: AK7set+09rHLmfBFB8O9udJ+850QNdD95CbOHTD0fZ1NophhDuk/Rlf/ZKLukSxggEy5xfDNzUMgfw==
X-Received: by 2002:a50:ff17:0:b0:4fa:b302:84d9 with SMTP id a23-20020a50ff17000000b004fab30284d9mr9364725edu.14.1679223975316;
        Sun, 19 Mar 2023 04:06:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id s29-20020a50d49d000000b004fc2a75c6b3sm3376851edi.23.2023.03.19.04.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:06:14 -0700 (PDT)
Message-ID: <87171ab8-9c6d-3978-6d34-4ae922361307@linaro.org>
Date:   Sun, 19 Mar 2023 12:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <fb4f60a7-011e-3745-cc40-631247735f2b@linaro.org>
 <c902606e-8a1b-6673-02c7-7beea5477795@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c902606e-8a1b-6673-02c7-7beea5477795@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/03/2023 07:07, Jacky Huang wrote:
> 
>>
>>> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>>> +			      IRQ_TYPE_LEVEL_HIGH)>;
>>> +	};
>>> +
>>> +	uart0:serial@40700000 {
>>> +		compatible = "nuvoton,ma35d1-uart";
>>> +		reg = <0x0 0x40700000 0x0 0x100>;
>>> +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>>> +		clocks = <&clk UART0_GATE>;
>>> +		status = "okay";
>> Why? Drop the line... or convert it to disabled. Otherwise, why every
>> SoC has serial0 enabled? Is it used internally?
> 
> 
> uart0 is on all the way since this SoC booting from the MaskROM boot code,
> 
> load arm-trusted-firmware, load bootloader, and finally load linux  kernel.
> 
> uart0 is also the Linux console.

Are you sure? Maybe my board has UART0 disconnected.

Best regards,
Krzysztof

