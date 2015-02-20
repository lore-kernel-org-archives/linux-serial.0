From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 7/7 linux-next] serial: core: replace current->state by __set_current_state()
Date: Fri, 20 Feb 2015 19:12:57 +0100
Message-ID: <1424455977-21903-7-git-send-email-fabf@skynet.be>
References: <1424455977-21903-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424455977-21903-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use helper functions to access current->state.
Direct assignments are prone to races and therefore buggy.

Thanks to Peter Zijlstra for the exact definition of the problem.

Suggested-By: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/tty/serial/serial_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6a1055a..63d2947 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1118,8 +1118,7 @@ uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 
 		cprev = cnow;
 	}
-
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->delta_msr_wait, &wait);
 
 	return ret;
-- 
2.1.0
