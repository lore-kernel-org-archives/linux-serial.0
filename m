From: Ed Spiridonov <edo.rus@gmail.com>
Subject: [PATCH] serial: pl011: add mark/space parity support
Date: Fri,  4 Mar 2016 08:11:53 +0300
Message-ID: <1457068313-16092-1-git-send-email-edo.rus@gmail.com>
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
To: linux@arm.linux.org.uk
Cc: Ed Spiridonov <edo.rus@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

PL011 UART has hardware mark/space parity ability, this trivial patch adds support for it.
Tested on Raspberry Pi v1, v2 (BCM2835 and BCM2836)

Signed-off-by: Ed Spiridonov <edo.rus@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..9de674a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1947,6 +1947,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		lcr_h |= UART01x_LCRH_PEN;
 		if (!(termios->c_cflag & PARODD))
 			lcr_h |= UART01x_LCRH_EPS;
+		if (termios->c_cflag & CMSPAR)
+			lcr_h |= UART011_LCRH_SPS;
 	}
 	if (uap->fifosize > 1)
 		lcr_h |= UART01x_LCRH_FEN;
-- 
2.7.0
