From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH] serial_core: Change UART PM state to OFF on failure
Date: Fri,  6 May 2016 15:16:23 +0530
Message-ID: <1462527983-32108-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

uart_change_pm is used to turn on the UART controller resources and
change UART's PM status. On failure to allocate pages the controller
be left in ON state. This will change the state to OFF on failure.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
 drivers/tty/serial/serial_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 62fe368..58af2e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -156,9 +156,10 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (!state->xmit.buf) {
 		/* This is protected by the per port mutex */
 		page = get_zeroed_page(GFP_KERNEL);
-		if (!page)
+		if (!page) {
+			uart_change_pm(state, UART_PM_STATE_OFF);
 			return -ENOMEM;
-
+		}
 		state->xmit.buf = (unsigned char *) page;
 		uart_circ_clear(&state->xmit);
 	}
-- 
1.8.2.1
