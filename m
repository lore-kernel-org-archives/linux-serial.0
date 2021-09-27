Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BCC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD7760F43
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhI0J5X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhI0J5X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Sep 2021 05:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E1AB60F70;
        Mon, 27 Sep 2021 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632736546;
        bh=PFhFMtEfwmcVbGVJXlm2BQkfa6NmF5Jtvsa6updisJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vsxAviryqEAuEOvhEJsDg57Zo7i56zccSt5M+n67KUKuccJf1VddyumHgLEDZW70x
         SPHIkoU78LZfADtHF5z2WHJsQ5BWK8c2omZXXpR4DdloVTfIWQTsdLl5+rXHrOFTeu
         oZ4Lw84CRDURDLjwfFHzFPRp9BOYJd7uJlt105XQ=
Date:   Mon, 27 Sep 2021 11:55:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Fix reporting real baudrate value in
 c_ospeed field
Message-ID: <YVGVHzHzhOjUp7b8@kroah.com>
References: <20210927093704.19768-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927093704.19768-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 27, 2021 at 11:37:04AM +0200, Pali Rohár wrote:
> In most cases it is not possible to set exact baudrate value to hardware.

Why not?

> So fix reporting real baudrate value which was set to hardware via c_ospeed
> termios field. It can be retrieved by ioctl(TCGETS2) from userspace.
> 
> Real baudrate value is calculated from chosen hardware divisor and base
> clock. It is implemented in a new function serial8250_compute_baud_rate()
> which is inverse of serial8250_get_divisor() function.
> 
> With this change is fixed also UART timeout value (it is updated via
> uart_update_timeout() function), which is calculated from the now fixed
> baudrate value too.

I can not parse this sentence, sorry.  Can you try to rephrase it
differently?

> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: stable@vger.kernel.org
> ---
> 
> I have tested this change on device with 8250 compatible UART. I have not
> tested it on PORT_NPCM nor on UPF_MAGIC_MULTIPLIER hardware, as I do not
> have such.
> 
> Tested device has 250 MHz base clock for 8250 UART. When I set baudrate to
> 115200, then ioctl(TCGETS2) reported B115200 CBAUD flag and value 114890 in
> c_ospeed field.
> 
> This result is correct as HW for baudrate 115200 is using UART divisor 136,
> which results in correct reported baudrate: 250000000/(16*136) = 114890

So is this going to break all the userspace tools that set a baud rate
and then read it back and get a different number than what they thought
they set?

That feels very dangerous.  Why does this matter?

> ---
>  drivers/tty/serial/8250/8250_port.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 66374704747e..dc6900b2daa8 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2584,6 +2584,19 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
>  	return serial8250_do_get_divisor(port, baud, frac);
>  }
>  
> +static unsigned int serial8250_compute_baud_rate(struct uart_port *port,
> +						 unsigned int quot)
> +{
> +	if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8001)
> +		return port->uartclk / 4;
> +	else if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8002)
> +		return port->uartclk / 8;
> +	else if (port->type == PORT_NPCM)
> +		return DIV_ROUND_CLOSEST(port->uartclk - 2 * (quot + 2), 16 * (quot + 2));
> +	else
> +		return DIV_ROUND_CLOSEST(port->uartclk, 16 * quot);
> +}

Where did these formulas come from?

thanks,

greg k-h
