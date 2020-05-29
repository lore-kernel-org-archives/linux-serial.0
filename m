Return-Path: <SRS0=RakX=7L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6999C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE76E2072D
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 15:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2P4v (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 May 2020 11:56:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2P4v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 11:56:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CCE2ACB8;
        Fri, 29 May 2020 15:56:48 +0000 (UTC)
Subject: Re: [PATCH 1/1] tty: serial: owl: Add support for kernel debugger
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
References: <6ee88060c129715980592a1ae33c93923916a14b.1590766726.git.cristian.ciocaltea@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <16ff435f-9172-e01d-dfe6-7aa8575c4bd6@suse.de>
Date:   Fri, 29 May 2020 17:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6ee88060c129715980592a1ae33c93923916a14b.1590766726.git.cristian.ciocaltea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Am 29.05.20 um 17:50 schrieb Cristian Ciocaltea:
> Implement poll_put_char and poll_get_char callbacks in struct uart_ops
> that enables OWL UART to be used for KGDB debugging over serial line.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>   drivers/tty/serial/owl-uart.c | 45 ++++++++++++++++++++++++++++++-----
>   1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> index c2fa2f15d50a..26dcc374dec5 100644
> --- a/drivers/tty/serial/owl-uart.c
> +++ b/drivers/tty/serial/owl-uart.c
> @@ -12,6 +12,7 @@
>   #include <linux/console.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> @@ -20,13 +21,13 @@
>   #include <linux/tty.h>
>   #include <linux/tty_flip.h>
>   
> -#define OWL_UART_PORT_NUM 7
> -#define OWL_UART_DEV_NAME "ttyOWL"
> +#define OWL_UART_PORT_NUM		7
> +#define OWL_UART_DEV_NAME		"ttyOWL"
>   
> -#define OWL_UART_CTL	0x000
> -#define OWL_UART_RXDAT	0x004
> -#define OWL_UART_TXDAT	0x008
> -#define OWL_UART_STAT	0x00c
> +#define OWL_UART_CTL			0x000
> +#define OWL_UART_RXDAT			0x004
> +#define OWL_UART_TXDAT			0x008
> +#define OWL_UART_STAT			0x00c

Please do not unnecessarily re-indent kernel code. You can do so when 
you're actually adding something new.

>   
>   #define OWL_UART_CTL_DWLS_MASK		GENMASK(1, 0)
>   #define OWL_UART_CTL_DWLS_5BITS		(0x0 << 0)
> @@ -461,6 +462,34 @@ static void owl_uart_config_port(struct uart_port *port, int flags)
>   	}
>   }
>   
> +#ifdef CONFIG_CONSOLE_POLL
> +
> +static int owl_uart_poll_get_char(struct uart_port *port)
> +{
> +	u32 c = NO_POLL_CHAR;
> +
> +	if (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_RFEM))
> +		c = owl_uart_read(port, OWL_UART_RXDAT);
> +
> +	return c;
> +}
> +
> +static void owl_uart_poll_put_char(struct uart_port *port, unsigned char c)
> +{
> +	/* Wait while TX FIFO is full */
> +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
> +		cpu_relax();
> +
> +	/* Send the character out */
> +	owl_uart_write(port, c, OWL_UART_TXDAT);
> +
> +	/* Wait for transmitter to become empty */
> +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TRFL_MASK)
> +		cpu_relax();
> +}

How is this different from earlycon? I dislike that this is being 
open-coded. Please try to reuse existing functions for this.

Regards,
Andreas

> +
> +#endif /* CONFIG_CONSOLE_POLL */
> +
>   static const struct uart_ops owl_uart_ops = {
>   	.set_mctrl = owl_uart_set_mctrl,
>   	.get_mctrl = owl_uart_get_mctrl,
> @@ -476,6 +505,10 @@ static const struct uart_ops owl_uart_ops = {
>   	.request_port = owl_uart_request_port,
>   	.release_port = owl_uart_release_port,
>   	.verify_port = owl_uart_verify_port,
> +#ifdef CONFIG_CONSOLE_POLL
> +	.poll_get_char	= owl_uart_poll_get_char,
> +	.poll_put_char	= owl_uart_poll_put_char,
> +#endif
>   };
>   
>   #ifdef CONFIG_SERIAL_OWL_CONSOLE
> 


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
