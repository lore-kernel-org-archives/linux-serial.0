From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 1/4] serial: xuartps: Fix termios issue for enabling odd parity
Date: Mon, 17 Aug 2015 09:22:31 +0200
Message-ID: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
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
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Anirudha Sarangi <anirudha.sarangi@xilinx.com>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>

Existing set_termios does not handle the option for enabling
odd parity. This patch fixes it.

Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 009e0dbc12d2..a3020344ac9d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -723,7 +723,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	else
 		cval |= CDNS_UART_MR_STOPMODE_1_BIT; /* 1 STOP bit */
 
-	if (termios->c_cflag & PARENB) {
+	if ((termios->c_cflag & PARENB) || (termios->c_cflag & PARODD)) {
 		/* Mark or Space parity */
 		if (termios->c_cflag & CMSPAR) {
 			if (termios->c_cflag & PARODD)
-- 
2.3.5
