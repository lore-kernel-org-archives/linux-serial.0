Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E358C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149F623A52
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 12:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbhANMea (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jan 2021 07:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbhANMea (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jan 2021 07:34:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C769A23A52;
        Thu, 14 Jan 2021 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610627629;
        bh=C5d5NyVY11M+UZtH0nRm7QFZahShBi0foysS5SgWurk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ntt/oKDDraSkmoJx427OZLk1rpsEgDsIYtKkYX8xv47b5WhU0EpX3alAYx+7krXbM
         Ql/KqTKpFmkCXri0l2ibe+Ol7s8dgR7p+TkMJLc81nd+4qU9Tc68qPPu/ecn2JcMp8
         rSzJfsSbHEOW8MTmZa/oPxWV96s/5qCSeiRyd+eo=
Date:   Thu, 14 Jan 2021 13:33:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty: make pl011 serial port driver support 485 mode
Message-ID: <YAA6Kk+MeKmHBJMk@kroah.com>
References: <1610627310-28889-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610627310-28889-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 14, 2021 at 08:28:30PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> make pl011 serial port support 485 mode full duplex communication
> 
> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
> Changes in v3:
>   -Fix busy loop forever in pl011_tx_empty
>   -Move the definition of cr into uart_amba_port
>   -run checkpatch with no error or warning
> 
> Changes in v2:
>   -Fix two compilation errors
> 
>  drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c255476..9da10a4 100644
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
> @@ -1284,6 +1286,8 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  #define pl011_dma_flush_buffer	NULL
>  #endif
> 
> +static unsigned int pl011_tx_empty(struct uart_port *port);
> +
>  static void pl011_stop_tx(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
> @@ -1292,6 +1296,17 @@ static void pl011_stop_tx(struct uart_port *port)
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		while(pl011_tx_empty(port) != ISEMPTY) ;

No busy loops that run forever please.

> +
> +		uap->cr = pl011_read(uap, REG_CR);
> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) {
> +			uap->cr |= UART011_CR_RTS;
> +		} else {
> +			uap->cr &= ~UART011_CR_RTS;
> +		}

checkpatch did not complain about this?  It should have.

thanks,

greg k-h
