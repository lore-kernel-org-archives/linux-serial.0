Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189ABC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF40E611CC
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 15:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbhEQPxE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 11:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244766AbhEQPvL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 11:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 759D861D47;
        Mon, 17 May 2021 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621262782;
        bh=y7lobXNEl29UJeAhMhyDmSKuFIoD0SytKc1vbhMDieg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aG62Q6vcuDN92+cqpoea4jwDFSODUNnskkMIjRJEsjP1+JdIveCOmCNHWP7zMOkiW
         qYM/w8RswSw4noCvt+e8DBwAHhHcf14sl+BUGDfiXfPF+mfyz3y/LbgdW863HW9r65
         6xBMmjmmtW9h1bL5QlnN0q/PQ/vuJsGoQ8fdI+Vo=
Date:   Mon, 17 May 2021 16:15:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com, ChiaWei Wang <chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH] tty: 8250: Add UART_BUG_TXRACE workaround for Aspeed
 VUART
Message-ID: <YKJ6aP/xqAe1hW6A@kroah.com>
References: <20210517124105.3565860-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517124105.3565860-1-andrew@aj.id.au>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 17, 2021 at 10:11:05PM +0930, Andrew Jeffery wrote:
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
>  drivers/tty/serial/8250/8250.h              | 1 +
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
>  drivers/tty/serial/8250/8250_port.c         | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 52bb21205bb6..4d6f5e0ecd4c 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -88,6 +88,7 @@ struct serial8250_config {
>  #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
>  #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
>  #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
> +#define UART_BUG_TXRACE (1 << 5)	/* UART Tx fails to set remote DR */

BUG()?

>  #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index a28a394ba32a..4caab8714e2c 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -440,6 +440,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  	port.port.status = UPSTAT_SYNC_FIFO;
>  	port.port.dev = &pdev->dev;
>  	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> +	port.bugs |= UART_BUG_TXRACE;
>  
>  	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
>  	if (rc < 0)
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d45dab1ab316..6c032abfc321 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1809,6 +1809,8 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  	count = up->tx_loadsz;
>  	do {
>  		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> +		if (up->bugs & UART_BUG_TXRACE)
> +			serial_in(up, UART_SCR);

Can you document why you are doing a call here to serial_in(), otherwise
someone running "automated checking scripts" will remove it later as it
seems to be doing nothing.

thanks,

greg k-h
