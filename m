Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C413C43460
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 05:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60161611BD
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 05:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETF0i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 01:26:38 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52079 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETF0i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 01:26:38 -0400
Received: by mail-wm1-f54.google.com with SMTP id u133so8380715wmg.1;
        Wed, 19 May 2021 22:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uBDTnysTP/v0yudg9DFa2zD2k+gjVi/C3z5x9N8ueoY=;
        b=Yg2OoAUHOzP27GCMCTk6m7gj2f75oRAvmKRQmHReeUn7Vlu9fnoc+qlzOtaTxr1Gq2
         NJNLUqYVaf/3XTcMQfHD5pS0AC9KZs7giPnmYpOL35eIAcy36CXh+O7fxD1GLtylRPg0
         aoudLlP0oxJ7KpNFjX+ZvxTbYz6i8irqma9gEsIww7Ic4IpYYm1qGuj8v9mQIHpS096X
         SM9MnCAs+OhWyiDHkm58XRVBhngNGZ5KOBgcOHzEE37WuB5ajk/+Q6gyoAB1A2o3q1WY
         q4Z9uA4EFA9YDFoWNAXcGHtInmL8kPn3Cu9NJebX/Vu8aCx7D6LABQVmjDO/t/NUlqh1
         QRmg==
X-Gm-Message-State: AOAM533yXfAirCyf9fRIg9RNz+0HG3I9WFDfrzSNfu5Cgu9GsvlHBV9n
        E7ro17xBznfFRiV+4Y+VEb0=
X-Google-Smtp-Source: ABdhPJxJk7MpMpRXJ5tCRNdyCu5OIB3BCLm8IYcRkJ2azAx7L7aZj2oqaTWfUcipbqlMNiLpWPNfpg==
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr1793957wme.181.1621488315285;
        Wed, 19 May 2021 22:25:15 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id a11sm1663829wrx.38.2021.05.19.22.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 22:25:14 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*
To:     Andrew Jeffery <andrew@aj.id.au>, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com
References: <20210520021334.497341-1-andrew@aj.id.au>
 <20210520021334.497341-3-andrew@aj.id.au>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <20eec190-d80e-b32a-8949-e5e2918a110b@kernel.org>
Date:   Thu, 20 May 2021 07:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520021334.497341-3-andrew@aj.id.au>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20. 05. 21, 4:13, Andrew Jeffery wrote:
> BIT(x) improves readability and safety with respect to shifts.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/8250/8250.h | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 34aa2714f3c9..6473361525d1 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -7,6 +7,7 @@
>    *  Copyright (C) 2001 Russell King.
>    */
>   
> +#include <linux/bits.h>
>   #include <linux/serial_8250.h>
>   #include <linux/serial_reg.h>
>   #include <linux/dmaengine.h>
> @@ -70,25 +71,25 @@ struct serial8250_config {
>   	unsigned int	flags;
>   };
>   
> -#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
> -#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
> -#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
> -#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
> -#define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
> -#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
> -#define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
> -#define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
> -#define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
> -#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
> +#define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
> +#define UART_CAP_EFR	BIT(9)	/* UART has EFR */
> +#define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
> +#define UART_CAP_AFE	BIT(11)	/* MCR-based hw flow control */
> +#define UART_CAP_UUE	BIT(12)	/* UART needs IER bit 6 set (Xscale) */
> +#define UART_CAP_RTOIE	BIT(13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
> +#define UART_CAP_HFIFO	BIT(14)	/* UART has a "hidden" FIFO */
> +#define UART_CAP_RPM	BIT(15)	/* Runtime PM is active while idle */
> +#define UART_CAP_IRDA	BIT(16)	/* UART supports IrDA line discipline */
> +#define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
>   					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>   					 */
>   
> -#define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
> -#define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
> -#define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
> -#define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
> -#define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
> -#define UART_BUG_TXRACE	(1 << 5)	/* UART Tx fails to set remote DR */
> +#define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
> +#define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
> +#define UART_BUG_NOMSR	BIT(2)	/* UART has buggy MSR status bits (Au1x00) */
> +#define UART_BUG_THRE	BIT(3)	/* UART has buggy THRE reassertion */
> +#define UART_BUG_PARITY	BIT(4)	/* UART mishandles parity if FIFO enabled */
> +#define UART_BUG_TXRACE	BIT(5)	/* UART Tx fails to set remote DR */
>   
>   
>   #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
> 


-- 
js
suse labs
