From: "Siftar, Gabe" <Gabe.Siftar@getingeusa.com>
Subject: [PATCH] atmel-serial: fix RS485 half-duplex problem
Date: Tue, 27 Mar 2012 13:43:39 -0400
Message-ID: <6FF0F449D45DEE479E93D93A0C07A8BD025E8F0631@USROCEX01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from thb-mta-11-tx.emailfiltering.com ([194.116.199.146]:39813 "EHLO
	thb-mta-11.emailfiltering.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754192Ab2C0Ru2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Mar 2012 13:50:28 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Claudio Scordino <claudio@evidence.eu.com>, Bernhard Roth <br@pwrnet.de>

On our custom board, we are using RS485 in half-duplex mode on an AT91SAM9G45. 
SER_RS485_RX_DURING_TX is not set as we do not want to receive the data we 
transmit (our transceiver will receive transmitted data).  Although the current 
driver attempts to disable and enable the receiver at the appropriate points, 
incoming data is still loaded into the receive register causing our code to 
receive the very last byte that was sent once the receiver is enabled.
 
I ran this by Atmel support and they wrote:  "The issue comes from the fact 
that you disable the PDC/DMA Reception and not the USART Reception channel.  In 
your case, the[n] you will still receive data into the USART_RHR register, and 
maybe you [h]ave the overun flag set.  So please disable the USART reception 
channel."
  
The following patch should force the driver to enable/disable the receiver via 
RXEN/RXDIS fields of the USART control register.  It fixed the issue I was 
having - perhaps others will find it useful as well.

Signed-off-by: Gabe Siftar <gabe.siftar@getingeusa.com>

Index: linux-3.3/drivers/tty/serial/atmel_serial.c
===================================================================
--- linux-3.3.orig/drivers/tty/serial/atmel_serial.c
+++ linux-3.3/drivers/tty/serial/atmel_serial.c
@@ -395,6 +395,8 @@
 {
 	UART_PUT_CR(port, ATMEL_US_RSTSTA);  /* reset status and receiver */
 
+	UART_PUT_CR(port, ATMEL_US_RXEN);
+
 	if (atmel_use_dma_rx(port)) {
 		/* enable PDC controller */
 		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
@@ -410,6 +412,8 @@
  */
 static void atmel_stop_rx(struct uart_port *port)
 {
+	UART_PUT_CR(port, ATMEL_US_RXDIS);
+	
 	if (atmel_use_dma_rx(port)) {
 		/* disable PDC receive */
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTDIS);

This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to which they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system. If you are not the intended recipient you are notified that disclosing, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited.