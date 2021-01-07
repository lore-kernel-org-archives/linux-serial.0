Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B567C433E0
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB18233F8
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 15:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAGPOe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbhAGPOe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jan 2021 10:14:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49031233F6;
        Thu,  7 Jan 2021 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610032433;
        bh=hmkOGG92RRXz7BEJQDKw/xkmVnvkEqfCdqeGjl3cgXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSV8G/ovhjz9X/mQ56knTN11DMny8iGIhwgClAXYJ07eTiBpvwk5vjNe+dYFptWUN
         AQjdung1lB/Hc3A/4Un6w0Dp42q9W67J3HhXjSF0LICBCu4K+mfKVkR3n30SqHD2e5
         MheqXezXD1ea9GI54LfTPL213drm5B6u1Z9yU8IA=
Date:   Thu, 7 Jan 2021 16:15:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: make pl011 serial port driver support 485 mode
Message-ID: <X/clgcNQJXN72Ys/@kroah.com>
References: <1610000201-4117-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610000201-4117-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 07, 2021 at 02:16:41PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> make pl011 serial port support 485 mode full duplex communication
> 
> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
> Changes in v2:
>  - Fix two compilation errors

What changed from the version you sent yesterday with this same subject
line?

>  drivers/tty/serial/amba-pl011.c | 38 +++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c255476cce28..f6a7fe61e699 100644
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
> @@ -1284,14 +1285,33 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  #define pl011_dma_flush_buffer	NULL
>  #endif
> 
> +static unsigned int pl011_tx_empty(struct uart_port *port);
> +
>  static void pl011_stop_tx(struct uart_port *port)
>  {
> +	unsigned int cr;
> +	unsigned int result;

But below the uap definition please, like kernel style normally is.

>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> 
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		while(1) {
> +			result = pl011_tx_empty(port);
> +			if (ISEMPTY == result) {
> +				break;
> +			}

It's not ok to busy loop forever, sorry.

> +		}
> +		cr = pl011_read(uap, REG_CR);
> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) {
> +			cr |= UART011_CR_RTS;
> +		} else {
> +			cr &= ~UART011_CR_RTS;
> +		}

Did you run checkpatch on this code?  Please fix up.

thanks,

greg k-h
