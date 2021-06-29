Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFCBC11F66
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037BD61DC6
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 09:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhF2JrU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Jun 2021 05:47:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33158 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhF2JrU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Jun 2021 05:47:20 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyAIW-0005fu-7b
        for linux-serial@vger.kernel.org; Tue, 29 Jun 2021 09:44:52 +0000
Received: by mail-ej1-f70.google.com with SMTP id u4-20020a1709061244b02904648b302151so5496490eja.17
        for <linux-serial@vger.kernel.org>; Tue, 29 Jun 2021 02:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6S93IgLQX/j9P4a+cNZB4S+kLehvqpx4P2yVdaV6XE=;
        b=XQLNIBeb3i0lca9E/DGv5/DA41N1Ouer9qw51Y2oAr9lIEO8fS7meVB5noYYXnFs7B
         bCvoNKuNwhS4fDul/pSqQVgs+i7f3hoeooWOeTlLLpm5Ec6b0iUHCO3V7p4svLw5ht1k
         eBZP2HtSJAUBKBSkiripWoFZQWj9DvxCAUKTTTpDDYXLuqmomGYkxqP0FSXacQuyQEa9
         wT44sdtdSqvrdyKr8gwXPP63Dz6AaiOdEiay7j0uDjT/QPUOF2d+Hu9tfOAz6DAJdR3g
         2iI7pNa90jHt9Ut8Dtm12dWG4HVIVknJC1dMG4RURsEPgc8VWCl4JxDopI+AN1fwG9rO
         4NdA==
X-Gm-Message-State: AOAM5314fMdDyhAo552vPs5iXROGXi3lGrwOKvWDidH14Sn7/6vm18W5
        aGd50A3gfkqQQi3XnZBpsAhmT48hndIwlTjyh58nUrqfFkcNgTYXI0BQfLmuCnT6dcACA0XbFDT
        TBhG/DXsTzuTbLrv3kp/Fcc/b0s/2CVbnTZpKsk3VcQ==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr38800575ede.39.1624959892025;
        Tue, 29 Jun 2021 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy06olXLZfAm05U4GcZNHdgwCRhnlpCZ8sU2e7+C3VS7EOVINUFGdMcuDwYXMbgFp8XUZyLKw==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr38800560ede.39.1624959891916;
        Tue, 29 Jun 2021 02:44:51 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id z28sm7763057ejl.69.2021.06.29.02.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 02:44:51 -0700 (PDT)
Subject: Re: [PATCH v5] serial: samsung: use dma_ops of DMA if attached
To:     Tamseel Shams <m.shams@samsung.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, robin.murphy@arm.com
References: <CGME20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd@epcas5p4.samsung.com>
 <20210629045902.48912-1-m.shams@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8569ce54-26ef-e36a-b3a9-2d31e2575bd2@canonical.com>
Date:   Tue, 29 Jun 2021 11:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629045902.48912-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29/06/2021 06:59, Tamseel Shams wrote:
> When DMA is used for TX and RX by serial driver, it should
> pass the DMA device pointer to DMA API instead of UART device
> pointer. DMA device should be used for DMA API because only
> the DMA device is aware of how the device connects to the memory.
> There might be an extra level of address translation due to a
> SMMU attached to the DMA device. When serial device is used for
> DMA API, the DMA API will have no clue of the SMMU attached to
> the DMA device.
> 
> This patch is necessary to fix the SMMU page faults
> which is observed when a DMA(with SMMU enabled) is attached
> to UART for transfer.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
> Changes since v1:
> 1. Rebased the patch on "tty-next" branch of TTY driver tree
> 
> Changes since v2:
> 1. Updated the commit message.
> 2. Changed the comment description
> 
> Changes since v3:
> 1. Removed the null pointer check for "dma", "dma->tx_chan" and
> "dma->rx_chan" and instead sending DMA device pointer while calling
> DMA API.
> 
> Changes since v4:
> 1. Fixed the alignments of arguments.
> 
>  drivers/tty/serial/samsung_tty.c | 46 +++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
