Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC2C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 07:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiEWHdQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiEWHcl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 03:32:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAD8B3E
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 00:32:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p4so22630716lfg.4
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=17JqV26wVHdgo28ZqibLwQLBrW+2wdRYXH2zbWrVfCo=;
        b=Ib9IYf1AvLT27iihXTu9RkqmCryClPTfougnJ4FyWIlLyfyQLNoahME9lk60jT7YXm
         jD+7fF0WQXgTnEJ244khLVZ2ruXBE8MS1uUVUlTeK2ut3gzKojOjbTDWEHyZ98VTUslE
         NjdYJQZNiVrEOIgva4BhEJiS4Ewom+kaGwXmokXK9WVHBOaGDsVce74hQ1PaoCqMtfm7
         tmQCCcjUUAYxDvOTYI9RRd+9Bf0ud4XjKoAI+6sp0abtcwlOGdCJsf7ESg6hkRNhtrw8
         nO0lprI8/GsPSj3vbIte8Vsmr0wnD5DbJ9z2/t0tu+2zMycYVUyl8WY7wWrEoa1qh7HP
         gHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=17JqV26wVHdgo28ZqibLwQLBrW+2wdRYXH2zbWrVfCo=;
        b=sLAVV/yMYnJ+khvs6Uilmj8oBNH80aLzFmh9ZsHmiy9j+T1lh5b0E8WCrzRvzOhtEn
         qfQiUrY2YRCzjAHDVdB1ZgYjKct4qbKI853owlhZMqFNhsdaY2UbWTGJCwP+VX48UCoS
         3kC++hEN3eWJRtjzUDQgqLGA4SwukwnooMQH/n2r4EwjSONg4dM96RUHNz6+hUPNtu9J
         IBaEn0xUfvE1Bked2D1t3AAoJXHrkWjs7qNJ8FaO/JW0S4UXOv0pMw4TixZGdbmYKTkr
         rZBvCzHHijdl/cO7r45tIS5yxliDoPfMmTKtgMT68I3Ra79BnhAAihqmBqGvT4WoA+84
         OWJw==
X-Gm-Message-State: AOAM5310uUm88h9g5FhxGF4zt0HG6m2Fdo7OqLqbT9LiY4mr3/VWkge4
        bw7WYU5DSMkXpvb3OY55pJrELA==
X-Google-Smtp-Source: ABdhPJwr/sSdCGIN0en6yM1a+IjJKGEZWdESs2RUoX6hwQ9lIqGKLwQqPAREwe3x2yxzBpnbbnpjpg==
X-Received: by 2002:ac2:43a1:0:b0:478:5867:5047 with SMTP id t1-20020ac243a1000000b0047858675047mr9556576lfl.37.1653291135678;
        Mon, 23 May 2022 00:32:15 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r5-20020a19ac45000000b0047255d21167sm1828342lfc.150.2022.05.23.00.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 00:32:15 -0700 (PDT)
Message-ID: <d48f8b9b-92e2-2fc9-6d06-0b1496768d4e@linaro.org>
Date:   Mon, 23 May 2022 09:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 03/19] dt-bindings: serial: 8250: Add npcm845
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
 <20220522155046.260146-4-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-4-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 UART.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
