From: Jonas Danielsson <jonas@orbital-systems.com>
Subject: [PATCH] [PATCH] tty/serial: atmel: add new version check for usart
Date: Mon, 29 Jan 2018 12:39:15 +0100
Message-ID: <20180129113954.12011-1-jonas@orbital-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Jonas Danielsson <jonas@orbital-systems.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On our at91sam9260 based board the usart0 and usart1 ports report
their versions (ATMEL_US_VERSION) as 0x10302. This version is not
included in the current checks in the driver.

Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
---
 drivers/tty/serial/atmel_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index efa25611ca0c..ae9f1dcbf3fc 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1734,6 +1734,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 		switch (version) {
 		case 0x302:
 		case 0x10213:
+		case 0x10302:
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->has_frac_baudrate = true;
 			atmel_port->has_hw_timer = true;
-- 
2.14.1
