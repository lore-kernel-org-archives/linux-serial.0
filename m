From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH] drivers/tty: add error handling for pcmcia_loop_config
Date: Tue, 12 Jun 2018 12:36:25 +0800
Message-ID: <1528778187-41182-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When pcmcia_loop_config fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_loop_config.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 9963a76..c8186a0 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -638,8 +638,10 @@ static int serial_config(struct pcmcia_device *link)
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc == 0) &&
 	    ((link->func_id == CISTPL_FUNCID_MULTI) ||
-	     (link->func_id == CISTPL_FUNCID_SERIAL)))
-		pcmcia_loop_config(link, serial_check_for_multi, info);
+	     (link->func_id == CISTPL_FUNCID_SERIAL))) {
+		if (pcmcia_loop_config(link, serial_check_for_multi, info))
+			goto failed;
+	}
 
 	/*
 	 * Apply any multi-port quirk.
-- 
2.7.4
