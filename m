From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 02/75] Blackfin Serial Driver: fix bug - SIR driver stop
	receiving randomly
Date: Fri, 02 Jan 2009 13:40:22 +0000
Message-ID: <20090102134019.13472.27502.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60268 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754188AbZABNkH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:40:07 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Graf Yang <graf.yang@analog.com>

Bug description:
The IRDA receiver may can't receiving any more after processed some signals.

To duplicate this issue is put three IRDA devices together, one blackfin,
two none blackfin, they will detect each other. Let one none blackfin devices
irdaping the blackfin devices, when it stopped print out ping information,
it is the time that blackfin stoped receiving, the time is random.

The related register bit is OK, the other devices is sending data continuously.
But no interrupt come.

Fixing:
I tried Michael's suggestion that request the UARTx error interrupt, and reset
the IRDA when found FE error. This method helps much, but it can't completely
avoid stop.

Reset the IRDA before every time sending the data is more safe.

Signed-off-by: Graf Yang <graf.yang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/bfin_5xx.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)


diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index d63fad7..59a221f 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -73,6 +73,8 @@ static void bfin_serial_tx_chars(struct bfin_serial_port *uart);
 
 static void bfin_serial_mctrl_check(struct bfin_serial_port *uart);
 
+static void bfin_serial_reset_irda(struct uart_port *port);
+
 /*
  * interrupts are disabled on entry
  */
@@ -105,6 +107,14 @@ static void bfin_serial_stop_tx(struct uart_port *port)
 static void bfin_serial_start_tx(struct uart_port *port)
 {
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	struct tty_struct *tty = uart->port.info->port.tty;
+
+	/*
+	 * To avoid losting RX interrupt, we reset IR function
+	 * before sending data.
+	 */
+	if (tty->termios->c_line == N_IRDA)
+		bfin_serial_reset_irda(port);
 
 #ifdef CONFIG_SERIAL_BFIN_DMA
 	if (uart->tx_done)
@@ -890,6 +900,20 @@ static int bfin_kgdboc_port_startup(struct uart_port *port)
 }
 #endif
 
+static void bfin_serial_reset_irda(struct uart_port *port)
+{
+	int line = port->line;
+	unsigned short val;
+
+	val = UART_GET_GCTL(&bfin_serial_ports[line]);
+	val &= ~(IREN | RPOLC);
+	UART_PUT_GCTL(&bfin_serial_ports[line], val);
+	SSYNC();
+	val |= (IREN | RPOLC);
+	UART_PUT_GCTL(&bfin_serial_ports[line], val);
+	SSYNC();
+}
+
 static struct uart_ops bfin_serial_pops = {
 	.tx_empty	= bfin_serial_tx_empty,
 	.set_mctrl	= bfin_serial_set_mctrl,

