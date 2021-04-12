Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67512C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 05:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B9761209
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 05:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhDLFwp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 01:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhDLFwo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 01:52:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A75D561207;
        Mon, 12 Apr 2021 05:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618206747;
        bh=efCpCnAinHSf2kSKdV1JoeqCUQSQ/06SRXMJwGOgVdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWgropJxyAI8fh04gSOaCZDSUtj00UIEqrA1HMKf54YVJLlfVfGzlIZqRmMH29h3M
         8n0DXpGk0AvcvVsvIHvGkfwhG/VKqdkHNdNwefP4EvhPkyBWbuqo+E8DpqppwZea74
         asFZk45SAuqLMKJGYJ4+CtCiT44m331SXxTo8ylU=
Date:   Mon, 12 Apr 2021 07:52:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dillon.minfei@gmail.com
Cc:     jirislaby@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: stm32: optimize spin lock usage
Message-ID: <YHPgGI6EmTzmVH7g@kroah.com>
References: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 12, 2021 at 12:34:21PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> To avoid potential deadlock in spin_lock usage, change to use
> spin_lock_irqsave(), spin_unlock_irqrestore() in process(thread_fn) context.
> spin_lock(), spin_unlock() under handler context.
> 
> remove unused local_irq_save/restore call.
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> Was verified on stm32f469-disco board. need more test on stm32mp platform.
> 
>  drivers/tty/serial/stm32-usart.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index b3675cf25a69..c4c859b34367 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -214,7 +214,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
>  	struct tty_port *tport = &port->state->port;
>  	struct stm32_port *stm32_port = to_stm32_port(port);
>  	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> -	unsigned long c;
> +	unsigned long c, flags;
>  	u32 sr;
>  	char flag;
>  
> @@ -276,9 +276,17 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
>  		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
>  	}
>  
> -	spin_unlock(&port->lock);
> +	if (threaded)
> +		spin_unlock_irqrestore(&port->lock, flags);
> +	else
> +		spin_unlock(&port->lock);

You shouldn't have to check for this, see the other patches on the list
recently that fixed this up to not be an issue for irq handlers.

thanks,

greg k-h
