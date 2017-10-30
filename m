From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] tty: amba-pl011: Report AUTOCTS capability to framework
Date: Mon, 30 Oct 2017 14:03:06 +0100
Message-ID: <1509368586-26662-1-git-send-email-stefan.wahren@i2se.com>
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
To: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: loic.poulain@gmail.com, Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.org>

The PL011 has full hardware RTS/CTS support which is enabled by
the driver when flow control is requested. However, it doesn't
notify the UART framework of the fact, causing the software CTS
support to be enabled at the same time.

Software CTS triggers the sending of another batch of characters
when CTS becomes asserted. The pl011 interrupt handler processes
the CTIS bit before TXIS, which can cause some characters to be
sent between the time that the TXIS bit first becomes asserted
and the time it is handled by a call to px011_tx_chars. This
would be fine were it not for the optimisation in pl011_tx_char
that assumes the FIFO is half-empty if called from the interrupt
handler and skips the checking of the FIFO status register before
sending each character, leading to data loss if the FIFO is more
than half-full.

Prevent the data loss and improve efficiency by indicating the
AUTOCTS support.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/tty/serial/amba-pl011.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 111e6a9..00019b8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2029,9 +2029,11 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 
 		old_cr |= UART011_CR_CTSEN;
 		uap->autorts = true;
+		port->status |= UPSTAT_AUTOCTS;
 	} else {
 		old_cr &= ~(UART011_CR_CTSEN | UART011_CR_RTSEN);
 		uap->autorts = false;
+		port->status &= ~UPSTAT_AUTOCTS;
 	}
 
 	if (uap->vendor->oversampling) {
-- 
2.7.4
