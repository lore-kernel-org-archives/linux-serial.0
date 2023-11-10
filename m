Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEADC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbjKJSvG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345503AbjKJSus (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:50:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDEB7709
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 10:09:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso370801766b.1
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 10:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1699639767; x=1700244567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcAYtz5VhzsShDEx0OiwP1CZfdmkXBrcYXEUstOPYz8=;
        b=LetHJPvpCwP/Br0LiZBi2HJwFExQjtMkjiN0xXfN+bYohbwAIFepBChiPG53eDS+Yb
         BALdYQ+yGpml3cgd7uFeTBTl53blq+X8xWc3zEuows/204Hbf1Y3qF6AyClwJie6JWxE
         LBVxsK+ogYUQvPbVhqgrqQayNme5OheUBDN4OYRW6ZjbcRyfZ0g5Wb1NHDCtL6d2Jshh
         QTErb+oiryqKl6ov3sJkR3v6vqcYLcbPJORt8UwIzOwohOYDg81uHQ8YZSQ6gtkQ+nqw
         IDlzfccMjYEkZTGuUOBZFf2ou2hwgrQLKDbApbBnw0+fI9tUCYnLStK2ajQ0Mw20WeIn
         Jdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639767; x=1700244567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcAYtz5VhzsShDEx0OiwP1CZfdmkXBrcYXEUstOPYz8=;
        b=i2MziEdeD20g+FAF/1Lk+xcjGBDI3r1zPAoU1JLucU7hoiJuY/86RUYFafEtsrPIW4
         f0ILqQrGk9T0XTUgTbFzThQXM08zcRQYf8yMqluEA69ifoep9z6dZKLTQpC3InD5xt2N
         eq8dC63Gxe8A9hYXYqgoO4AIgUxgUeDOkyovvLstsGFzh9JxSkqmhw0DGnN200ZGfxE7
         U+9ODk4gK10dTuOi/M6t425ZPyn/hRZvq0GoXW5JVIcJ/juxy0W7SrcF99unps+l07St
         KyaDtJZdIh3seAcBapvkwey7r+uFbyMgSK4Z0zI4kpk+pwh+/hTqDobLfp6D+FhfTS3S
         Qynw==
X-Gm-Message-State: AOJu0Yw+/+Nj2tYcDN5LVby2+LChTSOLVGX4zy4bfxMA4ZjnL7fip96T
        URzBSeUNopcIct8BCcupEY30uQ==
X-Google-Smtp-Source: AGHT+IFkbT2IYBBLIee0zwGEamHUQl/6PMtAAGKrQMMnEwAQ/v/3Buy0Sr3Y1nttLOuLOe16yY61LA==
X-Received: by 2002:a17:907:a47:b0:9c4:d19:4a64 with SMTP id be7-20020a1709070a4700b009c40d194a64mr7077337ejc.25.1699639767569;
        Fri, 10 Nov 2023 10:09:27 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id u20-20020a1709060b1400b009cb2fd85371sm4243772ejg.8.2023.11.10.10.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 10:09:27 -0800 (PST)
Message-ID: <6a5900ca-ef5b-40e5-9509-c0e7b654c02e@tuxon.dev>
Date:   Fri, 10 Nov 2023 20:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/52] serial: atmel: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-9-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231110152927.70601-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 10.11.2023 17:29, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/tty/serial/atmel_serial.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 1946fafc3f3e..6792680690bd 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -3001,7 +3001,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   * protocol that needs bitbanging on IO lines, but use the regular serial
>   * port in the normal case.
>   */
> -static int atmel_serial_remove(struct platform_device *pdev)
> +static void atmel_serial_remove(struct platform_device *pdev)
>  {
>  	struct uart_port *port = platform_get_drvdata(pdev);
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> @@ -3020,8 +3020,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
>  	clear_bit(port->line, atmel_ports_in_use);
>  
>  	pdev->dev.of_node = NULL;
> -
> -	return 0;
>  }
>  
>  static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
> @@ -3029,7 +3027,7 @@ static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
>  
>  static struct platform_driver atmel_serial_driver = {
>  	.probe		= atmel_serial_probe,
> -	.remove		= atmel_serial_remove,
> +	.remove_new	= atmel_serial_remove,
>  	.driver		= {
>  		.name			= "atmel_usart_serial",
>  		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
