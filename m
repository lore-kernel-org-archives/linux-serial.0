From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] earlycon: Revert log warnings
Date: Thu,  7 May 2015 14:19:21 -0400
Message-ID: <1431022761-20883-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Robert Schwebel <r.schwebel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Log warnings meant to help diagnose problems setting up earlycon
are reporting false positives for 'console='. Revert to the
previous behavior which reported nothing.

Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 9834afc..6e39b14 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -205,13 +205,8 @@ static int __init param_setup_earlycon(char *buf)
 		return 0;
 
 	err = setup_earlycon(buf);
-	if (err == -ENOENT) {
-		pr_warn("no match for %s\n", buf);
-		err = 0;
-	} else if (err == -EALREADY) {
-		pr_warn("already registered\n");
-		err = 0;
-	}
+	if (err == -ENOENT || err == -EALREADY)
+		return 0;
 	return err;
 }
 early_param("earlycon", param_setup_earlycon);
-- 
2.4.0
