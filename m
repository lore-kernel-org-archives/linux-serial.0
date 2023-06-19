Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EBEB64D9
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jun 2023 11:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjFSLD0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jun 2023 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjFSLC5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jun 2023 07:02:57 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053F1BC1;
        Mon, 19 Jun 2023 04:01:53 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b466066950so30229921fa.2;
        Mon, 19 Jun 2023 04:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687172512; x=1689764512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5ub7CNbo9A5jA0TlUemxCQlR/gijVVIGHXtI5ZYrlk=;
        b=W0HztdJCCxW8+D4NSORvHOrGKgPat5fy4+38ZxujNc8z9noQy1yDdpEmPXse+o9Jip
         q///4RbVg+qrF7JsynDzxZa/P4lPzAB8JMfCCGiVLZ38AYV2TpQR1FEu3lCMO8cEqko+
         vqTCmWm4Dqzn0g2n6lM1LI0oKkbcwLSIvacu4xq6KWV/B6H2yMPDTAQI3UrKi8EZZ+fQ
         Z+rEpyM9YyYyDJ6e+QBrpz/1s8xDs99YayLlhgtWsx28Qne77ihlA7NUNO6IEj0zgD1j
         1x0sqsWkDeWRbJrMhN877hoFWPJEiCiaWuLDrH/EXeP+n+UUeS1KjZat27Cz3LYrFzAu
         rEEQ==
X-Gm-Message-State: AC+VfDwbkjpImiBKgaYq/7xkUYxXX582gyLCtGQQOMlGkTOzWIr9qtDk
        93vzfjkBDBmCQUua+dKdC20=
X-Google-Smtp-Source: ACHHUZ5fV1xxnrpgJhc20iKQcKzbgGqeO0Vt6hQnWYNhq/Oc2LkvQjCfCO/zFKhvzadDgMqPRpHoRw==
X-Received: by 2002:a2e:8008:0:b0:2aa:41a1:cd70 with SMTP id j8-20020a2e8008000000b002aa41a1cd70mr5797686ljg.3.1687172511461;
        Mon, 19 Jun 2023 04:01:51 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b0095807ab4b57sm14751512ejb.178.2023.06.19.04.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 04:01:50 -0700 (PDT)
Message-ID: <d87d9f00-8d85-6220-43d3-51ef8e793193@kernel.org>
Date:   Mon, 19 Jun 2023 13:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] serial: atmel: don't enable IRQs prematurely
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Elen Song <elen.song@atmel.com>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cb7c39a9-c004-4673-92e1-be4e34b85368@moroto.mountain>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <cb7c39a9-c004-4673-92e1-be4e34b85368@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19. 06. 23, 11:45, Dan Carpenter wrote:
> The atmel_complete_tx_dma() function disables IRQs at the start
> of the function by calling spin_lock_irqsave(&port->lock, flags);
> There is no need to disable them a second time using the
> spin_lock_irq() function and, in fact, doing so is a bug because
> it will enable IRQs prematurely when we call spin_unlock_irq().
> 
> Just use spin_lock/unlock() instead without disabling or enabling
> IRQs.
> 
> Fixes: 08f738be88bb ("serial: at91: add tx dma support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/tty/serial/atmel_serial.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 6e9192f122aa..3467a875641a 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -868,11 +868,11 @@ static void atmel_complete_tx_dma(void *arg)
>   		dmaengine_terminate_all(chan);
>   	uart_xmit_advance(port, atmel_port->tx_len);
>   
> -	spin_lock_irq(&atmel_port->lock_tx);
> +	spin_lock(&atmel_port->lock_tx);
>   	async_tx_ack(atmel_port->desc_tx);
>   	atmel_port->cookie_tx = -EINVAL;
>   	atmel_port->desc_tx = NULL;
> -	spin_unlock_irq(&atmel_port->lock_tx);
> +	spin_unlock(&atmel_port->lock_tx);

Hmm, can you ensure the DMA engine code calls this with irqs disabled? 
If so, you should document it in the commit log. If not, you shyuld use 
_irqsave() variant.

thanks,
-- 
js
suse labs

