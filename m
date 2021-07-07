Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3600C07E95
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A0961C73
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 08:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGGIRb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:17:31 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:43852 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhGGIRa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jul 2021 04:17:30 -0400
Received: by mail-ej1-f41.google.com with SMTP id v20so1899887eji.10;
        Wed, 07 Jul 2021 01:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+2MNimaauPaNrsY3vPRiVIDMQ03C2JCgLIEB0YIu1KU=;
        b=Z669qlilwMK9Rn5xp5MzHE7MravKO0sZrAib5bjDN2Z3NvBIlQS/lJy8cg/U1jw42F
         YYTxxarZj0O7/XQCuF4WHEIlRX+2DZAuC6jvnRnNx+1c9w0iWn/jnG/P0FzDKGMyq/cv
         Ku6N4s8vsmzkabAi8Gde1RPAhR31QpX1Rw03n+7aImylHnAo+Af87tEq1I9wodEaP/uY
         UPx7U8AKENeMWYk+18/dDoOXqVdmbuybh1nIqd+vmg+uJ8CfruR57VfqXVaAjFhY67s/
         wkbp/NAjRFlAWNKuvtwlukT0ELu7yhhcpUsY+HT77bU1XCVxeI8ImfqFZ7u0nQIQVdYg
         X/Cg==
X-Gm-Message-State: AOAM530jONs68LdFMV37H1JoFYQlF/QyOU3ArlhNTwsIyjiB3XxIztAT
        MXKRi+geQLbdQr09RwEIiAA=
X-Google-Smtp-Source: ABdhPJxiqN7daDyQlYICmA9BxaNp0xaXshE2pXZxJvZ0UXtQ4eYa+3XShodrgWyGyoJ2UIAWleo8SQ==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr16808991ejc.274.1625645689863;
        Wed, 07 Jul 2021 01:14:49 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id f6sm6552343ejx.124.2021.07.07.01.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 01:14:49 -0700 (PDT)
Subject: Re: [PATCH v3] serial: samsung: Checks the return value of function
To:     Tamseel Shams <m.shams@samsung.com>,
        krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
References: <CGME20210706061710epcas5p2c11d1bf5afb14774c4d4db93f2b83b33@epcas5p2.samsung.com>
 <20210706061909.17555-1-m.shams@samsung.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9fedfbde-64e3-7ebf-576a-056819a0c1e0@kernel.org>
Date:   Wed, 7 Jul 2021 10:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706061909.17555-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06. 07. 21, 8:19, Tamseel Shams wrote:
> "uart_add_one_port" function call may fail and return
> some error code, so adding a check for return value.
> If it is returning some error code, then displaying the
> result, unregistering the driver and then returning from
> probe function with error code.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
> Changes since v1:
> 1. Added support to unregister driver on failure of "uart_add_one_port"
> function call.
> 2. Commit message updated.
> 
> Changes since v2:
> 1. Added support to unwind clocks on failure of "uart_add_one_port"
> function call.
> 
>   drivers/tty/serial/samsung_tty.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..a3f3a17fb54b 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2253,7 +2253,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   	}
>   
>   	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
> -	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> +	ret = uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add uart port, err %d\n", ret);
> +		goto add_port_error;
> +	}
>   	platform_set_drvdata(pdev, &ourport->port);
>   
>   	/*
> @@ -2272,6 +2276,17 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   	probe_index++;
>   
>   	return 0;
> +
> +add_port_error:
> +	ourport->port.mapbase = 0;
> +	clk_disable_unprepare(ourport->clk);
> +	clk_put(ourport->clk);
> +	if (!IS_ERR(ourport->baudclk)) {
> +		clk_disable_unprepare(ourport->baudclk);
> +		clk_put(ourport->baudclk);
> +	}


LGTM, now I only wonder why s3c24xx_serial_remove() does not put clocks?

> +	uart_unregister_driver(&s3c24xx_uart_drv);
> +	return ret;
>   }
>   
>   static int s3c24xx_serial_remove(struct platform_device *dev)
> 


-- 
js
suse labs
