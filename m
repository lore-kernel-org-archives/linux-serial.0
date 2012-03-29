From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] tty/serial: atmel_serial: fix RS485 half-duplex problem
Date: Thu, 29 Mar 2012 15:40:05 +0200
Message-ID: <1333028405-10051-1-git-send-email-nicolas.ferre@atmel.com>
References: <20120327202628.GB15798@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:24722 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab2C2Nkw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 09:40:52 -0400
In-Reply-To: <20120327202628.GB15798@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Gabe.Siftar@getingeusa.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, plagnioj@jcrosoft.com, linux@maxim.org.za, claudio@evidence.eu.com, br@pwrnet.de, Nicolas Ferre <nicolas.ferre@atmel.com>

From: "Siftar, Gabe" <Gabe.Siftar@getingeusa.com>

On our custom board, we are using RS485 in half-duplex mode on an AT91SAM9G45.
SER_RS485_RX_DURING_TX is not set as we do not want to receive the data we
transmit (our transceiver will receive transmitted data).
Although the current driver attempts to disable and enable the receiver at the
appropriate points, incoming data is still loaded into the receive register
causing our code to receive the very last byte that was sent once the receiver
is enabled.

I ran this by Atmel support and they wrote: "The issue comes from the fact
that you disable the PDC/DMA Reception and not the USART Reception channel. In
your case, the[n] you will still receive data into the USART_RHR register, and
maybe you [h]ave the overrun flag set. So please disable the USART reception
channel."

The following patch should force the driver to enable/disable the receiver via
RXEN/RXDIS fields of the USART control register. It fixed the issue I was
having.

Signed-off-by: Gabe Siftar <gabe.siftar@getingeusa.com>
[nicolas.ferre@atmel.com: slightly modify commit message]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Greg,

Here is an updated version of the patch that you received from Gabe. I have
removed a superfluous tab in empty line, remove commit message non needed parts
and added my "Signed-off-by" line.

Feel free to queue this version for 3.4-rc.

Thanks, best regards,
  Nicolas

 drivers/tty/serial/atmel_serial.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 10605ec..bc3cece 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -389,6 +389,8 @@ static void atmel_start_rx(struct uart_port *port)
 {
 	UART_PUT_CR(port, ATMEL_US_RSTSTA);  /* reset status and receiver */
 
+	UART_PUT_CR(port, ATMEL_US_RXEN);
+
 	if (atmel_use_dma_rx(port)) {
 		/* enable PDC controller */
 		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
@@ -404,6 +406,8 @@ static void atmel_start_rx(struct uart_port *port)
  */
 static void atmel_stop_rx(struct uart_port *port)
 {
+	UART_PUT_CR(port, ATMEL_US_RXDIS);
+
 	if (atmel_use_dma_rx(port)) {
 		/* disable PDC receive */
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTDIS);
-- 
1.7.9.4

