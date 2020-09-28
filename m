Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067DC2D0A8
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 12:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF43D2100A
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601295632;
	bh=xzxdCXA8dmS06Vmq0uM5K5r76AuJZ7eOVlE6AvLQaCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jmzBf8s7OT8AJWI3idaGX+srwlSfEZyl1THLjrZsIZQpuWOTYAgttvY1ogOc7QFTf
	 AhpVWkWRBEgH6k9mrmYBiFH3zQFLX5GVblpyJ3z5h+rWDr4p6Mpk4ZUjn8fYOikAPn
	 a/ZbrS5kHrgfA054e4rasNxUjNj+Q1Z5BYWFVrlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI1MUc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Sep 2020 08:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1MUc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 08:20:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DED5E2083B;
        Mon, 28 Sep 2020 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601295631;
        bh=xzxdCXA8dmS06Vmq0uM5K5r76AuJZ7eOVlE6AvLQaCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciCqRjyBvYDu3b8l3kGYzgjtFjANZwVxpNTF4XKqnQP1oxiVmWFbDoo6PInOXpR60
         fPPodc0aNOGvmsm610LSSoltLnlK5NR9f8ildeSu8t4jleEz6YXc8XsDZ97gvO5azJ
         aiSMS+SAYiPfup0ScL9W7qF3ygaHAcrbIZayZOOg=
Date:   Mon, 28 Sep 2020 14:20:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     drolevar@gmail.com
Cc:     linux-serial@vger.kernel.org, Andrij Abyzov <aabyzov@slb.com>
Subject: Re: [PATCH v2 1/1] serial: 8250_fsl: Fix TX interrupt handling
 condition
Message-ID: <20200928122039.GA682772@kroah.com>
References: <20200928102841.43782-1-aabyzov@slb.com>
 <20200928102841.43782-2-aabyzov@slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928102841.43782-2-aabyzov@slb.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 28, 2020 at 12:28:41PM +0200, drolevar@gmail.com wrote:
> From: Andrij Abyzov <aabyzov@slb.com>
> 
> This is the port of the commit db1b5bc047b3 ("serial: 8250: Fix TX
> interrupt handling condition") to the 8250_fsl irq handling logic.
> 
> Interrupt handler checked THRE bit (transmitter holding register
> empty) in LSR to detect if TX fifo is empty.
> In case when there is only receive interrupts the TX handling
> got called because THRE bit in LSR is set when there is no
> transmission (FIFO empty). TX handling caused TX stop, which in
> RS-485 half-duplex mode actually resets receiver FIFO. This is not
> desired during reception because of possible data loss.
> 
> The fix is to check if THRI is set in IER in addition of the TX
> fifo status. THRI in IER is set when TX is started and cleared
> when TX is stopped.
> This ensures that TX handling is only called when there is really
> transmission on going and an interrupt for THRE and not when there
> are only RX interrupts.
> 
> Signed-off-by: Andrij Abyzov <aabyzov@slb.com>
> ---
>  drivers/tty/serial/8250/8250_fsl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
> index 0d0c80905c58..ceac6cfce4c7 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
>  
>  	serial8250_modem_status(up);
>  
> -	if (lsr & UART_LSR_THRE)
> +	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
>  		serial8250_tx_chars(up);
>  
>  	up->lsr_saved_flags = orig_lsr;
> -- 
> 2.25.1
> 

What changed from v1?

That goes below the --- line, as is asked for in the submitting patches
document, right?

Can you fix that up and send a v3?

Also, why are you forwarding on a patch that you did not write or sign
off on?  Please sign off on it yourself too.

thanks,

greg k-h
