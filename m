Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C5C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 09:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiEWJCo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 05:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiEWJCm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 05:02:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544852250F
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 02:02:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r3so9523622ljd.7
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ljrd9sPBtTP1ZdWylTJaxJQwiOMaV0RsKrtAyaEmj6o=;
        b=Ufac/zzCH/P/QeskduOb3+8+mNnnrWiXQj/J0i5e/iKzzWXFcA/6bBNOr+FR1fVI4Z
         BCGaF65u3k7jqeSLd8BLX6uz0+HDNsh1yLh+AvjYj5rA42s6nb2uKrp6dKLMNaCLX/Xb
         N9A+ZX2U07Ftw5p1Vx0LT3suxVk9PVmPb3yM6taB53ffx0C8IH1GJgnyF67/Bq2I2n1f
         q+bMDPOvC5fkycgdlsg6KMRIfddk5qIRcVRo2PhzyxRuR6TaUAYE7QDPIbAOGzg/DNfh
         Ve+w7OMnushQgIM8vrvhjR+kNumnBMNIJ2jFamt0dU/8RTRTgg3zv/8brgAuTu/aSxSC
         +e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ljrd9sPBtTP1ZdWylTJaxJQwiOMaV0RsKrtAyaEmj6o=;
        b=8RBlPJtfI1/7O1PEp5aEHCK9RQ21o5Av1hrHfVS0TGnsTNdmg2JJ8Qlsx90vj3biDl
         03jWiDz8lXQ+FmybkOXArur4bAUutcy62p95E9d1U3qRvdjv/kD8SR+aOl4yE7GcAjGt
         BkrQx3Ry/49RkOPK0fjhmcwDQNT7v3m0zDT/Gk6FVJE/aBmBXF8pa9wQ2lJwqcMkGfzF
         Gr96e3KbmvzlX6C4jdvd/GbaTx1fkhIy500Q/3mT00ypmpF93MN8XPDb9e/zYPK3mzZZ
         U/4sqzLyo4FhFwGz3+pk6H8homv7RZx0wb403TfpvsajIeJievTCnJ3m6gdcFfh5eEyh
         069w==
X-Gm-Message-State: AOAM530yxg8PN3vtS1O9+1btSAkosVJsz+ujjgfaLnurF3QK86n7tk+K
        h+6YuZFWY/OpYE9d4emQ2iDpfA==
X-Google-Smtp-Source: ABdhPJypNw8ZqJ8C7Db1xwPEHrcAFbfCarFFD/xaG/JNVZP1XnFEmL+ADmOIzXWaBvyW+bXEriRUnA==
X-Received: by 2002:a2e:a26d:0:b0:253:d7b4:1d9a with SMTP id k13-20020a2ea26d000000b00253d7b41d9amr11109878ljm.203.1653296551485;
        Mon, 23 May 2022 02:02:31 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c6-20020ac24146000000b00477b0cfc990sm1864559lfi.30.2022.05.23.02.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:02:31 -0700 (PDT)
Message-ID: <3338df85-485d-25ac-e912-411e600ed851@linaro.org>
Date:   Mon, 23 May 2022 11:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 15/19] dt-bindings: arm: npcm: Add nuvoton,npcm845 GCR
 compatible string
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-16-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-16-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845
> global control registers (GCR).
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
