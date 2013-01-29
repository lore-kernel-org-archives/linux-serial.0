From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH V4 2/2] serial: rp2: New driver for Comtrol RocketPort 2
 cards
Date: Tue, 29 Jan 2013 16:14:54 +0000 (UTC)
Message-ID: <ke8shu$7on$1@ger.gmane.org>
References: <1ee681e19fb4ce83f2a133c35fe635ae@localhost>
 <cddfa2c3b23f14c35109a07544c6a2bf@localhost>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44484 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086Ab3A2QPM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jan 2013 11:15:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1U0DqJ-0000ks-4V
	for linux-serial@vger.kernel.org; Tue, 29 Jan 2013 17:15:27 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 29 Jan 2013 17:15:27 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 29 Jan 2013 17:15:27 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-17, Kevin Cernekee <cernekee@gmail.com> wrote:

> This driver supports the RocketPort EXPRESS and RocketPort INFINITY
> families of PCI/PCIe multiport serial adapters.  These adapters use a
> "RocketPort 2" ASIC that is not compatible with the original RocketPort
> driver (CONFIG_ROCKETPORT).

RTS/CTS receive flow control doesn't work: RTS is never de-asserted
when receive buffers fill up, and receive data is lost.

In order for receive flow control logic in the UART to kick in, you
have to stop reading data from the rx FIFO when you've got nowhere to
put it.  When the rx FIFO fills to 7/8, the UART will (if so
configured) de-assert RTS and/or send Xoff.  Fix is shown below:

> +static void rp2_rx_chars(struct rp2_uart_port *up)
> +{
> +	u16 bytes = readw(up->base + RP2_RX_FIFO_COUNT);
> +	struct tty_port *port = &up->port.state->port;

        if (bytes > port->tty->receive_room)
                bytes = port->tty->receive_room;

> +	for (; bytes != 0; bytes--) {
> +		u32 byte = readw(up->base + RP2_DATA_BYTE) | RP2_DUMMY_READ;
> +		char ch = byte & 0xff;

   [...]

This will allow both RTS and Xon/Xoff receive flow control to be
handled by the UART itself.

-- 
Grant Edwards               grant.b.edwards        Yow! YOU PICKED KARL
                                  at               MALDEN'S NOSE!!
                              gmail.com            

