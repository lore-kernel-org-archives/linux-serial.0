From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date: Wed, 19 Jun 2013 12:01:06 +0200
Message-ID: <2302882.NVjP8DdXWY@wuerfel>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63035 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933873Ab3FSKAU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Jun 2013 06:00:20 -0400
In-Reply-To: <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>

On Tuesday 18 June 2013 12:12:53 David Daney wrote:
> +static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
> +{
> +       offset <<= p->regshift;
> +
> +       return (u8)__raw_readq(p->membase + offset);
> +}
> +
> +static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
> +{
> +       struct dw8250_data *d = p->private_data;
> +
> +       if (offset == UART_LCR)
> +               d->last_lcr = value;
> +
> +       offset <<= p->regshift;
> +       __raw_writeq(value, p->membase + offset);
> +       dw8250_serial_inq(p, UART_LCR);
> +}

This breaks building on 32 bit architectures as I found on my daily ARM
builds: __raw_writeq cannot be defined on architectures that don't have
native 64 bit data access instructions. It's also wrong to use the
__raw_* variant, which is not guaranteed to be atomic and is not
endian-safe.

	Arnd
