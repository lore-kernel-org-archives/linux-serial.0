Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60047C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 29 Nov 2021 08:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbhK2I5g (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Nov 2021 03:57:36 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58974
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234024AbhK2Izg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Nov 2021 03:55:36 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 377473FFD9
        for <linux-serial@vger.kernel.org>; Mon, 29 Nov 2021 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638175938;
        bh=ZaQqIAswixisNNNyeorlU9GuNTvH73CAxJlPnsQZHy0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eOHIGZEpTCg0NSvSRW7nmriiuk+qGiy9uYU1oxF3DF10Yz0E7aUFtTgoio9NPtf+j
         UepiBkaUVakrrTGWJzXQydRQK2EJ0l+0Q147LVLsYzV/0A3FgLIH2PJleLg6GeJidM
         UaDypFkun+5TXFGOud9T58hLDGKOm6ZOQCjXU9eTpaHLDk7bfN3RRgf6EVpJEqIGpM
         JFJ2Tz5fx/uGiNshZlMDDmFx95tTMOxB9w2l4cOksoUK1CdZEJXyN8HRf+BTm/8206
         2AwK1WC4GLklM0EgA86+5tfYxm6/HZPb8c0p7vlRoV3yEN+ylKZBMw0PU4alXgUfi5
         zGmK4EKeaU85A==
Received: by mail-lf1-f72.google.com with SMTP id k32-20020a0565123da000b0041643c6a467so5494880lfv.5
        for <linux-serial@vger.kernel.org>; Mon, 29 Nov 2021 00:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZaQqIAswixisNNNyeorlU9GuNTvH73CAxJlPnsQZHy0=;
        b=qD1BwCEgZ7Fsb64IQ0At6JvC2gfjzUrtSTnvkfQoUtGuIQWOz2swkFjzcZkhAinG3v
         KDPAPFpqdHqRoPpEcblYqDScJwsgbRHYXnIqO7V3cqFl943btWUr0FCWq/N49PA7rzxi
         AZwWz8Ur441q2MMYYPfAevUu/PWEcf6SLXdel5/0w8QfRWD5Un1vhDDzIpaz6Nx5uDAe
         EqPg++OpClY0TxjyboL0F+qvCT0h663ZC5NJPV74PIcUJZnm1uqlls+vJIjNBPUW/9qv
         NpAacQvSYEm3g7mYIRs7eOiEklzBDY5hVX9NvFJGPjrkc9oHcMWhdHDg6P+qASqrZ03P
         eLUg==
X-Gm-Message-State: AOAM531wIvEuluqgfKq7ZzU0OYSEfq2lbTgb1iEliJRFmwGOL+7t0upd
        ct9Y6p6nTStjlR1SbgiQPu2owXfjyig8HMf97sJIPHOw5Y/UdZDFNYQ3dvEBJ6rLTJI56oOr6iM
        Iw1Ysl2vAcWDspVNrpyym6ImXIQuQE9iqCLid5+YAVg==
X-Received: by 2002:a05:6512:c2a:: with SMTP id z42mr31006688lfu.6.1638175937507;
        Mon, 29 Nov 2021 00:52:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/fuSuHKtzu1BW0V3IJ+h3XO7FKT3jCEpMHk4HBOW0Zip1MVu6hQqnhBUElcTBsdm/mdGqXg==
X-Received: by 2002:a05:6512:c2a:: with SMTP id z42mr31006663lfu.6.1638175937318;
        Mon, 29 Nov 2021 00:52:17 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v10sm1263910ljp.125.2021.11.29.00.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 00:52:16 -0800 (PST)
Message-ID: <9a51b37b-d2c4-fb73-bd3f-447c94a66c82@canonical.com>
Date:   Mon, 29 Nov 2021 09:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 5/8] tty: serial: samsung: Enable console as module
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
 <20211127223253.19098-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211127223253.19098-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 27/11/2021 23:32, Sam Protsenko wrote:
> Enable serial driver to be built as a module. To do so, init the console
> support on driver/module load instead of using console_initcall().
> 
> This is needed for proper support of USIv2 driver (which can be built as
> a module, which in turn makes SERIAL_SAMSUNG be a module too). It also
> might be useful for Android GKI modularization efforts.
> 
> Inspired by commit 87a0b9f98ac5 ("tty: serial: meson: enable console as
> module").
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/tty/serial/Kconfig       |  2 +-
>  drivers/tty/serial/samsung_tty.c | 21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index fc543ac97c13..0e5ccb25bdb1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -263,7 +263,7 @@ config SERIAL_SAMSUNG_UARTS
>  
>  config SERIAL_SAMSUNG_CONSOLE
>  	bool "Support for console on Samsung SoC serial port"
> -	depends on SERIAL_SAMSUNG=y
> +	depends on SERIAL_SAMSUNG
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  	help
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index f986a9253dc8..92a63e9392ed 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1720,10 +1720,10 @@ static int __init s3c24xx_serial_console_init(void)
>  	register_console(&s3c24xx_serial_console);
>  	return 0;
>  }
> -console_initcall(s3c24xx_serial_console_init);
>  
>  #define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
>  #else
> +static inline int s3c24xx_serial_console_init(void) { return 0; }
>  #define S3C24XX_SERIAL_CONSOLE NULL
>  #endif
>  
> @@ -2898,7 +2898,24 @@ static struct platform_driver samsung_serial_driver = {
>  	},
>  };
>  
> -module_platform_driver(samsung_serial_driver);
> +static int __init samsung_serial_init(void)
> +{
> +	int ret;
> +
> +	ret = s3c24xx_serial_console_init();
> +	if (ret)
> +		return ret;

This will trigger warns on module re-loading, won't it? Either suppress
unbind or cleanup in module exit.

> +
> +	return platform_driver_register(&samsung_serial_driver);
> +}
> +
> +static void __exit samsung_serial_exit(void)
> +{
> +	platform_driver_unregister(&samsung_serial_driver);
> +}
> +
> +module_init(samsung_serial_init);
> +module_exit(samsung_serial_exit);
>  
>  #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
>  /*
> 


Best regards,
Krzysztof
