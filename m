Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854DC7EE23
	for <linux-serial@archiver.kernel.org>; Thu,  4 May 2023 06:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEDG2s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 May 2023 02:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjEDG2r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 02:28:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E51273A
        for <linux-serial@vger.kernel.org>; Wed,  3 May 2023 23:28:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9659c5b14d8so9323766b.3
        for <linux-serial@vger.kernel.org>; Wed, 03 May 2023 23:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181724; x=1685773724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmTTjP0NJY0zqU47RWDKkGkqZAij3qjk/tcoGnwkO5M=;
        b=GvQJlbBwlwe6+ms+pQcgcseKFLAtK/6mdsje36GT9UKVynJsoHfN3ITQueuFOVXrrD
         ++9JwkdMF1IXC5g/vBw+zbJinWfTLHJX5oEMPXdLVbYAPetEaagrB/py1dM5excjv6Bv
         1/xBf/j/G3ouUvM3iyetEz8IIwXhGKlrlFir2eBEUH3LHT18q/JRY3P1d65jgs+Pyphw
         LNbcfCuqigmiw34BwVV0A2oQjs7cx8WZBUN1uJvecr5KMYe9b2Ih1DQlqhxJg29hPXoi
         Sip1CK8BT/EDNFiq0ITidxqDjLlosoWDRmigHD4WmK6wjDwASGV4f9nstpR6fujMoSC3
         ifaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181724; x=1685773724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmTTjP0NJY0zqU47RWDKkGkqZAij3qjk/tcoGnwkO5M=;
        b=HABz6R7TngwYYmIUyn0Pi8h+rn6fmo0cwJqOyHwwl3NKwVSS83w9sPU/zDKaS0gZgF
         GJ4HGbT5u0QLFL2Tkg4vHHtAliRMlegAeh8VuM2yzblVUxhJvuwN8h+LsfRNRN+qmhVY
         RjFOqQB1TxnGFvK/yRsT8uor5rGoW2lDnKnhPvoSBWwAo3JrQCQn6/FFKRP5Sgan6M8T
         ddwqN66pbunnTT3CyiTNgOzoClqQHngIZVMBkbDcra5K5aoOY+/Z7jCElo+rGi6sTPso
         DxQIH7wWHowGuOeKCrnQO6XDMSaiNTv0ku2lcQ1JIMw2380ODJHVrSXvQ33UnSq/VE9y
         GiSw==
X-Gm-Message-State: AC+VfDz0t4fLYX1Nvq2vaeuu7dD6qAOFOi9+C49nKNvZFidIRS3sstSQ
        8etZPB69q16eWHWmTYbnjrp73A==
X-Google-Smtp-Source: ACHHUZ5UlPQzU17AFn5aODrdSBZVkzUlth32uioRCZuWjk3VO59yjYZG+dgM+KrPJbJrbQnO0okIbA==
X-Received: by 2002:a17:907:7f24:b0:947:ebd5:c798 with SMTP id qf36-20020a1709077f2400b00947ebd5c798mr6213675ejc.54.1683181724327;
        Wed, 03 May 2023 23:28:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id qf22-20020a1709077f1600b0094a8aa6338dsm18535563ejc.14.2023.05.03.23.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:28:43 -0700 (PDT)
Message-ID: <b5b439a4-78c7-0909-f7ca-b3a570fd08d2@linaro.org>
Date:   Thu, 4 May 2023 08:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v9 05/10] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>,
        Rob Herring <robh@kernel.org>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-6-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504033726.93-6-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/05/2023 05:37, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Modify Nuvoton NPCM and MA35 platform board bindings
>   - Move 'nuvoton,npcm-gcr.yaml' from 'bindings/arm/npcm' to
>     'bindings/soc/nuvoton'.
>   - Rename the 'bindings/arm/npcm' directory to 'bindings/arm/nuvoton'.
>   - Add bindings for ARMv8-based Nuvoton SoCs and platform boards, and
>     include the initial bindings for ma35d1 series development boards.
> 
> Modify MAINTAINERS
>   - Remove the line for 'bindings/arm/npcm/' under ARM/NUVOTON NPCM, as it
>     has been renamed.
>   - Add ARM/NUVOTON MA35 for Nuvoton MA35 series SoCs maintainer and files.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

