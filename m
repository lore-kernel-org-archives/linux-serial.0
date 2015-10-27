From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 04/15] serial/fsl_lpuart: Deinline lpuart_transmit_buffer, save 176 bytes
Date: Tue, 27 Oct 2015 18:46:36 +0100
Message-ID: <1445968007-12616-5-git-send-email-dvlasenk@redhat.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 172 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 08ce76f..ac26303 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -527,7 +527,7 @@ static inline void lpuart_prepare_rx(struct lpuart_port *sport)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
+static void lpuart_transmit_buffer(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
 
-- 
1.8.1.4
