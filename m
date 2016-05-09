From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/7] tty: ipwireless, cleanup TIOCGSERIAL
Date: Mon,  9 May 2016 09:11:53 +0200
Message-ID: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>
List-Id: linux-serial@vger.kernel.org

In ipwireless_get_serial_info, struct serial_struct is memset to 0 and
then some members set to 0 explicitly.

Remove the latter as it is obviously superfluous.

And remove the retinfo check against NULL. copy_to_user will take care
of that.

Part of hub6 cleanup series.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
---
 drivers/tty/ipwireless/tty.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 345cebb07ae7..2685d59d2724 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -252,20 +252,11 @@ static int ipwireless_get_serial_info(struct ipw_tty *tty,
 {
 	struct serial_struct tmp;
 
-	if (!retinfo)
-		return (-EFAULT);
-
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = PORT_UNKNOWN;
 	tmp.line = tty->index;
-	tmp.port = 0;
-	tmp.irq = 0;
-	tmp.flags = 0;
 	tmp.baud_base = 115200;
-	tmp.close_delay = 0;
-	tmp.closing_wait = 0;
-	tmp.custom_divisor = 0;
-	tmp.hub6 = 0;
+
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;
 
-- 
2.8.2
