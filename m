Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3275DC4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 16:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjKMQWd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 11:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjKMQWd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 11:22:33 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399183
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 08:22:29 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c6efcef4eeso60921661fa.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699892548; x=1700497348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0aeWdvTGg3gRkOKHxxpI3RLuoeQrhOn+PTtI4/itWo=;
        b=Ii7rhx3a+uVF+bxY7uMwZ2QLM+0ATPcprpD+dWo1lgPBSVxgV6rw47yDWPPvUR/pAX
         IxXSPqdefBpB1N9fPD1vXkPU//TQeJbnwuay5SBVmuKf6NZUSxrbQAl/1jdm0W0wHA4Q
         lQL/MpLzItp7TTAIP50fsFaBU2pI4wxE6s6ASK4GmOe0vPxziigcmdAeoLRff8XRx3RC
         1dL1y2FTQU4IrB0gdlWvBMza9RYi17EbnNe5edYUenq8finNdR637OD/5peEyafX1zO9
         23vmlWZpB09dFBOHDhFPk+yebb5unRc+5iutoyXSoEqpHoWe5/0532GBKpGm2jVue6lC
         sU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699892548; x=1700497348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0aeWdvTGg3gRkOKHxxpI3RLuoeQrhOn+PTtI4/itWo=;
        b=nhrRPVmVSYng8wy79vQ/o656mM2hJkIBUmKkScbhKOJ3bvQTqFSaEU482PV2jqpSAQ
         ANGeu6die1PN42yPhwZP7ZXwpirLakQr+MGoNamndMpdLC91Spku9Z0u//aZ4agXP/Y7
         Au9q3QzQXkkVHq5XaQyNDqT3WgLTNFLK0Pba6Wid+Je9ZuCV98rDDDhXtlKMyfya4WtR
         7rqtLbbW8mCMX/WxoReu88EnBTz+ZhZMAIXDgGafvwuli5lQvRjHVa+tStxne+l/5scB
         JF4l6EG79IFghi2J1Rf0VNwvXMhB33rLTSwtGL9H6p9RXfBoQVg2pdmKBz6K5x0qhSQo
         nXCw==
X-Gm-Message-State: AOJu0Yx565V9Pa/UxfL32VkGNWLJ++r39ONKtDvNXPV/Z7Ebf3o2dmo7
        s+XJuhhtmaQtuADPRLBapAw=
X-Google-Smtp-Source: AGHT+IH+0PZ/ftN4nNIh77fhSLCi7RwtV4dlRzm0q+GEtqqKfv3aE3L0a2796eOSpj6p2rJv64FzpQ==
X-Received: by 2002:a2e:808d:0:b0:2c8:32e4:c080 with SMTP id i13-20020a2e808d000000b002c832e4c080mr4789170ljg.12.1699892547859;
        Mon, 13 Nov 2023 08:22:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b0032d9337e7d1sm5757840wri.11.2023.11.13.08.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 08:22:27 -0800 (PST)
Message-ID: <a098b0e0-fd8f-4fc8-a246-43a740aa8539@gmail.com>
Date:   Mon, 13 Nov 2023 17:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/52] serial: atmel: Convert to platform remove callback
 returning void
Content-Language: fr-FR
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-9-u.kleine-koenig@pengutronix.de>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20231110152927.70601-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Le 10/11/2023 à 16:29, Uwe Kleine-König a écrit :
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
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 1946fafc3f3e..6792680690bd 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -3001,7 +3001,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>    * protocol that needs bitbanging on IO lines, but use the regular serial
>    * port in the normal case.
>    */
> -static int atmel_serial_remove(struct platform_device *pdev)
> +static void atmel_serial_remove(struct platform_device *pdev)
>   {
>   	struct uart_port *port = platform_get_drvdata(pdev);
>   	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> @@ -3020,8 +3020,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
>   	clear_bit(port->line, atmel_ports_in_use);
>   
>   	pdev->dev.of_node = NULL;
> -
> -	return 0;
>   }
>   
>   static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
> @@ -3029,7 +3027,7 @@ static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
>   
>   static struct platform_driver atmel_serial_driver = {
>   	.probe		= atmel_serial_probe,
> -	.remove		= atmel_serial_remove,
> +	.remove_new	= atmel_serial_remove,
>   	.driver		= {
>   		.name			= "atmel_usart_serial",
>   		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),

Thanks !
