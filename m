Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E7C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A216861264
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhJEMzV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 08:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhJEMzU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 08:55:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB344611C3;
        Tue,  5 Oct 2021 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633438410;
        bh=0oD/T6QtDflRB88pbKyb2S+SSnig767ocUT6GBM9gks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iaHGj1ntScbS6GUz/3/GVvT3fGzaxI8GAtEff+VM2nXLI8tqzmFPD+MWPaCU9SUog
         GbC0rEKujRlig6ZhAR7787KUmKMemPEjDFQ2GZefg1m2ZsWHazrrmC/mOMbU8rKowL
         Mk4Ko3SPzMe5dmTJLi90jO3RopQJGOqKEHg3N/gs=
Date:   Tue, 5 Oct 2021 14:53:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/2] serial: 8250_lpss: Extract
 dw8250_do_set_termios() for common use
Message-ID: <YVxKyOODe3ZWmnFZ@kroah.com>
References: <20211002185141.31652-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002185141.31652-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Oct 02, 2021 at 09:51:40PM +0300, Andy Shevchenko wrote:
> Some of the code currently used in dw8250_set_termios(), byt_set_termios()
> may be reused by other methods in the future. Extract it to a common helper
> function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c    |  8 ++------
>  drivers/tty/serial/8250/8250_dwlib.c | 10 ++++++++++
>  drivers/tty/serial/8250/8250_dwlib.h |  1 +
>  drivers/tty/serial/8250/8250_lpss.c  |  6 +-----
>  4 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a3a0154da567..e3c90c9e2448 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -338,7 +338,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>  	rate = clk_round_rate(d->clk, newrate);
>  	if (rate > 0) {
>  		/*
> -		 * Premilinary set the uartclk to the new clock rate so the
> +		 * Preliminary set the uartclk to the new clock rate so the

Different change, not mentioned in the changelog, please make this a
separate patch.

thanks,

greg k-h
