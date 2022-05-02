Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ADAC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  2 May 2022 20:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387400AbiEBU1D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 May 2022 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387402AbiEBU0t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 May 2022 16:26:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B60E0F7
        for <linux-serial@vger.kernel.org>; Mon,  2 May 2022 13:22:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so29836476ejd.3
        for <linux-serial@vger.kernel.org>; Mon, 02 May 2022 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8u8XXP2+TwizatTtq/0sBU/H2kbpvchvGg+Or95glsU=;
        b=c+u7IILtHnqh3gPerojkWNYCi37vsTGEfLtc4gbTUp68Qhm/m2Jbc85vGXEHjTeyGE
         eF45TX5oeQRnC/yF/jQKLLEOl0pD6br0SYzd/pDcX1ggVJEWEwxlsiYtZkx3mL0A9Afv
         nxQldhMXLdNIwGxAOodlzhM7I6dinj/npkrWemfHZqYpM75omr++Enhy5sz/mbDuj2e4
         ujuuna2uVCOiHVsT5TqAA9k1mwrPlqjDQDO2umL5HcvadDh3fUXSGvocKb1Mm+rurad0
         8lmbm5Vl4XPe3fJl30zFLXmYfXJmSZByYyoMlcw6Q7972rb3HkVax4gtzTPvaa1JwyEZ
         V3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8u8XXP2+TwizatTtq/0sBU/H2kbpvchvGg+Or95glsU=;
        b=j+WKGpflt0D+kpFxsXGrAZpH79e+z4VlCH6Gt/p0SYif6wD98e5iuOl5FqeNgJ8brQ
         I9w/X6KaDXd/oIWIxuPuK3RKWoZNV3O0awG/q07pOKWzdeSYrAzAcVWB1T/R/5UZoUs7
         gbNyJJQz87Gng7FbFfYZgI9UZyMyjqKP85ujDYxxOTmiuyiYQqXqnq/J+CadMdProzNT
         Tm/w20NianLU3f7qMEJz6bFjbPeyixwN1eO79tPpQn3urcmXeoysf1lbbIHCEgiL/w54
         MS04CMWDxiNXxxVTGsFV6kb2M6te/KA+Tt9IB3Bb/623wyBoOWnKQ9N3Ej+/3VLP+eAU
         lvfQ==
X-Gm-Message-State: AOAM530fKdJaFDnG0szOJ1KzJoAdhILWC8jftO/EnOjc9+2vQLmD6H6m
        pG0RpCKRDSfMLaoyGRoVx5sQlQ==
X-Google-Smtp-Source: ABdhPJzt13eXU45qtuo9lvfRz350biQpqqSKjro+GENo7tn3fUz/J8MoV2Z2s7NhXEZ/nmTp8xPJ3g==
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id g8-20020a1709065d0800b006dab4ea0937mr12972514ejt.446.1651522965974;
        Mon, 02 May 2022 13:22:45 -0700 (PDT)
Received: from [192.168.0.197] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yo1-20020a170907136100b006f3ef214e0dsm3916399ejb.115.2022.05.02.13.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:22:45 -0700 (PDT)
Message-ID: <d58c4881-8a23-bf7b-4845-b2fa50788997@linaro.org>
Date:   Mon, 2 May 2022 22:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: serial: samsung_tty: Fix suspend/resume on S5L
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502092505.30934-1-marcan@marcan.st>
 <Ym/EAGq3IzW5rYwr@kroah.com> <c5413c42-b728-b88b-4229-9d4e3943413e@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5413c42-b728-b88b-4229-9d4e3943413e@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02/05/2022 14:39, Hector Martin wrote:
> On 02/05/2022 20.44, Greg Kroah-Hartman wrote:
>> On Mon, May 02, 2022 at 06:25:05PM +0900, Hector Martin wrote:
>>> We were restoring the IRQ masks then clearing them again, because
>>> ucon_mask wasn't set properly. Adding that makes suspend/resume
>>> work as intended.
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> ---
>>>  drivers/tty/serial/samsung_tty.c | 1 +
>>>  include/linux/serial_s3c.h       | 3 +++
>>>  2 files changed, 4 insertions(+)
>>
>> Does this fix a specific older commit?
>>
>> And should it be backported to older stable kernels?
> 
> It does fix the commit that introduced this device support in general; I
> can add a Fixes line for that. I don't think anyone cares about
> backporting though, since there are other fairly critical devices that
> don't have support outright and there's still work to do before
> suspend/resume is generally usable on these machines.

Then please add only Fixes tag.

Best regards,
Krzysztof
