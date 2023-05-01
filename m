Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95AC7EE25
	for <linux-serial@archiver.kernel.org>; Mon,  1 May 2023 09:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjEAJu5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 May 2023 05:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjEAJu4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 May 2023 05:50:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD11BB
        for <linux-serial@vger.kernel.org>; Mon,  1 May 2023 02:50:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso149898a12.2
        for <linux-serial@vger.kernel.org>; Mon, 01 May 2023 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682934651; x=1685526651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3qMWocL6/wpbuDG6gR5Wtg+ZCiwCsubf8C3G4b5aRI=;
        b=pezXIELbzEAcCjV+boWauNmc5FQspzcpLCEDI67YIbKjgfsjTRBKe0Wf1wNUHmk3nN
         aJoPy4O0HwPQBG4M/iEiPUcZl8mqheFvGGEJs5FgO/ikYVqByWbj9QFqdO4bG7jG8UtR
         RRNyIunTTrHFKdrMpfP7Nsiz+Skn7pFEk6SV3A+sbnvkWriC7e8QOxRNl3HwA99ta9ff
         /zV8wOJnyflarJDy9mG1Jo3lM7CSov/LGAnQNieTzTzr0o24xCgQubpfFWADbpQl7T68
         KlPoPIeZjUtFfecyoHnbbms6ha2I7OBuMR/O2SrjLbbYt7/8DboATrH913BBTLXgtI/Y
         lCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682934651; x=1685526651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3qMWocL6/wpbuDG6gR5Wtg+ZCiwCsubf8C3G4b5aRI=;
        b=anxMibUXLjt0Ww+aJSmC+lpgIuJ9IF2sTXUx6wklPIUpCceOYeCHRNIvNdFq2e9pX5
         llIVB1GvVGP2olQfbWxITF8iSkXIyRXA0G0NHaWIrcT2AwZ9SNBXq1OPA/FY417dK2Sl
         +FJKY5gARdo36GxR/H3sZaA6KCzGjmADhpTZcJIZnLOYlaUXkhPVpprGsNfWEQqidCbd
         A8Cm8s/i6+6iSJO4jsHIZyRE83b26YGs0sMT7NNtD1XDTMtu4O99PYVcrSH8iuOrQqZr
         3z4qfyxDonJh7zrivK2G47H9w5MfGw65TA+O0z43M2dxYIm2xaxFw3DYXwgxnthwXLC+
         Cj+w==
X-Gm-Message-State: AC+VfDzg83OloWnXrTYkononwLdJxsPcCODgQ0VEHyq87X+ywABePW91
        1kdQwsxoenkfBsePxaqerr40MA==
X-Google-Smtp-Source: ACHHUZ5aoCRJwdM01aHJAYJ6FZM0GaX+jTFGr55aLgScxrfNq6frPl2fubj4mP8pK+VDgPengBFaAA==
X-Received: by 2002:aa7:cd10:0:b0:506:b228:7aff with SMTP id b16-20020aa7cd10000000b00506b2287affmr5635208edw.23.1682934651694;
        Mon, 01 May 2023 02:50:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7d054000000b004fc01b0aa55sm12145335edo.4.2023.05.01.02.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 02:50:51 -0700 (PDT)
Message-ID: <2b79021d-3793-5f2d-8659-5d0d8fc78017@linaro.org>
Date:   Mon, 1 May 2023 11:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v8 05/11] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-6-ychuang570808@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230425102418.185783-6-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/04/2023 12:24, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
> the initial bindings for ma35d1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>  .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>  .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml

I don't see any improvements here. Path in maintainers is still broken.

Best regards,
Krzysztof

