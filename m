Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A0C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A04E60F43
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhG2PB6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237669AbhG2PB5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 11:01:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B1CB60720;
        Thu, 29 Jul 2021 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627570914;
        bh=hca+tvhbiIAtfg4/Z9HUcM4UPA9pVVF4EgIfWYOGuU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWAUBuC43eTB8Cv72pNNuVaSMYIut4L8O5y0MGqUMugJ8zuG9gOmlEpZuTJ+oxi+B
         FTlzyH56peRgQWXAptQl8Z2jq9wxCfnnv+tuHeK72EmifS9TWkMQF24tyf9AanSS+a
         j5dZwntbc/XWnn7iPKvpF60aeSryG/ptTTh7rox8=
Date:   Thu, 29 Jul 2021 17:01:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 5/5] tty: serial: uartlite: Prevent changing fixed
 parameters
Message-ID: <YQLC4L2Z3T4SuryE@kroah.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-6-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723223152.648326-6-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 23, 2021 at 06:31:51PM -0400, Sean Anderson wrote:
> This device does not support changing baud, parity, data bits, stop
> bits, or detecting breaks. Disable "changing" these settings to prevent
> their termios from diverging from the actual state of the uart. To inform
> users of these limitations, warn if the new termios change these
> parameters. We only do this once to avoid spamming the log. These
> warnings are inspired by those in the sifive driver.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 39c17ab206ca..0aed70039f46 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -314,7 +314,54 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
>  			      struct ktermios *old)
>  {
>  	unsigned long flags;
> -	unsigned int baud;
> +	struct uartlite_data *pdata = port->private_data;
> +	tcflag_t old_cflag;
> +
> +	if (termios->c_iflag & BRKINT)
> +		dev_err_once(port->dev, "BREAK detection not supported\n");
> +	termios->c_iflag &= ~BRKINT;
> +
> +	if (termios->c_cflag & CSTOPB)
> +		dev_err_once(port->dev, "only one stop bit supported\n");
> +	termios->c_cflag &= ~CSTOPB;
> +
> +	old_cflag = termios->c_cflag;
> +	termios->c_cflag &= ~(PARENB | PARODD);
> +	if (pdata->parity == 'e')
> +		termios->c_cflag |= PARENB;
> +	else if (pdata->parity == 'o')
> +		termios->c_cflag |= PARENB | PARODD;
> +
> +	if (termios->c_cflag != old_cflag)
> +		dev_err_once(port->dev, "only '%c' parity supported\n",
> +			     pdata->parity);

Through all of this, you are warning that nothing is supported, yet you
are continuing on as if all of this worked just fine.

That feels odd, why is this needed at all?  If you really do not support
any changes here, why even fake it?

thanks,

greg k-h
