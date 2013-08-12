From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tilegx: Add tty serial support for TILE-Gx on-chip UART
Date: Mon, 12 Aug 2013 11:43:29 -0700
Message-ID: <20130812184329.GB19875@kroah.com>
References: <201308121836.r7CIa3Kj004272@farm-0021.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55553 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab3HLSna (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Aug 2013 14:43:30 -0400
Content-Disposition: inline
In-Reply-To: <201308121836.r7CIa3Kj004272@farm-0021.internal.tilera.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Mon, Aug 12, 2013 at 02:11:44PM -0400, Chris Metcalf wrote:
> +/*
> + * Enable modem status interrupts.
> + */
> +static void tilegx_enable_ms(struct uart_port *port)
> +{
> +	/* N/A */
> +}
> +
> +/*
> + * Control the transmission of a break signal.
> + */
> +static void tilegx_break_ctl(struct uart_port *port, int break_state)
> +{
> +	/* N/A */
> +}

For most of these "empty" callbacks, you shouldn't have to declare them
at all, and all should work just fine.

Other than that minor nit, at first glance this looks fine to me.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
