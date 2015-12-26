From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v5 6/8] tty: xuartps: Keep lock for whole ISR
Date: Sat, 26 Dec 2015 02:43:54 -0800
Message-ID: <1451126636-13699-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1451126636-13699-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1451126636-13699-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The RX path in the interrupt handler released a lock unnecessarily.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6ffd3bbe3e18..ab3995d00973 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -265,9 +265,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
 					data, status);
 		}
-		spin_unlock(&port->lock);
 		tty_flip_buffer_push(&port->state->port);
-		spin_lock(&port->lock);
 	}
 
 	/* Dispatch an appropriate handler */
-- 
2.6.3.3.g9bb996a
