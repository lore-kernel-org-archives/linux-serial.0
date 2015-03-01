From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 10/13] serial: earlycon: Allow earlycon params with name only
Date: Sun,  1 Mar 2015 11:05:55 -0500
Message-ID: <1425225958-17908-11-git-send-email-peter@hurleysoftware.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Allow earlycon param strings of the form
   earlycon=<name>

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index da5e8c8..025ea01 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -109,13 +109,16 @@ int __init setup_earlycon(char *buf, const char *match,
 	len = strlen(match);
 	if (strncmp(buf, match, len))
 		return 0;
-	if (buf[len] && (buf[len] != ','))
-		return 0;
 
-	buf += len + 1;
+	if (buf[len]) {
+		if (buf[len] != ',')
+			return 0;
+		buf += len + 1;
+	} else
+		buf = NULL;
 
 	/* On parsing error, pass the options buf to the setup function */
-	if (!parse_options(&early_console_dev, buf))
+	if (buf && !parse_options(&early_console_dev, buf))
 		buf = NULL;
 
 	port->uartclk = BASE_BAUD * 16;
-- 
2.3.0
