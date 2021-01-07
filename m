Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E8C433DB
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B5323405
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 15:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbhAGPUR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbhAGPUQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jan 2021 10:20:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 959E6233FD;
        Thu,  7 Jan 2021 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610032776;
        bh=UB24bBL+xWXpFOs5afALQp6ryz62GM0B/ZX2FZZqhdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTZj75l7ly3oQmGCJ3VXkkiOn5CsPYPAleXdzsxBwkcQYg8zmzLzA4nN6KIOa/F5Y
         pALoC2R2Ms/63cLkG+OxX2TztMAFWAy82/s6kMcXEeR2PaprBOkY1DootAhnz5Dw+l
         NpQjkrqoR8E64HuHAnGfY8p4JKOoRv9MlWDkSQhI=
Date:   Thu, 7 Jan 2021 16:20:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tty: serial: owl: Add support for kernel debugger
Message-ID: <X/cm1+wVQpoXj5Xr@kroah.com>
References: <036c09732183a30eaab230884114f65ca42ca3b9.1609865007.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036c09732183a30eaab230884114f65ca42ca3b9.1609865007.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 05, 2021 at 07:02:02PM +0200, Cristian Ciocaltea wrote:
> Implement 'poll_put_char' and 'poll_get_char' callbacks in struct
> 'owl_uart_ops' that enables OWL UART to be used for kernel debugging
> over serial line.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v2:
>  - Reverted unnecessary changes per Andreas feedback
>  - Optimized implementation for 'owl_uart_poll_get_char()'
>    and 'owl_uart_poll_put_char()' callbacks
> 
>  drivers/tty/serial/owl-uart.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> index c149f8c30007..54b24669ebc5 100644
> --- a/drivers/tty/serial/owl-uart.c
> +++ b/drivers/tty/serial/owl-uart.c
> @@ -12,6 +12,7 @@
>  #include <linux/console.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -461,6 +462,26 @@ static void owl_uart_config_port(struct uart_port *port, int flags)
>  	}
>  }
>  
> +#ifdef CONFIG_CONSOLE_POLL
> +
> +static int owl_uart_poll_get_char(struct uart_port *port)
> +{
> +	if (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_RFEM)
> +		return NO_POLL_CHAR;
> +
> +	return owl_uart_read(port, OWL_UART_RXDAT);
> +}
> +
> +static void owl_uart_poll_put_char(struct uart_port *port, unsigned char ch)
> +{
> +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
> +		cpu_relax();

Unbounded loops?  What could possibly go wrong?

:(

Please don't do that in the kernel, put a max bound on this.

And are you _SURE_ that cpu_relax() is what you want to call here?

thanks,

greg k-h
