Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E7C43334
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jun 2022 15:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353192AbiFUPl7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352995AbiFUPlx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jun 2022 11:41:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602A32CDF6
        for <linux-serial@vger.kernel.org>; Tue, 21 Jun 2022 08:41:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u15so691553ejc.10
        for <linux-serial@vger.kernel.org>; Tue, 21 Jun 2022 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RMRIR+HgYGPk4kqlGjQLW42tNRD3LRift0BoWoXmUl4=;
        b=PJhWavQQw1jz0WHXyX0ZMJ8eR94uUvT1OrTkOanzF8eCB9cRoiHlLFkzlXwgvLP1n3
         V+w0eQKQSencR01efMvM+CLx2hpLOKijSklYzMrRkzLvX77UTUutFGU6uJfiZB1pc98e
         VgYJdmbvnx1PUtVmTp+5NFI05o1TbHCDlbCQjnkikoTILqTKd6MV8Ho+yBGn8ZPN8hEJ
         sCMUvZdkn9wipxnotVkWIriVN5jdQ2mYy29rx649+igSQ202WUBmFIWDarvr2HGs4tJm
         xwmC6Jif32cg5AO1lfdsSE8Kh6DFfzyaj9s8iJixRwkpwtevMnkmSpC2/G3dP/aFLb1B
         NT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RMRIR+HgYGPk4kqlGjQLW42tNRD3LRift0BoWoXmUl4=;
        b=YlL+uv2C8cdYF+RlohwIfmx+C4abNkJ2RA5mDl+OwNDe/XHn45GTFWxYizxxsCCSPg
         Wqs7LxRrpwQGZW1qLBSheJJpWZFWFnebT4BSgEy5rleeky46PQ/aKIDJ1+K7vxPcYV7H
         bIMWHjld/q6vbO+2yzgLkmXbmHXJQ2liRd9jaQKMGaV6svC5cEf0j1HGeIwW4Mu1a+dI
         CTx9xVO/gjJ6bJb2BdjjG5HYcljVA3Im2ZVB23PaCWJn/qorsHINOB6Py2FW2JgS9rc1
         /Z2Wada6NV7p5yp87QJ0R/cCSW65TDFzPWUIrHTeb8iBak0hmUOA9kt/wOCjWqjzQI92
         Ce5Q==
X-Gm-Message-State: AJIora9G8vIHJJF3DVS3sVojulZEUwXILEghr6V+4udMmZhhofe0ve0h
        oUD5O1GpNMwZO/UQkB58oxAUXA==
X-Google-Smtp-Source: AGRyM1ukaYxWxV49I7X4K/AxawnLaQ11uVqfavd6zhGXdlYd80VACHz45P5IFtZP8yM2ASJC8c4z9Q==
X-Received: by 2002:a17:907:3f97:b0:711:d61d:df9 with SMTP id hr23-20020a1709073f9700b00711d61d0df9mr26593417ejc.644.1655826109691;
        Tue, 21 Jun 2022 08:41:49 -0700 (PDT)
Received: from [192.168.0.221] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402124200b004357738e04esm6977188edw.21.2022.06.21.08.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 08:41:49 -0700 (PDT)
Message-ID: <b1472a38-75e5-9711-3e25-7ca9a74109e2@linaro.org>
Date:   Tue, 21 Jun 2022 17:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 07/18] dt-bindings: reset: npcm: add GCR syscon
 property
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
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220621131424.162355-1-tmaimon77@gmail.com>
 <20220621131424.162355-8-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220621131424.162355-8-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21/06/2022 15:14, Tomer Maimon wrote:
> Describe syscon property that handles general control registers (GCR) in
> Nuvoton BMC NPCM reset driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/reset/nuvoton,npcm750-reset.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
