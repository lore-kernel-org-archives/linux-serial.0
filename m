From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH v2 05/10] serial: sh-sci: fix condition test to set SCBRR
Date: Fri, 16 Nov 2012 10:52:22 +0900
Message-ID: <50A59C56.1080001@renesas.com>
References: <509A0658.1010503@renesas.com> <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com> <50A59B9B.2010501@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <50A59B9B.2010501@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, takashi.yoshii.zj@renesas.com, alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: rjw@sisk.pl, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

SCBRR == 0 is valid value (divide by 1).

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e65e546..ffeca65 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1853,7 +1853,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	dev_dbg(port->dev, "%s: SMR %x, t %x, SCSCR %x\n", __func__, smr_val, t,
 		s->cfg->scscr);
 
-	if (t > 0) {
+	if (t >= 0) {
 		if (t >= 256) {
 			serial_port_out(port, SCSMR, (serial_port_in(port, SCSMR) & ~3) | 1);
 			t >>= 2;
-- 
1.7.12.4

