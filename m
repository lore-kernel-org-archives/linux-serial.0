Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF01AC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 22 Feb 2022 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiBVIVF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Feb 2022 03:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiBVIVA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Feb 2022 03:21:00 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC75155C35
        for <linux-serial@vger.kernel.org>; Tue, 22 Feb 2022 00:20:35 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id u18so35000716edt.6
        for <linux-serial@vger.kernel.org>; Tue, 22 Feb 2022 00:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PIDoa+uGqmUz7JmMbzipjKS1/2An6+SpzdmvnYjyhEA=;
        b=yAUDBwwm9XWLwrGH0QzegAfUOocrhl5OOg185wEds3ENEwpdSLQ4SY06geCvX6yEKW
         FHUrZr+pWoYnAfpl2bQBZ0zPaG/4wmb07VvnjNQtGBUrleLzgy9nmUbkUgXB20/X6+kY
         r2hXKM8ij4IeXzyjrzDmbMhs2A9v0HXz8GhSN3Cx+omGTNFqt4Ts7RzzxyPtTNmNE1N3
         jkBLaBOuO7Mk+36CYXO4z3AmG4yvDM4sszsnqgce8DIiRH1b/rNs/9X5sog88sJBLLjJ
         ffW9U1eQK19fYAkdV2enGsN0DZo5ic8PCaifBGCafJShEeQlGBt60ZP/xZySm0B8qNZY
         OO9Q==
X-Gm-Message-State: AOAM530MVOWMhJ3D055jNkHu23FL2GqXPl4/oE/TlN8vjB2eZN+LgYHR
        9CbPRIZPfAYf1frlHO3Nr+0=
X-Google-Smtp-Source: ABdhPJz46PTPRf4vrXw7RjiLNI81qN7eOX8sDQV5dIHQtQt25OfRmGW/1oSDvnin2wBkanFDiHE4sA==
X-Received: by 2002:a50:aad8:0:b0:404:c300:628c with SMTP id r24-20020a50aad8000000b00404c300628cmr25227768edc.175.1645518034184;
        Tue, 22 Feb 2022 00:20:34 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v12sm9822449edr.8.2022.02.22.00.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:20:33 -0800 (PST)
Message-ID: <8f3e1779-5581-fb40-aa64-34e700fb0e62@kernel.org>
Date:   Tue, 22 Feb 2022 09:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] serial: 8250: Return early in .start_tx() if there are no
 chars to send
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
References: <20220217211839.443039-1-u.kleine-koenig@pengutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220217211839.443039-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 17. 02. 22, 22:18, Uwe Kleine-König wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Don't start the whole chain for TX if there is no data to send. This is
> mostly relevant for rs485 mode as there might be rts-before-send and
> rts-after-send delays involved.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> a few other drivers have such an early exit already (imx, stm32-usart).
> I wonder if it applies to all UART drivers that there is nothing to do
> in .start_tx() if the circ buffer is empty and there is no x_char to
> send. In this case it would be more sensible to ensure in serial_core
> that .start_tx() is only ever called if there is something to do.

Not sure if all, but most yes. I have a series to add a TX helper which 
unifies those and removes all those cut&pasted code. It's not finished 
yet. Look at the top of:

https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/log/?h=devel

> Best regards
> Uwe
> 
>   drivers/tty/serial/8250/8250_port.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3b12bfc1ed67..5d4668f12f71 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1657,6 +1657,9 @@ static void serial8250_start_tx(struct uart_port *port)
>   
>   	serial8250_rpm_get_tx(up);
>   
> +	if (!port->x_char && uart_circ_empty(&port->state->xmit))
> +		return;
> +
>   	if (em485 &&
>   	    em485->active_timer == &em485->start_tx_timer)
>   		return;
> 
> base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07


-- 
js
suse labs
