From: Pascal JEAN <epsilonrt@gmail.com>
Subject: [PATCH 2/2] sc16is7xx: add reading CTS
Date: Thu, 28 Jul 2016 09:07:36 +0200
Message-ID: <45493b7e-ce61-8e1f-f0a9-cb5843f99291@gmail.com>
References: <1469653123-21867-1-git-send-email-epsilonrt@gmail.com>
 <1469653123-21867-2-git-send-email-epsilonrt@gmail.com>
 <20160727212844.GB7821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160727212844.GB7821@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Here are changelog for this patch.
Best Regards

Changelog:

sc16is7xx: add reading CTS

	This patch adds the possibility to read the actual
	status of the CTS input when RTS/CTS handshaking is
	not activated (for general purposes).


Signed-off-by: Pascal JEAN <epsilonrt@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3e65079..8833a18 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -818,10 +818,19 @@ static unsigned int sc16is7xx_tx_empty(struct
uart_port *port)

 static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
 {
-	/* DCD and DSR are not wired and CTS/RTS is handled automatically
-	 * so just indicate all inputs asserted
-	 */
-	return TIOCM_DSR | TIOCM_CAR | TIOCM_RI | TIOCM_CTS;
+	/* DCD, DSR and RI are not wired so just indicate asserted */
+	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_RI;
+
+	if (port->status & UPSTAT_CTS_ENABLE)
+		/* CTS handled automatically, indicates that it is always
+		 * asserted, this is required for proper management of
+		 * the upper layer
+		 */
+		mctrl |= TIOCM_CTS;
+	else {
+		/* CTS is not managed automatically, returns its actual state
+		 * the upper layer
+		 */
+		u8 msr = sc16is7xx_port_read(port, SC16IS7XX_MSR_REG);
+
+		mctrl |= (msr & SC16IS7XX_MSR_CTS_BIT) ? TIOCM_CTS : 0;
+	}
+	return mctrl;
 }

 static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int mctrl)
-- 
2.7.4
