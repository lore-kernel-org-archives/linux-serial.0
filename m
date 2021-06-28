Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF3C49EA7
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 08:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6530961C43
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 08:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhF1IrW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:47:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56711 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhF1IrV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Jun 2021 04:47:21 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lxmsv-0001hV-KX
        for linux-serial@vger.kernel.org; Mon, 28 Jun 2021 08:44:53 +0000
Received: by mail-ej1-f72.google.com with SMTP id ci22-20020a170906c356b0290492ca430d87so4059386ejb.14
        for <linux-serial@vger.kernel.org>; Mon, 28 Jun 2021 01:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KmtJfV8NItnsIFSWg4xXgNASx94tom0VLkFkXbFAOfI=;
        b=hriLNcH1sy5ZtF2nbGyQPk1zW7/di83QtKfI4pR4CawcX4z8Z+TFao2CT4EPrKtEqv
         bv0H2vft8id5ygZRWnBuJJIY9OqH/NfaKuFUt1ax/jrwkhI6s4ny7SNQXiqE1Eo8ESMy
         jRdFGBal6l/kycPKRSbVZrdv1DLb+XbiG9n164qoVMm3lBPcORX9huDxkwX4UdDRXv77
         hwlt9aAONjGh2cI7C+UISmDeNf27I+jnTQhXHHuQKuy8hG6xiN3C4MJjvaxS3zYMVslp
         lm49kHQzsfbAVCQ8VS8FB638DEudzRApHTy5n3sG3sj6za4l6jHuSfw/COHjduLdf1qM
         4bZA==
X-Gm-Message-State: AOAM532L9Y0wCI5DadyTpEb5EJEw1nFckSVW69nmffUzW9Z3Cy9U6GDb
        QHhwQcG1y4Qv4g0tFaUiPGg0rb92z5hmyVcpwsUWVgtIh4xE8edMCFYc9rV72lSAhNrkJhjXx0S
        5C4mMXKF8/Glkp9P/HJFypRW2fFY8qORPX8PfiXQbuw==
X-Received: by 2002:a05:6402:214:: with SMTP id t20mr32006494edv.20.1624869893174;
        Mon, 28 Jun 2021 01:44:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgeLioIsaaCeLGrQTkc0wZAz537qLD1J7tTEDktZUt/kPkCQJJfbSv7dTimZbtgaouriCEhA==
X-Received: by 2002:a05:6402:214:: with SMTP id t20mr32006482edv.20.1624869893042;
        Mon, 28 Jun 2021 01:44:53 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id h14sm3068530ejl.118.2021.06.28.01.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 01:44:52 -0700 (PDT)
Subject: Re: [PATCH v4] serial: samsung: use dma_ops of DMA if attached
To:     Tamseel Shams <m.shams@samsung.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, robin.murphy@arm.com
References: <CGME20210625074751epcas5p125067e47c4ff1ad24a1e595d85f82540@epcas5p1.samsung.com>
 <20210625075114.71155-1-m.shams@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <3aa88ee4-c662-8069-fb04-90df82038dbe@canonical.com>
Date:   Mon, 28 Jun 2021 10:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625075114.71155-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/06/2021 09:51, Tamseel Shams wrote:
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
>  drivers/tty/serial/samsung_tty.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..fa30aa20a13f 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -305,7 +305,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  		dmaengine_pause(dma->tx_chan);
>  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>  		dmaengine_terminate_all(dma->tx_chan);
> -		dma_sync_single_for_cpu(ourport->port.dev,
> +		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
>  			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
>  		async_tx_ack(dma->tx_desc);
>  		count = dma->tx_bytes_requested - state.residue;
> @@ -338,8 +338,8 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>  	count = dma->tx_bytes_requested - state.residue;
>  	async_tx_ack(dma->tx_desc);
>  
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> -				dma->tx_size, DMA_TO_DEVICE);
> +	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
> +			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);

Looks like alignment is broken here. However even if the line was not
aligned before, please fix it up now - align the arguments like
checkpatch suggests.

This applies to other places as well. Thanks.

Best regards,
Krzysztof
