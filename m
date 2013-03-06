From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: arc_uart: serial output truncated
Date: Wed, 06 Mar 2013 13:58:14 -0500
Message-ID: <1362596294.18799.185.camel@thor.lan>
References: <513748EA.7050407@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:38689 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab3CFS6U (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Mar 2013 13:58:20 -0500
In-Reply-To: <513748EA.7050407@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Wed, 2013-03-06 at 19:17 +0530, Vineet Gupta wrote:
> Hi,
> 
> I'm seeing truncated serial console output, with 3.8 based arc_uart driver
> (drivers/tty/serial/arc_uart.c)

<...snip...>

> However user app then immediately calls exit().
> 
> do_exit
>   tty_release
>     uart_close
>       tty_port_close_start --> returns 0 - because port->count == 4
> ...
>   disassociate_ctty
>     tty_ldisk_hangup
>       tty_driver_flush_buffer
>          tty->ops->flush_buffer
>          uart_flush_buffer
>            uart_circ_clear  --> zeros the driver tx buffer head/tail
> 
> 
> tty_port_close_start() has logic for port->drain_delay but in my case the
> port->count is 4 (3 due to init task, 1 from this specific app) so that logic is
> not hit.
> 
> Eventually, uart_flush_buffer is called, with unwritten data still present, but
> the head/tail pointers are reset, causing that driver data to be effectively lost.
> 
> So maybe this is how it works (for a 1 deep FIFO uart) but I wanted to confirm
> with the serial gurus. Is there any serial setting I can apply here to enable the
> last remaining chars to be dumped out of uart tx buffer.

Hi Vineet,

You're correct in that this is not driver related, and that it's a
problem in the tty core, specifically in __tty_hangup().

The problem is actually worse with a really high speed tty (like over
Firewire) and on the receive end can amount to 60+K of dropped data.

The problem stems from the semantics of 'hangup': for one usage, it
means 'this end is done transmitting' and in the other usage, it means
'don't send me anymore data'. So for first meaning, receiving all the
data is important. In the second meaning, the receiver doesn't want data
anymore.

Unfortunately, there is almost no distinction in the tty core; it
implements the second meaning while providing interface for the first
meaning.

I'm meaning to address this eventually (because I'm working around this
now in TTY-over-Firewire -- its on the receive end so wouldn't be any
help in your situation), but don't have a plan on how to best fix this
yet.

Regards,
Peter Hurley






