From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] [RFC] uartclk from serial_core exposed to sysfs
Date: Thu, 16 Aug 2012 11:31:52 +0100
Message-ID: <20120816113152.73838695@pyramind.ukuu.org.uk>
References: <CAEB7QLAJXkK6NDPVDi36n_U_X_DGh5niHJhH6FpqBUZFmXQ2Xg@mail.gmail.com>
	<1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48618 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab2HPK1R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 06:27:17 -0400
In-Reply-To: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, marek.vasut@gmail.com


> +	/*
> +	 * Check value: baud_base has to be more than 9600
> +	 * and uartclock = baud_base * 16 .
> +	 */
> +	if (val >= 153600)
> +		state->uart_port->uartclk = val;
> +
> +	mutex_unlock(&state->port.mutex);
> +
> +	return count;

This breaks if for example the port is in use. Fixing that looks pretty
horrible as you need a valid tty pointer to stop and restart the pot.

It's also not calling the verfy method of the port as is expected.

At minimum I think you need to be able to do the same work
uart_get_info/uart_set_info perform and with the same checks on ->verify
etc.

I'm not 100% sure the drvdata on the tty_dev is clear to use. It does
seem to be in all the drivers I looked at. I'd rather however it pointed
to the tty_port that each tty device has (or very soon will be required
to have). You can still find the uart_foo structs from that but it means
we can do the dev_set_drvdata() in a consistent manner for all tty
devices in the kernel. That in turn means we can make some of the sysfs
valid the same way.

I want to have think about the setting side of it. Can you submit a
revised version that just allows the user to read the value this way but
does the drvdata setting etc and sysfs node create/delete.

I'll merge that and we can throw it over the parapet and see if anything
explodes.

To make the setting part work properly I think I need to sort out
uart_get_info/set_info so the core part of it can be called with kernel
space structures and the caller handling locks.

Alan
