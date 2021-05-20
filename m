Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72AC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 05:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24A56124C
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 05:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhETF0J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 01:26:09 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46890 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETF0J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 01:26:09 -0400
Received: by mail-wr1-f41.google.com with SMTP id y14so14117627wrm.13;
        Wed, 19 May 2021 22:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11ZQ56HwZc4BV5BR48kEPzW4yk428PdNM1asWtUZ9+U=;
        b=NF+OhPjNPFEUBBstq3BSXs48wAPwCGxDXy11Tsg5KvAf/BX2U18UfH2wlzQA5DqvJ4
         LOuIWTkLLfBYp9CIgSVQ86xZ9ctDX2C7+y+h7NqyOfSebEFrs2h2y8Pl1S8u/7YNI70w
         +q+pl2j5nGQ7GIA3mh0PDI2MOd5eY+wuj9YcCX9lcY4n4OUaXoOPSrEer7JBh/DwQjMF
         szooQdKWqOIgD+dRLDqJood2THzgUU0oY2XMCL3w92rWMdCLbIw1hoZ3rfgW/JwGPM0i
         /MJnp0j1b6FmX4j8lo8UXsnEJCauku9jKB+ABjfnfU3QXeTmLz+5uvgdNli92gbtFt1R
         4P2w==
X-Gm-Message-State: AOAM5312Ijj2LUc4X4dzOTrn1I+kNH/yaUPQ3Sjqnkf+cJdkS7sf3Msa
        /uJgVvuEWhQvcKbn/DSdVP0=
X-Google-Smtp-Source: ABdhPJxL1ddfj/EY9f/Lv0AnafurtOPdOSn4JIWylC+vH9knX7psIsJVIOw0mB1hSIWDPo5AA2wfEA==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr2240537wrw.131.1621488287419;
        Wed, 19 May 2021 22:24:47 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r5sm1605843wmh.23.2021.05.19.22.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 22:24:46 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] serial: 8250: Add UART_BUG_TXRACE workaround for
 Aspeed VUART
To:     Andrew Jeffery <andrew@aj.id.au>, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com, ChiaWei Wang <chiawei_wang@aspeedtech.com>
References: <20210520021334.497341-1-andrew@aj.id.au>
 <20210520021334.497341-2-andrew@aj.id.au>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b8eed269-f30d-af69-dbc2-c9fa70009091@kernel.org>
Date:   Thu, 20 May 2021 07:24:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520021334.497341-2-andrew@aj.id.au>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20. 05. 21, 4:13, Andrew Jeffery wrote:
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

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/8250/8250.h              |  1 +
>   drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
>   drivers/tty/serial/8250/8250_port.c         | 12 ++++++++++++
>   3 files changed, 14 insertions(+)
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
> index d45dab1ab316..fc5ab2032282 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1809,6 +1809,18 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>   	count = up->tx_loadsz;
>   	do {
>   		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> +		if (up->bugs & UART_BUG_TXRACE) {
> +			/*
> +			 * The Aspeed BMC virtual UARTs have a bug where data
> +			 * may get stuck in the BMC's Tx FIFO from bursts of
> +			 * writes on the APB interface.
> +			 *
> +			 * Delay back-to-back writes by a read cycle to avoid
> +			 * stalling the VUART. Read a register that won't have
> +			 * side-effects and discard the result.
> +			 */
> +			serial_in(up, UART_SCR);
> +		}
>   		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>   		port->icount.tx++;
>   		if (uart_circ_empty(xmit))
> 


-- 
js
suse labs
