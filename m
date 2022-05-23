Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC4C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 07:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiEWHjS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 03:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiEWHjQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 03:39:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFEF1A81E
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 00:39:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q1so6494357ljb.5
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2o0hO8VxGZyOj9xdhEYgL8kZWVgpy5fzSg0aJgogftY=;
        b=oTlafLq1Et1sqIk16m6DA+jCJFRlO1codjbSN1yIOqPNsC/hH97jn05NIguWsQsgDv
         MWeWoI2vv9UbV3FkkFH8LRfKOud/5OOHhGZzSyiaRoZ4yq9pf4d9XglXpLwtFhbwxx3h
         l/MntMA7PuEhdGnWm9xpPY0CELq4x2ndZJmpM6TyRaFCPZ/8baO/9gBuYiHVSGFPS1jm
         b3KtJKIKCIsC+aHkFf8PcAu100fKNg2B8/yOoC4Ot+GFOGJuZroHrRLSGC770sv8mRIp
         QTGJT7iEIsDef/Fmtvyt1PfVDHLqAtEk7gs9OuxZND4nvEsGXsjKCbb7lWb0Matyrg/4
         l6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2o0hO8VxGZyOj9xdhEYgL8kZWVgpy5fzSg0aJgogftY=;
        b=QmEPNNmXHm6SEyip/5CLpOHUwJgIKrGTXIceAdYxVgrjt0hK68gY5Y6xkpqUMysnxU
         tCN01ikNDXsPN0H8kSSGAUO93L9JD4E486tFFksnCg3PkE0sDVBtY/WlqAXFieETuwHU
         z/kTsE272c3JzmsMxwEDZcom4V9gnV/eBLVeWdnlSGOuYa0vGN5wCCGJTf0RxmSXZSju
         9hFlfumSANqWXFzBiEL/HoJGP6NSY4Qj0knV2L39TIcwAe8nVOAur59WrpBD/D+htlNI
         v7g8wMDIrabHKNZgjHfGRj4aj23+E2OSFlug7AHaIbJo3dTnVEEtoir4ko6eW+QLWpG5
         FcDQ==
X-Gm-Message-State: AOAM531BeoJW6XNeh/SLDM+UBoQbW9H+QGqsw4W1677GqiFZJh0dh7Vm
        vW8fHQLHMRmx/Fn/8tpvgYEUag==
X-Google-Smtp-Source: ABdhPJwtbBM2Rwibao4fT7vqqa0BZadmJT0isYqGRbFlzHrWoKbx1K2YaXeJwobANdpRy17mjiYuzA==
X-Received: by 2002:a2e:9e41:0:b0:253:c37c:378b with SMTP id g1-20020a2e9e41000000b00253c37c378bmr12383846ljk.202.1653291551361;
        Mon, 23 May 2022 00:39:11 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e8545000000b0024f3d1dae7csm1656531ljj.4.2022.05.23.00.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 00:39:10 -0700 (PDT)
Message-ID: <d02b042c-7f6e-8d2b-a5eb-c7ac4a0eea7d@linaro.org>
Date:   Mon, 23 May 2022 09:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 09/19] dt-bindings: reset: add syscon property
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
 <20220522155046.260146-10-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-10-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Describe syscon property that handles GCR registers
> in Nuvoton BMC NPCM reset driver.

Please wrap according to Linux standards:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> index 17b7a6a43a29..cb1613092ee7 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
>  - reg : specifies physical base address and size of the register.
>  - #reset-cells: must be set to 2
> +- syscon: a phandle to access GCR registers.

syscon is not a generic property, so vendor prefix and some descriptive
name of property.

>  
>  Optional property:
>  - nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
> @@ -16,6 +17,7 @@ Example:
>  		compatible = "nuvoton,npcm750-reset";
>  		reg = <0xf0801000 0x70>;
>  		#reset-cells = <2>;
> +		syscon = <&gcr>;
>  		nuvoton,sw-reset-number = <2>;
>  	};
>  


Best regards,
Krzysztof
