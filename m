Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA4C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912D261355
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhESGM6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 02:12:58 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36472 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhESGM5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 02:12:57 -0400
Received: by mail-wr1-f53.google.com with SMTP id c14so10840919wrx.3;
        Tue, 18 May 2021 23:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E0IobIzQGFKtYjnVLAhsERrEFaAtOpKnjVXmJUrJllo=;
        b=VM2jm+CNxIvZklaoBCMn+yOsr2ZCle9el9RmKz84HYfRs8Z5rAvv08LsICuqE5rCuo
         XWDf3VShmBrAiKKbcBdKhUM1JZJ+cwuUzGuWkTYVZizA2wZFqRN4P94yu48r5vCZcV9M
         1YpJPGCIMw17FrMNOlR96iUTcj07ITE2cGyULAUblJHloO1KgG8VndZVony1bAR80USZ
         FSvtdI9hV6puRngNb4p69Y/HVnRtkaRWI9mCHO9THNcTda0CQ6BqIvL9+A2hiHwNZSWY
         kgKrVMJwStzveESeGgKU5hJQNo/gxmmMlaswo6hunFb7zzzw5yQSH+46+EXfj03Idqe3
         Ne9g==
X-Gm-Message-State: AOAM533pDYIKmQNqP77b7WRIzHmc2qrSW1xihxQa6Il4GGIHUb+7G10H
        7nPVSPj0fp2IK0RAWuDtBZE=
X-Google-Smtp-Source: ABdhPJwIim9jf63DzBY3rwRC398B+hBCfBG7+Rs9X9JQQtLHoS1CD+Yq0iLOe0Ctgxg5qXG/UsNQ8A==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr12461094wrp.300.1621404660316;
        Tue, 18 May 2021 23:11:00 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id m10sm24644065wrr.2.2021.05.18.23.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 23:10:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] serial: 8250: Add UART_BUG_TXRACE workaround for
 Aspeed VUART
To:     Andrew Jeffery <andrew@aj.id.au>, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com, ChiaWei Wang <chiawei_wang@aspeedtech.com>
References: <20210519000704.3661773-1-andrew@aj.id.au>
 <20210519000704.3661773-2-andrew@aj.id.au>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8c14289a-9e81-f8de-b451-664a72ea5963@kernel.org>
Date:   Wed, 19 May 2021 08:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519000704.3661773-2-andrew@aj.id.au>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19. 05. 21, 2:07, Andrew Jeffery wrote:
> Aspeed Virtual UARTs directly bridge e.g. the system console UART on the
> LPC bus to the UART interface on the BMC's internal APB. As such there's
> no RS-232 signalling involved - the UART interfaces on each bus are
> directly connected as the producers and consumers of the one set of
> FIFOs.
> 
> The APB in the AST2600 generally runs at 100MHz while the LPC bus peaks
> at 33MHz. The difference in clock speeds exposes a race in the VUART
> design where a Tx data burst on the APB interface can result in a byte
> lost on the LPC interface. The symptom is LSR[DR] remains clear on the
> LPC interface despite data being present in its Rx FIFO, while LSR[THRE]
> remains clear on the APB interface as the host has not consumed the data
> the BMC has transmitted. In this state, the UART has stalled and no
> further data can be transmitted without manual intervention (e.g.
> resetting the FIFOs, resulting in loss of data).
> 
> The recommended work-around is to insert a read cycle on the APB
> interface between writes to THR.
> 
> Cc: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>   drivers/tty/serial/8250/8250.h              |  1 +
>   drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
>   drivers/tty/serial/8250/8250_port.c         | 10 ++++++++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 52bb21205bb6..34aa2714f3c9 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -88,6 +88,7 @@ struct serial8250_config {
>   #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
>   #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
>   #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
> +#define UART_BUG_TXRACE	(1 << 5)	/* UART Tx fails to set remote DR */
>   
>   
>   #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index a28a394ba32a..4caab8714e2c 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -440,6 +440,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>   	port.port.status = UPSTAT_SYNC_FIFO;
>   	port.port.dev = &pdev->dev;
>   	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> +	port.bugs |= UART_BUG_TXRACE;
>   
>   	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
>   	if (rc < 0)
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d45dab1ab316..9d44b2b2ff18 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1809,6 +1809,16 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>   	count = up->tx_loadsz;
>   	do {
>   		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> +		if (up->bugs & UART_BUG_TXRACE) {
> +			/* The Aspeed BMC virtual UARTs have a bug where data

This is not how a multiline comment should start. It should have been:
			/*
			 * The Aspeed BMC virtual...

> +			 * may get stuck in the BMC's Tx FIFO from bursts of
> +			 * writes on the APB interface.
> +			 *
> +			 * Delay back-to-back writes by a read cycle to avoid
> +			 * stalling the VUART.
> +			 */
> +			(void)serial_in(up, UART_SCR);

(void) is useless here. It's only syntactic sugar which wouldn't even 
filter out a warning about unused result (if serial_in was marked w/ 
__must_check/warn_unused_result attribute).

> +		}
>   		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>   		port->icount.tx++;
>   		if (uart_circ_empty(xmit))
> 

thanks,
-- 
js
suse labs
