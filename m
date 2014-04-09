From: Dave Hansen <dave@sr71.net>
Subject: Re: post 3.14 serial regression
Date: Wed, 09 Apr 2014 13:04:03 -0700
Message-ID: <5345A7B3.7020005@sr71.net>
References: <5343416F.8010201@sr71.net>	<20140408122726.227f3da8@alan.etchedpixels.co.uk>	<5344642A.2020703@sr71.net>	<53446C57.5000504@intel.com>	<20140409003648.GB32273@kroah.com> <CAMuHMdXSa0Ku2f1CR3j5pGOp_joQomc2Cnz=apGRR1K0Eb2qOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:48143 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933342AbaDIUEG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Apr 2014 16:04:06 -0400
In-Reply-To: <CAMuHMdXSa0Ku2f1CR3j5pGOp_joQomc2Cnz=apGRR1K0Eb2qOQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On 04/09/2014 12:41 PM, Geert Uytterhoeven wrote:
> Dave: If I understand it correctly, you use console=ttyS2, while the kernel
> suddenly changed the order of the serial devices, so your port is no
> longer ttyS2, but ttyS4. Hence the serial port is not found, and
> uart_remove_one_port() is called on it, taking away your /dev/console for
> userspace?

Right.

> Why does the serial port driver call uart_add_one_port() for ports that
> don't exist?
> Or if it does exist ("inaccessible and buried inside the system somewhere"),
> how is it removed again?

The ones buried inside the system are immaterial here.  I just wanted to
explain why I was using a separate PCI card instead of the other serial
ports.

>>From the backtrace, it's the call below to uart_remove_one_port()
> that removes the port?
> 
> /**
>  *      serial8250_register_8250_port - register a serial port
>  *      @up: serial port template
>  *
>  *      Configure the serial port specified by the request. If the
>  *      port exists and is in use, it is hung up and unregistered
>  *      first.
>  *
>  *      The port is then probed and if necessary the IRQ is autodetected
>  *      If this fails an error is returned.
>  *
>  *      On success the port is ready to use and the line number is returned.
>  */
> int serial8250_register_8250_port(struct uart_8250_port *up)
> {
>         ...
> 
>         if (uart && uart->port.type != PORT_8250_CIR) {
>                 if (uart->port.dev)
>                         uart_remove_one_port(&serial8250_reg, &uart->port);
> 
> where was it added before?

Remember, serial8250_find_match_or_unused() will also reuse *EXISTING*
uart_ports if the port is of 'unknown' type.

I believe that port got added during the addition of the
serial8250_isa_devs, and now we're trying to reuse it since it is an
unknown port type.
