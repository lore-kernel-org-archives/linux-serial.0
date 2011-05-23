From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 31/48] TTY: serial_core, remove superfluous set_task_state
Date: Mon, 23 May 2011 12:10:37 -0700
Message-ID: <1306177854-18172-31-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42080 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932634Ab1EWTLe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:34 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

msleep* is guaranteed to return with TASK_RUNNING task state. And
since there is no other set_task_state in the paths of
uart_wait_until_sent, we need not to set_task_state to TASK_RUNNING.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 69d0000..db7912c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1414,7 +1414,6 @@ static void __uart_wait_until_sent(struct uart_port *port, int timeout)
 		if (time_after(jiffies, expire))
 			break;
 	}
-	set_current_state(TASK_RUNNING); /* might not be needed */
 }
 
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
-- 
1.7.4.2

