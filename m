From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/2] serial: sirf: make uart register info static
Date: Tue,  7 Jun 2016 19:06:12 +0100
Message-ID: <1465322772-26125-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1465322772-26125-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465322772-26125-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@lists.codethink.co.uk
Cc: Barry Song <baohua@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The driver does not export the two structures that
define the uart register mappings outside of the
driver, so make them static to avoid the following
warnings:

drivers/tty/serial/sirfsoc_uart.h:124:30: warning: symbol 'sirfsoc_usp' was not declared. Should it be static?
drivers/tty/serial/sirfsoc_uart.h:190:30: warning: symbol 'sirfsoc_uart' was not declared. Should it be static?

Note, we don't move these into the driver .c file as this would
be a larger change. However they really should not belong in the
header file like this.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/sirfsoc_uart.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 43756bd..2242008 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -121,7 +121,8 @@ static u32 uart_usp_ff_empty_mask(struct uart_port *port)
 	empty_bit = ilog2(port->fifosize) + 1;
 	return (1 << empty_bit);
 }
-struct sirfsoc_uart_register sirfsoc_usp = {
+
+static struct sirfsoc_uart_register sirfsoc_usp = {
 	.uart_reg = {
 		.sirfsoc_mode1		= 0x0000,
 		.sirfsoc_mode2		= 0x0004,
@@ -187,7 +188,7 @@ struct sirfsoc_uart_register sirfsoc_usp = {
 	},
 };
 
-struct sirfsoc_uart_register sirfsoc_uart = {
+static struct sirfsoc_uart_register sirfsoc_uart = {
 	.uart_reg = {
 		.sirfsoc_line_ctrl	= 0x0040,
 		.sirfsoc_tx_rx_en	= 0x004c,
-- 
2.8.1
