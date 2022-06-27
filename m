Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7FFC43334
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 10:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiF0KeA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 06:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiF0Kd7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 06:33:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DA6417
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 03:33:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e28so7214226wra.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fu4PRWXrnet8l+Wzlc9u5ZP+FAA0ZHxV8ImVTD46fu4=;
        b=v4ZXKOx56aXRHkRYD+3x19r45JbK0YB5ZD6H6BW7wTKUW7Jmb0uEWElqEXZpNcm+Mc
         PqsE+9O2TIYI38NY1HFnw5toFCep++jR44ayUMC9rUEU6w/lingU/+iahFPk+/8CZgAx
         1FiefvUiwks8IlnPzSXvNk4706pFoTlwUAx3zDoAOjLhLLhBWQpq92dOmCWsLCMIijTa
         qn0nZ0PIHB0LznFuoZsTIDmiVQx+9/ivpBhy49cQL0K2moY63HVy0RPGNwu4fZwBBgOh
         fI77xGIINwf5yBMK1iA4RZknY0WzwDhWOGjH/0/RqUPANuNzPLSlYm2qiRdJKp0IPbJg
         2dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fu4PRWXrnet8l+Wzlc9u5ZP+FAA0ZHxV8ImVTD46fu4=;
        b=X4+L6n5onkdq5IEv5UPrzEXYiHqT1gtWspkRbpVSin/kRxvKBiF+HRzyljnOM27K8s
         opdfIDJOICp1tux4i1bOGUCfc8IZLiE/I/IoeWvd9bVJHGCyiyEfpbus5A/SJ+Amv9W6
         Cm4Iwd2EuYN9quK8XEaqx2xXue3z+/z+VEmaALhwf9Y1uiivIO+8RT4HHTZJTusmp9L2
         vYik1+5DUt1uS37nAeyGOSDv4UeFWRFAcpEQR57pIZgpdLFcDgtvhsmhXUEclpKnWgQh
         seatC2ryQXqa6G8famKrzFG2UHoV1frLwDRpHMogMKCvfOqKOZSZH1MtcInnRkHhMrNW
         W0ZA==
X-Gm-Message-State: AJIora+/CnmXokyVSppGNRvQuHwNUVKAPss7xMDn+88+6my17OerIRqC
        aiTsnMpkKdCwueYC8C1K6KQ39A==
X-Google-Smtp-Source: AGRyM1vrMf7GTnVelKxnSwRHWWbdVw3djaiQiOu0uxngmY4+SVTXF6d/YiYWRDu9588N45dwC8jkUw==
X-Received: by 2002:a5d:64cc:0:b0:21b:ba06:4d4d with SMTP id f12-20020a5d64cc000000b0021bba064d4dmr11794574wri.157.1656326032961;
        Mon, 27 Jun 2022 03:33:52 -0700 (PDT)
Received: from [192.168.0.248] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 4-20020a1c1904000000b0039c4506bd25sm15039945wmz.14.2022.06.27.03.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 03:33:52 -0700 (PDT)
Message-ID: <2efd725f-3d99-c1df-23ce-9ee60bbe4600@linaro.org>
Date:   Mon, 27 Jun 2022 12:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] tty: serial: samsung_tty: support more than 4 uart ports
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60@epcas2p4.samsung.com>
 <20220627071512.18180-1-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627071512.18180-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 27/06/2022 09:15, Chanho Park wrote:
> Regarding Exynos Auto v9 SoC, it supports uarts up to 12. However, the
> maximum number of the ports has been derived from
> CONFIG_SERIAL_SAMSUNG_UARTS and tightly coupled with the config for
> previous Samsung SoCs such as s3c24xx and s3c64xx. To overcome this
> limitation, this changes the usage of the definition to UART_NR which is
> widely used from other serial drivers. This also defines the value to 12
> only for ARM64 SoCs to not affect the change to previous arm32 SoCs.
> Instead of enumerating all the ports as predefined arrays, this
> introduces s3c24xx_serial_init_port_default that is initializing the
> structure as default value. 
> Regarding the ports which are greater than 4
> will be initialized as default value and the fifo size will be retrieved
> from the DT property.

You need to explain why you are doing this.

It's confusing to initialize some statically and some dynamically.

Best regards,
Krzysztof
