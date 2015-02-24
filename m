From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 10/13] serial: earlycon: Allow earlycon params with name only
Date: Tue, 24 Feb 2015 11:37:07 -0500
Message-ID: <1424795830-31223-11-git-send-email-peter@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
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
