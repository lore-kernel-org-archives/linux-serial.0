Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B090CEDE983
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 05:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjINFzo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 01:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjINFzo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 01:55:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463EC1
        for <linux-serial@vger.kernel.org>; Wed, 13 Sep 2023 22:55:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40472f9db24so1034705e9.2
        for <linux-serial@vger.kernel.org>; Wed, 13 Sep 2023 22:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694670938; x=1695275738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVqz5fTFaZOPkRTloQdqhhX4Yfas1CeW5UW/reBPVug=;
        b=Ts1zjQnHej8q0dX+4eQ0t0eHxXNz+upMSVOHdTbRwUlC4DWVUWcOKWnNZJzcBRgjsP
         djmj57EkNaeVUpb2rkdLL8J6c1HvjWp1Xsja+XThINc5nSklD1JV6Vi7Ab6rQhUR3ARd
         f+p1vsvNnIBjd8H1sSBEuFkVkncVzzVB9ElWSkAWr0BC7dAVmLmMA0tXZlaZEJ52eHQe
         leDU+d+RwmcyPH4Fi9OZFk/CtMCU4oBYmRQ3zC2gi8tu1FY624IOP3mlitUAhbS+eQUE
         BiVA/gjmJMw0jWPk9/2+QyGcd1ulni1rL6NiEDvvoyuCTQ0YVPVeKqvnO9xwAe9t3zzu
         AomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670938; x=1695275738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVqz5fTFaZOPkRTloQdqhhX4Yfas1CeW5UW/reBPVug=;
        b=aa91QCNVz41UtGlMXN0jp40upHXcyXQAiOMyaPyKUWBNxUTGCUlM1kJ6OI3B2bz7tw
         OtafS2peNCtSmKnIjnWva0D3gPfm3N0JQxrkGTU2KHE/l77GgxMM3LkWXYTM+NhlaCDb
         +6hKfm8DPpzNmP4+8KpKs1bOMhwac86L1JekqslxEjyyWGhu7ZKuGzMOWjFvxXa/Ld10
         MDwkPhD9XTVXVoPHPZ4JLoqS5VspJrgFjyjBuPiGLHSbcMO9agNOkYMGogoQxm+h1Icj
         5dyKC6p2v+ST/+l5XRjxsRjHGfA0Lw2OQk7iW60mIsB2tHK8wv6t5s+aOmtl1JSvyYnd
         cB5w==
X-Gm-Message-State: AOJu0YyZyUqvzjsIVmddWL6eVs10qwkjNtNIIQOQlwnpl22IfVLsNGvg
        5fJqRKnUsRAXq06PPVSZ4+wrvg==
X-Google-Smtp-Source: AGHT+IG0W3wyhxluqtBNYusc57CPjlOiC3XamIm1oevXpauiZO52uIinBPwKk77BV+JH8o7fg2a7pg==
X-Received: by 2002:a5d:58e8:0:b0:319:666e:b466 with SMTP id f8-20020a5d58e8000000b00319666eb466mr3280085wrd.42.1694670938069;
        Wed, 13 Sep 2023 22:55:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003fef6881350sm962830wmr.25.2023.09.13.22.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:55:37 -0700 (PDT)
Message-ID: <d7bf0ae3-d263-4231-9656-2b7af4b372a3@linaro.org>
Date:   Thu, 14 Sep 2023 07:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] dt-bindings: serial: document esp32-uart bindings
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
 <20230913211449.668796-2-jcmvbkbc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913211449.668796-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/09/2023 23:14, Max Filippov wrote:
> Add documentation for the ESP32xx UART controllers.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  .../bindings/serial/esp,esp32-uart.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> new file mode 100644
> index 000000000000..8b45ef808107
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/esp,esp32-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESP32 UART controller
> +
> +maintainers:
> +  - Max Filippov <jcmvbkbc@gmail.com>
> +
> +description: |
> +  ESP32 UART controller is a part of ESP32 SoC series.

1. Company name?
2. ESP32 SoC series suggests esp32 is a series.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: UART controller for the ESP32 SoC
> +        const: esp,esp32-uart

Also, the vendor prefix looks incorrect, so again - what is the company
name?

Best regards,
Krzysztof

