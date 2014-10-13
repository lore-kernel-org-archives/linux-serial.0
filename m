From: Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Handling of automatic flow control in UART drivers
Date: Mon, 13 Oct 2014 16:48:39 +0200
Message-ID: <20141013144831.GA8409@jtlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.153]:16239 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752869AbaJMOuC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2014 10:50:02 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: =?iso-8859-1?Q?Gei=DFler?= Andreas <Andreas.Geissler@men.de>, Johannes Thumshirn <Johannes.Thumshirn@men.de>

Hi,

We have problem with automatic flow control (i.e. auto RTS/CTS handshaking) in
our uart driver (men_z135_uart.c). It's probably less a technical but a problem
with me understanding the API.

I active the hardware auto flow control feature on the CRTSCTS flag in my
uart_ops->set_termios() function. But then the RTS flag is set on every call of
the uart_ops->set_mctrl() function, this seems to confuse the hardware. Is there
a way to tell the tty layer that flow control is handled solely by hardware?
I.e. is there a way of telling serial core to leave out the calls to
uart_set_mctrl()/uart_clear_mctrl() in uart_throttle()/uart_unthrottle(), or is
setting UPF_FLOW_HARD and then implementing a dummy port->ops->{un}throttle()
the correct way?

Are there any drivers that use a hardware's automatic flow control feature I can
use as an example? A fast grep on AFE reveals some spots, but I can't really
find a difference to my implementation.

Thanks in advance,
	Johannes
