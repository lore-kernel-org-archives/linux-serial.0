From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] TTY: serial 8250: Support MCR CLK_SEL bit.
Date: Mon, 19 Nov 2012 12:00:43 +0000
Message-ID: <20121119120043.39f59baf@pyramind.ukuu.org.uk>
References: <20121119085421.315.47347.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58704 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2KSLzh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 06:55:37 -0500
In-Reply-To: <20121119085421.315.47347.stgit@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

>     * Allows the CLK_SEL bit to be forced to /1, /4 or left as is.

This seems to be the wrong place to set such stuff. The kernel knows what
speed is selected and therefore what clock would be best.

Having a clocksel (and probably an of value indicating which type of
clock sel) is a good thing, but it also ought to be set based on the
requested baud rate, so a custom set_termios would be better.

That would also handle serial console, and suspend/resume without other
tweaks as far as I can see.

It also seems some devices use different clksel algorithms so rather than
a CAP_CLKSEL flag we probably need to key it off the uart type.


>  static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>  {
>  	if (p->capabilities & UART_CAP_SLEEP) {
> -		if (p->capabilities & UART_CAP_EFR) {
> -			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
> -			serial_out(p, UART_EFR, UART_EFR_ECB);
> -			serial_out(p, UART_LCR, 0);
> -		}
> +		serial8250_enable_extended(p);
>  		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);

This seems wrong if theere is no EFR

> +static int serial8250_configure_clock_predivisor(struct uart_8250_port *p)
> +{

Ought to be named to reflect that it appears to be exar specific

Architecturally the patch seems wrong though. I'd expect a device with a
clock predivisor to be treated as a device with a wider clock range and
just handle it when the speed is set. Eg wrapping set_termios or adding a 

	->select_clock(port, bitrate);

helper.

Alan
