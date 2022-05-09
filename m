Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DC5C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  9 May 2022 10:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiEIK1b (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 May 2022 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiEIK1a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 May 2022 06:27:30 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68861DE570
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 03:22:17 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p189so8088579wmp.3
        for <linux-serial@vger.kernel.org>; Mon, 09 May 2022 03:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cjmP5f8o6qkhTLtlBX/qb4mHQGvjQadtuCgjH5PFef4=;
        b=Y+oxLww1vwJvUKiZw+o+HW8UnlcwZskrvSxIuXlMv1byFTtkg9PgiG66KXujNDD1Ys
         DxztrhvO4Z2MF3hNZj0EOT6AFQZk/OQ5KuzvGl5wzY6I/4SWo5F3/2X92tJJiltqmoE6
         HBGWznm2IP1PNzXOSEKGJW7rvkKCtPI6RRmAXphAqQ6nY7aQqI+ZLx0f5PyWXPg6J5q9
         3dj2FcoLvFIIg6lIysyxhKdg+Fa5Gd4LahXoM+6oXhwSTJDwiAnTx+rYxGyz7dqFoYcJ
         XgKO/hGUILCukzvgkstzmsowciRYPL764IChhkw0fUiLfJzYjOm/rH0sfysFXduVeV5Q
         x2Xg==
X-Gm-Message-State: AOAM53112bDArXQLcvmcq4VDvD2tGFq6VSG+7qGnex9jBiQj4qcm1Kac
        ljbrnPZxsQPiWKxlGLuUyvk=
X-Google-Smtp-Source: ABdhPJzOjx2UvFMLGfOd4Q5S1rlIh43G9ph88cFzu3lCc/I6qK3l4xqGOb8DtzYJD0yJhaoEB4HrAg==
X-Received: by 2002:a05:600c:35c6:b0:394:856d:fb07 with SMTP id r6-20020a05600c35c600b00394856dfb07mr9433341wmq.131.1652091720759;
        Mon, 09 May 2022 03:22:00 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i6-20020adffdc6000000b0020c5253d8f1sm10410577wrs.61.2022.05.09.03.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:22:00 -0700 (PDT)
Message-ID: <26f51ae5-6530-2376-55ac-0cfd3884f1ef@kernel.org>
Date:   Mon, 9 May 2022 12:21:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] fsl_lpuart: Don't enable interrupts too early
Content-Language: en-US
To:     Indan Zupancic <Indan.Zupancic@mep-info.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sherry.sun@nxp.com, linux-imx@nxp.com, linux-serial@vger.kernel.org
References: <20220505114750.45423-1-Indan.Zupancic@mep-info.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220505114750.45423-1-Indan.Zupancic@mep-info.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05. 05. 22, 13:47, Indan Zupancic wrote:
> If an irq is pending when devm_request_irq() is called, the irq
> handler will cause a NULL pointer access because initialisation
> is not done yet.

Sounds about right. But could you be a bit more specific? Like appending 
the BUG and its stack trace?

> Fixes: 9d7ee0e28da59 ("tty: serial: lpuart: avoid report NULL interrupt")
> Signed-off-by: Indan Zupancic <Indan.Zupancic@mep-info.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 75b3c36c13bc..7b46b97a6ddd 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2629,6 +2629,7 @@ static int lpuart_probe(struct platform_device *pdev)
>   	struct device_node *np = pdev->dev.of_node;
>   	struct lpuart_port *sport;
>   	struct resource *res;
> +	irq_handler_t handler;
>   	int ret;
>   
>   	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> @@ -2701,17 +2702,11 @@ static int lpuart_probe(struct platform_device *pdev)
>   
>   	if (lpuart_is_32(sport)) {
>   		lpuart_reg.cons = LPUART32_CONSOLE;
> -		ret = devm_request_irq(&pdev->dev, sport->port.irq, lpuart32_int, 0,
> -					DRIVER_NAME, sport);
> +		handler = lpuart32_int;
>   	} else {
>   		lpuart_reg.cons = LPUART_CONSOLE;
> -		ret = devm_request_irq(&pdev->dev, sport->port.irq, lpuart_int, 0,
> -					DRIVER_NAME, sport);
> +		handler = lpuart_int;
>   	}
> -
> -	if (ret)
> -		goto failed_irq_request;
> -
>   	ret = uart_add_one_port(&lpuart_reg, &sport->port);
>   	if (ret)
>   		goto failed_attach_port;
> @@ -2733,13 +2728,18 @@ static int lpuart_probe(struct platform_device *pdev)
>   
>   	sport->port.rs485_config(&sport->port, &sport->port.rs485);
>   
> +	ret = devm_request_irq(&pdev->dev, sport->port.irq, handler, 0,
> +				DRIVER_NAME, sport);
> +	if (ret)
> +		goto failed_irq_request;
> +
>   	return 0;
>   
> +failed_irq_request:
>   failed_get_rs485:
>   failed_reset:
>   	uart_remove_one_port(&lpuart_reg, &sport->port);
>   failed_attach_port:
> -failed_irq_request:
>   	lpuart_disable_clks(sport);
>   	return ret;
>   }


-- 
js
suse labs
