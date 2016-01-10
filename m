From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 2/3] isdn: Remove ASYNC_CLOSING
Date: Sun, 10 Jan 2016 14:51:39 -0800
Message-ID: <1452466300-4372-3-git-send-email-peter@hurleysoftware.com>
References: <1449956976-4784-1-git-send-email-peter@hurleysoftware.com>
 <1452466300-4372-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452466300-4372-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Karsten Keil <isdn@linux-pingi.de>
List-Id: linux-serial@vger.kernel.org

The tty core no longer provides ASYNC_CLOSING. Use private flag for
same purpose, which is to disable AT-emulator output (why this is
necessary is not clear).

Cc: Karsten Keil <isdn@linux-pingi.de>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/isdn/i4l/isdn_tty.c | 12 ++++++------
 include/linux/isdn.h        |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 1a53b93..1dad65d 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1572,7 +1572,7 @@ isdn_tty_close(struct tty_struct *tty, struct file *filp)
 #endif
 		return;
 	}
-	port->flags |= ASYNC_CLOSING;
+	info->closing = 1;
 
 	tty->closing = 1;
 	/*
@@ -1603,6 +1603,7 @@ isdn_tty_close(struct tty_struct *tty, struct file *filp)
 	info->ncarrier = 0;
 
 	tty_port_close_end(port, tty);
+	info->closing = 0;
 #ifdef ISDN_DEBUG_MODEM_OPEN
 	printk(KERN_DEBUG "isdn_tty_close normal exit\n");
 #endif
@@ -2236,7 +2237,7 @@ isdn_tty_at_cout(char *msg, modem_info *info)
 	l = strlen(msg);
 
 	spin_lock_irqsave(&info->readlock, flags);
-	if (port->flags & ASYNC_CLOSING) {
+	if (info->closing) {
 		spin_unlock_irqrestore(&info->readlock, flags);
 		return;
 	}
@@ -2386,13 +2387,12 @@ isdn_tty_modem_result(int code, modem_info *info)
 	case RESULT_NO_CARRIER:
 #ifdef ISDN_DEBUG_MODEM_HUP
 		printk(KERN_DEBUG "modem_result: NO CARRIER %d %d\n",
-		       (info->port.flags & ASYNC_CLOSING),
-		       (!info->port.tty));
+		       info->closing, !info->port.tty);
 #endif
 		m->mdmreg[REG_RINGCNT] = 0;
 		del_timer(&info->nc_timer);
 		info->ncarrier = 0;
-		if ((info->port.flags & ASYNC_CLOSING) || (!info->port.tty))
+		if (info->closing || !info->port.tty)
 			return;
 
 #ifdef CONFIG_ISDN_AUDIO
@@ -2525,7 +2525,7 @@ isdn_tty_modem_result(int code, modem_info *info)
 		}
 	}
 	if (code == RESULT_NO_CARRIER) {
-		if ((info->port.flags & ASYNC_CLOSING) || (!info->port.tty))
+		if (info->closing || (!info->port.tty))
 			return;
 
 		if (info->port.flags & ASYNC_CHECK_CD)
diff --git a/include/linux/isdn.h b/include/linux/isdn.h
index 1e9a0f2..df97c84 100644
--- a/include/linux/isdn.h
+++ b/include/linux/isdn.h
@@ -319,6 +319,7 @@ typedef struct modem_info {
   int                   online;          /* 1 = B-Channel is up, drop data */
 					 /* 2 = B-Channel is up, deliver d.*/
   int                   dialing;         /* Dial in progress or ATA        */
+  int                   closing;
   int                   rcvsched;        /* Receive needs schedule         */
   int                   isdn_driver;	 /* Index to isdn-driver           */
   int                   isdn_channel;    /* Index to isdn-channel          */
-- 
2.7.0
