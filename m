Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D700DC77B61
	for <linux-serial@archiver.kernel.org>; Thu, 13 Apr 2023 17:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDMRBo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Apr 2023 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDMRBm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Apr 2023 13:01:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E067AF0C
        for <linux-serial@vger.kernel.org>; Thu, 13 Apr 2023 10:01:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94a342ef3beso295028266b.0
        for <linux-serial@vger.kernel.org>; Thu, 13 Apr 2023 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681405290; x=1683997290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdBERnTqK1roUhz4M48CjDijMxlhU9ynjjBVOpaKKeM=;
        b=n+W2XGdtFMFTvQ5mKqxeIFE4wzQN0FAF+XlWI5pBX8A5jYFCiUOJEwYTZt3thO6+iv
         zLt2GAAG2U29q6n9cfv35M+tNURW5y29EJxudLgrEHF/+ZA4f/KJaYEXJjvIjg68ez1s
         D/Z6XH3QOTzG8QSsDRyYf+trkRW9pqrBgvGhipN6COdur483FqXveBe5DZVRXMgjiVjO
         rIDINjEDPf74tpIIx78AJhSll+PNSomdpOlj3iFlYcY48ob2u2lhEYUk3K9ez9ozUEJv
         fwgdCFI4vRhLqvpiGAs6IXTa/pUcOediBQEWNjYmvW8/D9vhPd+d1Jeb2muh3s0L3y9a
         Y2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405290; x=1683997290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdBERnTqK1roUhz4M48CjDijMxlhU9ynjjBVOpaKKeM=;
        b=XYTwfIlBWPqJA3d4w9r4awoEgVw3kNQ9fA1c9OjMIsjZUjDbxzDRID6oxxpeFMDTcg
         ia6IRUbYSUNw2wlTmdq9EGURqCS8G71IDj2gxt03wYoEZbFsRkJ7NTmVsXb/a22F5ejZ
         4t/eKPi/7VCHdju6+D5GwvVgeSx4MnhGWdgzOAUYmjKbeX/NWb015CXmCDj3oXZtpgvw
         0wXutmixN3msMO7vjraDB5+gLAVA+0Xol/g1aY68oW2ztpS3JwOOa0BQDAkUPaV1IPpx
         SJKLp8BBYmcVVSkdqvZPJwAZ0BeW+a1DjzCkig9H35GG5roGBmjlf8Nj1QkvRjd///lA
         m9Bw==
X-Gm-Message-State: AAQBX9cwH2WL/qvRO1RAvMOLLHlFSR98S5bYhicMMc4gYlCOBkVEPNTO
        LTDHvIJthAhXFqs7puVeJm92zQ==
X-Google-Smtp-Source: AKy350Ypvjtjph348wtuafD2AQwoYMfapNWNmvnPjLWTwvuRwjrgz0Ggd2TxQNw3M8d90qz68zxNLw==
X-Received: by 2002:a05:6402:156:b0:506:6002:da69 with SMTP id s22-20020a056402015600b005066002da69mr3573577edu.15.1681405290494;
        Thu, 13 Apr 2023 10:01:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7c242000000b00504937654f8sm1063485edo.21.2023.04.13.10.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 10:01:29 -0700 (PDT)
Message-ID: <241f6cb1-193f-d372-0eda-157946b15780@linaro.org>
Date:   Thu, 13 Apr 2023 19:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 12/12] MAINTAINERS: Add entry for NUVOTON MA35
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-13-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412053824.106-13-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/04/2023 07:38, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add entry for Nuvoton ma35d1 maintainer and files.
> In addition, update board binding paths of NUVOTON NPCM.


>  ARM/NUVOTON NPCM ARCHITECTURE
>  M:	Avi Fishman <avifishman70@gmail.com>
>  M:	Tomer Maimon <tmaimon77@gmail.com>
> @@ -2512,7 +2522,8 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/*/*/*npcm*
>  F:	Documentation/devicetree/bindings/*/*npcm*
> -F:	Documentation/devicetree/bindings/arm/npcm/*

It is not a bisectable change.

Best regards,
Krzysztof

