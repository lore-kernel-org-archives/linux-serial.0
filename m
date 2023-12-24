Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401FC8C7
	for <linux-serial@vger.kernel.org>; Sun, 24 Dec 2023 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanmierlo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanmierlo.com
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
	(authenticated user m.brock@vanmierlo.com)
	by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA
	for linux-serial@vger.kernel.org;
	Sun, 24 Dec 2023 17:39:08 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Dec 2023 17:39:08 +0100
From: m.brock@vanmierlo.com
To: Linux Serial <linux-serial@vger.kernel.org>
Subject: Poor documentation of SER_RS485_RTS_ON_SEND and
 SER_RS485_RTS_AFTER_SEND
Message-ID: <511f7dcbc6b6c64ffaa246a0148f0d75@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have some trouble finding out the meaning of SER_RS485_RTS_ON_SEND and
SER_RS485_RTS_AFTER_SEND. The documentation says:

linux/serial.h
==============
> * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
> * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.

Practically all UART chips have a -RTS, /RTS pin or RTSn pin and no RTS 
pin.
And what is the meaning of "Logical level" here? Is it the same as Logic 
Level?

Should I conclude that setting the SER_RS485_RTS_ON_SEND flag should 
result in
the logic level on the /RTS pin being high (> 0V) during transmission?
And similarly that setting the SER_RS485_RTS_AFTER_SEND flag should 
result in
the logic level on the /RTS pin being high after transmission?

rs485.yaml
==========
>   rs485-rts-active-high:
>     description: drive RTS high when sending (this is the default).
>     $ref: /schemas/types.yaml#/definitions/flag
> 
>   rs485-rts-active-low:
>     description: drive RTS low when sending (default is high).
>     $ref: /schemas/types.yaml#/definitions/flag

Can I assume that RTS usually means the /RTS pin on the UART chip here.

Looking at the implemented drivers does not make things better.

Some drivers think that when the SER_RS485_RTS_ON_SEND flag is set they 
should
set the RTS bit in E.g. the MCR register when starting a transmission, 
which
results in the /RTS pin going low on E.g. a genuine 8250.

8250_port.c
===========
> /**
>  * serial8250_em485_start_tx() - generic ->rs485_start_tx() callback
>  * @up: uart 8250 port
>  *
>  * Generic callback usable by 8250 uart drivers to start rs485 
> transmission.
>  * Assumes that setting the RTS bit in the MCR register means RTS is 
> high.

Wow, that's an odd assumption for a generic 8250/16x50 driver!

>  * (Some chips use inverse semantics.)  [...]
>  */
> void serial8250_em485_start_tx(struct uart_8250_port *up)
> {
> 	unsigned char mcr = serial8250_in_MCR(up);
> 
> 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
> 		serial8250_stop_rx(&up->port);
> 
> 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
> 		mcr |= UART_MCR_RTS;
> 	else
> 		mcr &= ~UART_MCR_RTS;
> 	serial8250_out_MCR(up, mcr);
> }

The next one behaves the same, but makes a different assumption:

8250_omap.c
===========
> static int omap8250_rs485_config(struct uart_port *port,
> 				 struct ktermios *termios,
> 				 struct serial_rs485 *rs485)
> {
> 	[...]
> 	/*
> 	 * Retain same polarity semantics as RS485 software emulation,
> 	 * i.e. SER_RS485_RTS_ON_SEND means driving RTS low on send.

Shouldn't SER_RS485_RTS_ON_SEND mean driving RTS high on send?

> 	 */
> 	if (rs485->flags & SER_RS485_RTS_ON_SEND)
> 		priv->mdr3 &= ~UART_OMAP_MDR3_DIR_POL;
> 	else
> 		priv->mdr3 |= UART_OMAP_MDR3_DIR_POL;
> 
> 	serial_out(up, UART_OMAP_MDR3, priv->mdr3);

Others believe that they should clear the RTS bit in MCR for
SER_RS485_RTS_ON_SEND when starting a transmission, resulting in the 
/RTS
pin going high.

8250_bcm2835aux.c
=================
> static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
> {
> 	[...]
> 	/*
> 	 * On the bcm2835aux, the MCR register contains no other
> 	 * flags besides RTS.  So no need for a read-modify-write.
> 	 */
> 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
> 		serial8250_out_MCR(up, 0);
> 	else
> 		serial8250_out_MCR(up, UART_MCR_RTS);
> }

Same here:

8250_pci.c
==========
> static int pci_fintek_rs485_config(struct uart_port *port, struct 
> ktermios *termios,
> 			       struct serial_rs485 *rs485)
> {
> 		[...]
> 		if (rs485->flags & SER_RS485_RTS_ON_SEND) {
> 			/* RTS driving high on TX */
> 			setting &= ~FINTEK_RTS_INVERT;
> 		} else {
> 			/* RTS driving low on TX */
> 			setting |= FINTEK_RTS_INVERT;
> 		}

Can the list shed some light on this and reach a consensus here?

Happy Holidays,
Maarten

