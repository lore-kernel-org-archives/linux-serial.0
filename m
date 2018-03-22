From: Gabriel Matni <gabriel.matni@exfo.com>
Subject: [PATCH v4] serial: mvebu-uart: fix tx lost characters
Date: Thu, 22 Mar 2018 19:15:12 +0000
Message-ID: <3B588D51285A4A4D8D39C94212E0782627AA23@SPQCMBX02.exfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, =?iso-8859-1?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Gabriel Matni <gabriel.matni@exfo.com>

Fixes missing characters on kernel console at low baud rates (i.e.9600).
The driver should poll TX_RDY or TX_FIFO_EMP instead of TX_EMP to ensure
that the transmitter holding register (THR) is ready to receive a new byte.

TX_EMP tells us when it is possible to send a break sequence via
SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
empty, it does not guarantee that a new byte can be written just yet.

Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700 serial port")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> 
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>  
Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com> 
---
Changes since v3:
- mail the patch in a clean email
- fix the subject line accordingly (no Re:)

Changes since v2:
- use one line for the "Fixes" entry
- removed trailing space between Signed-off-by entry and ---
- start using versioning, previous fixes in v1

Changes since v1:
- patch was corrupt, could not be applied
- fixed line indent
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index a100e98259d7..f0df0640208e 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
 	u32 val;
 
 	readl_poll_timeout_atomic(port->membase + UART_STAT, val,
-				  (val & STAT_TX_EMP), 1, 10000);
+				  (val & STAT_TX_RDY(port)), 1, 10000);
 }
 
 static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
-- 
2.7.4
