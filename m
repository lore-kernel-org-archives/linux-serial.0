From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 16/22] tty: mxser: Use tty->closing for ASYNC_CLOSING
Date: Mon, 16 Jun 2014 09:17:13 -0400
Message-ID: <1402924639-5164-17-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

ASYNC_CLOSING is no longer used in the tty core; use tty->closing
as substitute.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/mxser.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 4c4a236..573bc00 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2255,10 +2255,8 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 					break;
 				iir &= MOXA_MUST_IIR_MASK;
 				tty = tty_port_tty_get(&port->port);
-				if (!tty ||
-						(port->port.flags & ASYNC_CLOSING) ||
-						!(port->port.flags &
-							ASYNC_INITIALIZED)) {
+				if (!tty || tty->closing ||
+				    !(port->port.flags & ASYNC_INITIALIZED)) {
 					status = inb(port->ioaddr + UART_LSR);
 					outb(0x27, port->ioaddr + UART_FCR);
 					inb(port->ioaddr + UART_MSR);
-- 
2.0.0
