Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509CFC2B9F4
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306A9613CA
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhFQLYl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhFQLYk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Jun 2021 07:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CCEA613BF;
        Thu, 17 Jun 2021 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623928953;
        bh=7W6ZUJUgvAuyObY+Gwz9gOCcH56okP5pyM7YKdKyOxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAHH/dgtPd9TF6pgepsFS3oIce5b/X13/xa4cXrZijhnfCujrutwtL+w/5QqaFKqj
         fNxiZSUO/wGfLHgifF5FtVPwbYcOykde0m2ZAPmCZTVEcZ8cKGX1Yt9WTyh0oEyvDh
         RMjF4Kb74h8ho702XmfG/6m778hgdk0njFLmxqJY=
Date:   Thu, 17 Jun 2021 13:22:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] tty: serial: owl: Fix data race in owl_uart_remove
Message-ID: <YMswdqNpjb9n1pdW@kroah.com>
References: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 17, 2021 at 04:34:43PM +0530, Saubhik Mukherjee wrote:
> Suppose the driver is registered and a UART port is added. Once an
> application opens the port, owl_uart_startup is called which registers
> the interrupt handler owl_uart_irq.
> 
> We could have the following race condition:
> 
> When device is removed, owl_uart_remove is called, which calls
> uart_remove_one_port, which calls owl_uart_release_port, which writes
> NULL to port->membase. At this point parallely, an interrupt could be
> handled by owl_uart_irq which reads port->membase.
> 
> This is because it is possible to remove device without closing a port.
> Thus, we need to check it and call owl_uart_shutdown in owl_uart_remove.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
> ---
>  drivers/tty/serial/owl-uart.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> index 91f1eb0058d7..ac4e3aae2719 100644
> --- a/drivers/tty/serial/owl-uart.c
> +++ b/drivers/tty/serial/owl-uart.c
> @@ -751,8 +751,15 @@ static int owl_uart_probe(struct platform_device *pdev)
>  static int owl_uart_remove(struct platform_device *pdev)
>  {
>  	struct owl_uart_port *owl_port = platform_get_drvdata(pdev);
> +	struct uart_port *port = &owl_port->port;
>  
> -	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
> +	/* It is possible to release device without closing a port.
> +	 * Thus, need to check it and call shutdown.
> +	 */
> +	if (owl_uart_read(port, OWL_UART_CTL) & OWL_UART_CTL_EN)
> +		owl_uart_shutdown(port);

How is this read determining if the device is here or not?  And what
happens if the state change happens right _after_ the check?

Also, your comment style is for networking, not the rest of the kernel
:)

thanks,

greg k-h
