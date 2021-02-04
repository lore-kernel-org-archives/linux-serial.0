Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17A8C433DB
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B146064DA5
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 15:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbhBDPwc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237570AbhBDPwS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 10:52:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F2861477;
        Thu,  4 Feb 2021 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612453896;
        bh=we99LVZdfR8qDwTYTsqf8j51n6oP8RsuHS+ZJSKf63w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5Q+6kxBcvT735pgbAc41XW6uG71OnYJ2PJG4CC5rM6Cxp3sryf7lKf59tfMbVqrY
         fFhNjcYqSYSvG8TP2Gh477gUCXDrj7baGWg/26eCubRFm8kpo284cmDmSEGyMpTaIR
         vAf8UgCnxbPGqAapAXgAtBw4L1KBpAYAKR1BWOJQ=
Date:   Thu, 4 Feb 2021 16:51:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4] tty: make pl011 serial port driver support 485 mode
Message-ID: <YBwYBed2IH0PFpcS@kroah.com>
References: <1612164643-1480-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612164643-1480-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 01, 2021 at 03:30:43PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> make pl011 serial port support 485 mode full duplex communication
> 
> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
> Changes in v4:
>   -Add a bound to the loop in pl011_stop_tx
>   -Remove extra curly braces in pl011_stop_tx
> 
> Changes in v3:
>   -Fix busy loop forever in pl011_tx_empty
>   -Move the definition of cr into uart_amba_port
>   -Run checkpatch with no error or warning
> 
> Changes in v2:
>   -Fix two compilation errors
> 
>  drivers/tty/serial/amba-pl011.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c255476..026add3 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -44,6 +44,7 @@
> 
>  #include "amba-pl011.h"
> 
> +#define ISEMPTY			1
>  #define UART_NR			14
> 
>  #define SERIAL_AMBA_MAJOR	204
> @@ -264,6 +265,7 @@ struct uart_amba_port {
>  	unsigned int		fifosize;	/* vendor-specific */
>  	unsigned int		old_cr;		/* state during shutdown */
>  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
> +	unsigned int		cr;
>  	char			type[12];
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
> @@ -1284,14 +1286,33 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  #define pl011_dma_flush_buffer	NULL
>  #endif
> 
> +static unsigned int pl011_tx_empty(struct uart_port *port);
> +
>  static void pl011_stop_tx(struct uart_port *port)
>  {
> +	unsigned int count = 1000000;    /* 1s */

1 second of what?

>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> 
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		while(pl011_tx_empty(port) != ISEMPTY && count) {
> +			count--;
> +			cpu_relax();
> +			udelay(1);

Why relax and delay?

And always run checkpatch on your change before sending it out next
time.

thanks,

greg k-h
