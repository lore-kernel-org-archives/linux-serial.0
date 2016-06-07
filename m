From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] serial: sirf: make fifo functions static
Date: Tue,  7 Jun 2016 19:06:11 +0100
Message-ID: <1465322772-26125-1-git-send-email-ben.dooks@codethink.co.uk>
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
To: linux-kernel@lists.codethink.co.uk
Cc: Barry Song <baohua@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The fifo mask functions should be static as they are not
used outside of the driver. Fix the following warnings by
making them static:

drivers/tty/serial/sirfsoc_uart.h:109:5: warning: symbol 'uart_usp_ff_full_mask' was not declared. Should it be static?
drivers/tty/serial/sirfsoc_uart.h:117:5: warning: symbol 'uart_usp_ff_empty_mask' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/sirfsoc_uart.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index c3a885b..43756bd 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -106,7 +106,7 @@ struct sirfsoc_uart_register {
 	enum sirfsoc_uart_type uart_type;
 };
 
-u32 uart_usp_ff_full_mask(struct uart_port *port)
+static u32 uart_usp_ff_full_mask(struct uart_port *port)
 {
 	u32 full_bit;
 
@@ -114,7 +114,7 @@ u32 uart_usp_ff_full_mask(struct uart_port *port)
 	return (1 << full_bit);
 }
 
-u32 uart_usp_ff_empty_mask(struct uart_port *port)
+static u32 uart_usp_ff_empty_mask(struct uart_port *port)
 {
 	u32 empty_bit;
 
-- 
2.8.1
