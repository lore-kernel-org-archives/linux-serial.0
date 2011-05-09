From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Add Cisco PowerTV serial support to 8250/PC16550D serial
 implementation
Date: Mon, 9 May 2011 13:54:52 +0100
Message-ID: <20110509135452.55ebc01d@lxorguk.ukuu.org.uk>
References: <20110509124640.GA14734@vijayas-lnx01.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39559 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752835Ab1EIMxf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2011 08:53:35 -0400
In-Reply-To: <20110509124640.GA14734@vijayas-lnx01.corp.sa.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vijayaraghavan <vijayas@cisco.com>
Cc: linux-serial@vger.kernel.org, gregkh@suse.de, dvomlehn@cisco.com

> +#elif defined(CONFIG_SERIAL_8250_IRBLASTER)
> +/**
> + * regmap_in - input register mapper, specific for Cisco PowerTV UARTS
> + */
> +static const u8
> +	regmap_in[8] = {
> +		[UART_RX]	= 0x18,
> +		[UART_IER]	= 0x04,
> +		[UART_IIR]	= 0x00,
> +		[UART_LCR]	= 0x08,
> +		[UART_FCR]	= 0x0c,
> +		[UART_LSR]	= 0x1c,

This is already completely unmaintainable and we are pushing stuff *out*
of this driver. Please provide you own ->serial_in and serial_out method
instead. That'll keep all the noise buried in your driver where it
belongs.

It looks like pretty much all of the rest of the errata you can then
cover up in your own code by correcting the register returns and/or doing
extra I/O in your serial_in and serial_out method to hide the brokenness
of the underlying device.

Alan
