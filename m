Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0353C43334
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 10:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiFHKUV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiFHKTE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 06:19:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB8195910
        for <linux-serial@vger.kernel.org>; Wed,  8 Jun 2022 03:06:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fu3so38940593ejc.7
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3J02Cy+NQfGm8eV9KXhCD+MqMYdiX+58OLIgnc/8epc=;
        b=IMJozpnrngI0y4iXwqWP72b84kfB4aNdhVQEbM8V/kkVCEolj6yjfMGAfBxkFB1cNQ
         xQNoHORJyBpbstcHefYhvnN2pvdrhUXXseBwJ0ONtoIi02CV9fa7yedi6l54sewGvk8j
         TN3TIX5Hejet+8VZroyCyUobF3JFKxK/iEApe/3CSgLAB3Po09mYcdpCLf+ZvjEPKGyl
         DqZfgw00JleReC4QKzzWGH7wFevd7z305S6FE1TaMTmmjwN4JvBFRfbr34UI8HZiCXGy
         Fev4FGzYiRF/p4JYukVG3FNQqICash3M96PZ5mqEj+LVVPQuga/aSPhYcHdYYAd+C895
         BrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3J02Cy+NQfGm8eV9KXhCD+MqMYdiX+58OLIgnc/8epc=;
        b=RGwzJJarhVMWnM/z4VxEVWH6D7lhbgbJMA4ndr0WmG/U3ms1pLfXIHsn9kQLOfMmMK
         WnVQ4jEt5LNTHLGRZDYtyAF3ewc6PxyOKQxH5QyPCmg+QSjUJZt3vOnEIhzop9njHVUq
         NwFFe4rJD9kZHthYxXJb3FQ8xE6NGGMyYan/1jSGy0AUneSsuePApsppQOqASwAevjCG
         o9kb4xP83ofoC9J3DgvS9+1v33OKbpAuXH1JdocDcreblktS/478wFX4hkeJ+h8nSBOC
         tG2LlRyODpU4+fg/7G3t7ZTNy0sUlLZlUPLH6f4jTssOyjUfhKnfQeu8ELz9kMAip4tH
         6XKQ==
X-Gm-Message-State: AOAM532WNC8ZlGU8Dt785Q6hFkcEFtIe4mT4qhgAsluHb8Y/op7fv8tC
        5K9KXYdr/Pfctdx+OU1fj2aAxw==
X-Google-Smtp-Source: ABdhPJxsAIrFE3btqqb5RrORPvxSxuVZHyAl3KpL5wCgHxpsvLqD8dGERxMUjIqaeaFK4tHV94VjMw==
X-Received: by 2002:a17:906:4785:b0:6fe:f8ac:2494 with SMTP id cw5-20020a170906478500b006fef8ac2494mr30359804ejc.199.1654682779982;
        Wed, 08 Jun 2022 03:06:19 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709066ac100b006feed212f50sm8856606ejs.184.2022.06.08.03.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:06:19 -0700 (PDT)
Message-ID: <bf4284de-6c20-a378-99f6-439e6abcbbd5@linaro.org>
Date:   Wed, 8 Jun 2022 12:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 09/20] dt-bindings: reset: npcm: add GCR syscon
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
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-10-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608095623.22327-10-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08/06/2022 11:56, Tomer Maimon wrote:
> Describe syscon property that handles general
> control registers(GCR) in Nuvoton BMC NPCM
> reset driver.

I already asked about this.

Could you please implement the comments you receive? It's not just one,
it's several of them have to be repeated.

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/reset/nuvoton,npcm-reset.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> index 0998f481578d..c6bbc1589ab9 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> @@ -19,6 +19,10 @@ properties:
>    '#reset-cells':
>      const: 2
>  
> +  nuvoton,sysgcr:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

Skip quotes.

> +    description: a phandle to access GCR registers.
> +
>    nuvoton,sw-reset-number:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 1
> @@ -31,6 +35,7 @@ required:
>    - compatible
>    - reg
>    - '#reset-cells'
> +  - nuvoton,sysgcr

Aren't you breaking existing DTBs?

>  
>  additionalProperties: false
>  
> @@ -41,6 +46,7 @@ examples:
>          compatible = "nuvoton,npcm750-reset";
>          reg = <0xf0801000 0x70>;
>          #reset-cells = <2>;
> +        nuvoton,sysgcr = <&gcr>;
>          nuvoton,sw-reset-number = <2>;
>      };
>  


Best regards,
Krzysztof
