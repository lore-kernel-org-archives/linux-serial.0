Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678DC32772
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 13:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbiHWNDO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiHWNCy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 09:02:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548E71709
        for <linux-serial@vger.kernel.org>; Tue, 23 Aug 2022 03:05:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by6so13011782ljb.11
        for <linux-serial@vger.kernel.org>; Tue, 23 Aug 2022 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fqiKf0BLmyvWe2DRPuWRUrG4aK91/YgL5gBtIo6rx9g=;
        b=LoiI+fUpOhA1S1wXC+DDHIPlSPyLAwqz9ZCZKx2TTD7x7kVulTbdCgOkMUVWfVvM2I
         ij+gK+GnOjgRyoor6WAHRrPWyU0d8vjG2tYUJnz/XEwbbIuKM4aqMVd7C2T14rWs8eZU
         hYck/orrrsSYJnfsQ/1zmCJA5TR02/7rTiDOqTBpJ9ox/+m4GoZNK633SSvyxdOnvMLd
         17wJ4c6SjixrnIv46TnYWMgSO16i76TbI39YwbRoRSqiKaafDwYbPMzfJrWANyl9e8oG
         R7gwI8vRFjHCHhpb51DgPHX2pcPt5uJcA/PAY3ONG5gbc3lL0kkYNLjwY0gWQeMp5WPO
         neVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fqiKf0BLmyvWe2DRPuWRUrG4aK91/YgL5gBtIo6rx9g=;
        b=ElwFfrYbfDw1kQX0jsi8lzjaWopapgGyrPthuGZZQNC3eX1C6Qeqi/FPWuKC3Vas+H
         V1vUVhcXdCsMjMiTudIBZwlmJ0RbINuv9HGd60nEV3JNVKfA7NrEP1kgbKODpvwWZEbB
         1FOIVRN1R7qL96q0PnDWJvekRu8IhzKOMc8YN8nxcjLML/SE091GnumLMKIE58RsgnSJ
         vBeKe7Hni7Evsw5xwOqd9dsUEP6cG3Znbmask7nhuBiFEWTpEZuHvpggJ+GCl17l/CKd
         148pEWig88vr/6Ijk8i3eVM3ZX1dzPZZD0qHpNovbCRYGrAm8dumKx9iECN00mWfHL1y
         RbNw==
X-Gm-Message-State: ACgBeo2Szbzx5vfwVPFKUoBuC1vvLLsO+5S86TUeB0RcsNi9H/rD/AQF
        xQYcQAhiB5k7K0qg/onbti6j9g==
X-Google-Smtp-Source: AA6agR6HCVRRmiWdV5cSWBXh35gNbti1adFT+KGUdu3NvYpgxzuTmZLIS5eCk/RjQIlf2WsRqMTzCg==
X-Received: by 2002:a2e:8415:0:b0:261:d673:4d6 with SMTP id z21-20020a2e8415000000b00261d67304d6mr562302ljg.223.1661249129314;
        Tue, 23 Aug 2022 03:05:29 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id m17-20020a056512359100b00492cd4bd383sm1944255lfr.223.2022.08.23.03.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:05:28 -0700 (PDT)
Message-ID: <17899835-b7fc-fa34-fec4-2462c7829f3d@linaro.org>
Date:   Tue, 23 Aug 2022 13:05:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: pl011: Add a reg-io-width
 parameter
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-serial@vger.kernel.org
Cc:     git@amd.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com
References: <20220822130333.5353-1-shubhrajyoti.datta@amd.com>
 <20220822130333.5353-2-shubhrajyoti.datta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822130333.5353-2-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/08/2022 16:03, Shubhrajyoti Datta wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Some of the implementations support only 32-bit accesses.
> Add a parameter reg-io-width for such platforms.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v3:
> patch addition
> 
>  Documentation/devicetree/bindings/serial/pl011.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
> index d8aed84abcd3..c8a4cbb178fe 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> @@ -94,6 +94,13 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  reg-io-width:
> +    description: |

No need for |

> +      The size (in bytes) of the IO accesses that should be performed
> +      on the device.
> +    $ref: /schemas/types.yaml#/definitions/uint32

This is a standard type, so no need for $ref

Best regards,
Krzysztof
