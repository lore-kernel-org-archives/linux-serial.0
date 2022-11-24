Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A51C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 24 Nov 2022 10:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKXKDg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Nov 2022 05:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKXKD0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Nov 2022 05:03:26 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91206725C2
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 02:03:21 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a15so1423045ljb.7
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 02:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCZjeyLs2ux0OroYeApX1fYWjIFyLaoIfyqvpBmoO+o=;
        b=W6kD+JLfb3F1Y5MaFIebiTpo5cKNdMC2Xjg20Ib3Bl/hqR/V4kLo5e2nQWPM8IV/g0
         lycgMERS1pAejxRXlPvywtOxzQGWWNKi8F4UkxI3N91Ha9LAIjHKIrtVvq/jDHHBrOja
         RcFRnD5yzkz6UtwXk1ioYWaOo9dHPhM+ACo55fU10L1vWvl78+FuJ/1usjG0lPTqYqqG
         /yc3RAN7//eb5jQsrpxD7Pnx83V59wP1MISJIe4Kr8rNjQBTWBt23yO5bcePFtmbKAKM
         JP65iFSMDaG3agXPOMb5WbGJqnCu/foz6bhWquUP1fkKgjjrvJW6V3v8v/vRuzP1HfqA
         0+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCZjeyLs2ux0OroYeApX1fYWjIFyLaoIfyqvpBmoO+o=;
        b=ShqhuI6oKV0qYeehTD0OaeJkYfRUjMUTdTokHNHr3uQmOsYWtCNw5ebJwgxZBsuvnx
         K1/YyB0t/LWMSV5iClAjHbJlgFGYForHzsjKCD33XJkcfH7nrtiemwEZqRWBQw09y/kd
         bnFfITs67DPl/2lZAHfS3tbZ7gIcO3RIbnJJuszAma2KTA4QN8fbXwQKdkyLRPKyKSJe
         kvYjJUschqVucZotnLdLJ+t1rkbr6O6rQtClnFI+7ba7yLF+QeJT5AQqAUwhvN1Mnn3x
         VUGuTBhKzEK+SqgxG6CPeU96L5lVK3ChA4+rz9+1BVkYgI0/ypdFDrfaPzHBOskzlom8
         FN0A==
X-Gm-Message-State: ANoB5pmAoKN1e1KtoE5dwzEONJAh7aRj+CkJeDMkHDNru9LskTZfB/v+
        qllsDAKjU41lO7MyjZOYEbaPGA==
X-Google-Smtp-Source: AA0mqf7AeLi748zvuvni/ei9zdoxEh1UCl0ALG/IVygL6V3LpK26R/NPIb6D0xoAv0WeuDPQyy7Hkg==
X-Received: by 2002:a2e:1f0a:0:b0:279:7825:f486 with SMTP id f10-20020a2e1f0a000000b002797825f486mr2267894ljf.93.1669284199726;
        Thu, 24 Nov 2022 02:03:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p20-20020a2eb7d4000000b0026c42f67eb8sm63270ljo.7.2022.11.24.02.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 02:03:19 -0800 (PST)
Message-ID: <93a88b73-a600-1cee-43d2-0e7b72ceba3e@linaro.org>
Date:   Thu, 24 Nov 2022 11:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V2 1/4] dt_bindings: rs485: Add binding for GPIO that
 controls Rx enable during Tx
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org, marex@denx.de,
        jirislaby@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Dahl <ada@thorsis.com>, kernel@dh-electronics.com,
        devicetree@vger.kernel.org
References: <20221123123004.7216-1-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123123004.7216-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23/11/2022 13:30, Christoph Niedermaier wrote:
> This patch adds a binding for a generic definition of an output GPIO that

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> indicates the state of rs485-rx-during-tx. The idea is that the hardware

1. Use subject prefixes matching the subsystem (git log --oneline -- ...).
(no underscores)

2. Subject: drop second, redundant "bindings".

So it could look like:
dt-bindings: serial: rs485: Add GPIO controlling RX enable during TX

For the ack of contents, I'll leave it to Rob as he was involved in v1
discussion.

Best regards,
Krzysztof

