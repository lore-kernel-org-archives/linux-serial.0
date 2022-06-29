Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EADEC43334
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 07:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiF2Ha2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiF2Ha1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jun 2022 03:30:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00C81DA6B
        for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2022 00:30:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so30668078ejc.11
        for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2022 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8f9f/DdxcxCzzZ6MEC/yMm66gVi082k8/rCqNHVJetw=;
        b=ZFc70PtUa5ydr2IDLP8qWrRARDxIZ0xHbWPrHDXA1A78Sv6PcZQkFq1Pl5ksYGhQpA
         H0HS/TBnWToTgqJqBMrW3fCS3/OTkQxgjAxjYmGcwvm9GAd0ef5cYra07oBBsNi/GELG
         FN5Kybp4/WNKH0RDImP2VFGhSGdKkysI0Jsu+w1TKjNaKZ1l/GP+KknlLiws/b8KmDfX
         ZQ4YbUuoyLZZRgWXE+UCHPvFreFYjUJVP76+BG0XFSWunsQHbN5vWJ6+pZwRc0Dmyuz/
         cD5BaSv1KEmrF2geHwDf7en8qHnpcrvBRwU3Lh7yVNMb5dla3vr2f/GkuLudd0TZK5F0
         RDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8f9f/DdxcxCzzZ6MEC/yMm66gVi082k8/rCqNHVJetw=;
        b=76iua6r7fI6Q67V9zYW3uqfnuU66L4RomtT0Zb6DiYsH5uOEaiZoiakHkORjat/25Y
         RdVgCRD9toKRMYPfHx5dgltCdmckGjFNeG/Uzcdeov9KUg1El+ysxuhioWWI8QstOByo
         8HslAdsZPKRgW+BeG0GNE9TeNdfe552oUAeveMxfbDzy7pGuXcvHPowWwCBdr9hQBupz
         bAdM16N0DPmCFQPnKiDPFZ3I5sY/Zn/EAjozYz+hPPqjAiIjuC0aeWaLcbx2rK4ElW1O
         +uFP5uVB8gnUktfF5oMKYxU99+uGNWFELc/Sj/JLEjOEg0eGfTNALFB14o8BQlNaweS2
         2g2A==
X-Gm-Message-State: AJIora/gWWUmLftp9gzM8gBuBZ5jutHMVCapUI74Baz+hZ5UodmOqPXN
        PtsvQa9bdGPWTEbloylru8vA6w==
X-Google-Smtp-Source: AGRyM1tYJfy35uELg9evZ2s21gatUi2PnZHF3AxAijFvL1oP2JbDyBofB1Va552x9uvLRUgMeJvcSQ==
X-Received: by 2002:a17:907:3f28:b0:726:3149:8a99 with SMTP id hq40-20020a1709073f2800b0072631498a99mr1932872ejc.277.1656487825516;
        Wed, 29 Jun 2022 00:30:25 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p17-20020a056402501100b0043787ad7cfasm6169340eda.22.2022.06.29.00.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 00:30:25 -0700 (PDT)
Message-ID: <f8186d95-a49c-d211-d0a6-bed9975b03b0@linaro.org>
Date:   Wed, 29 Jun 2022 09:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] tty: serial: samsung_tty: support more than 4 uart
 ports
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
References: <CGME20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17@epcas2p4.samsung.com>
 <20220629005538.60132-1-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629005538.60132-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29/06/2022 02:55, Chanho Park wrote:
> Regarding Exynos Auto v9 SoC, it supports uarts up to 12. However, the
> maximum number of the ports has been derived from
> CONFIG_SERIAL_SAMSUNG_UARTS and tightly coupled with the config for
> previous Samsung SoCs such as s3c24xx and s3c64xx. To overcome this
> limitation, this changes the usage of the definition to UART_NR which is
> widely used from other serial drivers. This also defines the value to 12
> only for ARM64 SoCs to not affect the change to previous arm32 SoCs.
> 
> Instead of enumerating all the ports as predefined arrays, this
> introduces s3c24xx_serial_init_port_default that is initializing the
> structure as the default value.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
