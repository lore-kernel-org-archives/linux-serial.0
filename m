Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B9C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 15:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFACA619E8
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 15:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhKOQB3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232362AbhKOQBP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 11:01:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8BA9619E8;
        Mon, 15 Nov 2021 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636991900;
        bh=6ObChIFYaBXn4SrtM0fzLgR5LrUgX/Hu5OOpSd/gAxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhhI0RWAvBYQAGQKvKrKkCqPOFOB/go4eCNDSI2GqTkpqkSoXznmq5xf4lmLBqRaM
         YYKG5fxg8iaAyyiTcMjlAz7v6WGbIGcfI9nnZ7I3GonmfzPCUHHRIHAdWUICgSd3TA
         oc/xP77m+KUnuHo6yiNQb4ZnBYEg5WfyYbxpHfcM=
Date:   Mon, 15 Nov 2021 16:58:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     richard.genoud@gmail.com, jirislaby@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: atmel: Check return code of
 dmaengine_submit()
Message-ID: <YZKDmb/ZlYwtyX8j@kroah.com>
References: <20211115143004.32743-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115143004.32743-1-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 15, 2021 at 04:30:04PM +0200, Tudor Ambarus wrote:
> dma_cookie_t < 0 indicates an error code, check for it.

Very odd changelog text, please be more descriptive about what is
happening here.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 2c99a47a2535..376f7a9c2868 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1004,6 +1004,11 @@ static void atmel_tx_dma(struct uart_port *port)
>  		desc->callback = atmel_complete_tx_dma;
>  		desc->callback_param = atmel_port;
>  		atmel_port->cookie_tx = dmaengine_submit(desc);
> +		if (dma_submit_error(atmel_port->cookie_tx)) {
> +			dev_err(port->dev, "dma_submit_error %d\n",
> +				atmel_port->cookie_tx);
> +			return;

What can a user do with this error message?

Have you seen this happen in real life?

What commit does this "fix"?

thanks,

greg k-h
