From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] serial: sirf: make register info static
Date: Wed,  9 Oct 2019 14:53:56 +0100
Message-ID: <20191009135356.11180-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Barry Song <baohua@kernel.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The sirfsoc_usp and sirfsoc_uart objects are not
used outside of the drivers/tty/serial/sirfsoc_uart.o
so make them static. Fixes following sparse warnings:

drivers/tty/serial/sirfsoc_uart.h:123:30: warning: symbol 'sirfsoc_usp' was not declared. Should it be static?
drivers/tty/serial/sirfsoc_uart.h:189:30: warning: symbol 'sirfsoc_uart' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/sirfsoc_uart.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 004ca684d3ae..637b09d3fe79 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -120,7 +120,8 @@ static u32 uart_usp_ff_empty_mask(struct uart_port *port)
 	empty_bit = ilog2(port->fifosize) + 1;
 	return (1 << empty_bit);
 }
-struct sirfsoc_uart_register sirfsoc_usp = {
+
+static struct sirfsoc_uart_register sirfsoc_usp = {
 	.uart_reg = {
 		.sirfsoc_mode1		= 0x0000,
 		.sirfsoc_mode2		= 0x0004,
@@ -186,7 +187,7 @@ struct sirfsoc_uart_register sirfsoc_usp = {
 	},
 };
 
-struct sirfsoc_uart_register sirfsoc_uart = {
+static struct sirfsoc_uart_register sirfsoc_uart = {
 	.uart_reg = {
 		.sirfsoc_line_ctrl	= 0x0040,
 		.sirfsoc_tx_rx_en	= 0x004c,
-- 
2.23.0
