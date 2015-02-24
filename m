From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 11/13] serial: earlycon: Refactor earlycon registration
Date: Tue, 24 Feb 2015 11:37:08 -0500
Message-ID: <1424795830-31223-12-git-send-email-peter@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Separate earlycon matching from registration; add register_earlycon
which initializes and registers the matched earlycon.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 025ea01..9fb76b6 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -96,27 +96,13 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	return 0;
 }
 
-int __init setup_earlycon(char *buf, const char *match,
-			  int (*setup)(struct earlycon_device *, const char *))
+
+static int __init
+register_earlycon(char *buf, int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
-	size_t len;
 	struct uart_port *port = &early_console_dev.port;
 
-	if (!buf || !match || !setup)
-		return 0;
-
-	len = strlen(match);
-	if (strncmp(buf, match, len))
-		return 0;
-
-	if (buf[len]) {
-		if (buf[len] != ',')
-			return 0;
-		buf += len + 1;
-	} else
-		buf = NULL;
-
 	/* On parsing error, pass the options buf to the setup function */
 	if (buf && !parse_options(&early_console_dev, buf))
 		buf = NULL;
@@ -136,6 +122,28 @@ int __init setup_earlycon(char *buf, const char *match,
 	return 0;
 }
 
+int __init setup_earlycon(char *buf, const char *match,
+			  int (*setup)(struct earlycon_device *, const char *))
+{
+	size_t len;
+
+	if (!buf || !match || !setup)
+		return 0;
+
+	len = strlen(match);
+	if (strncmp(buf, match, len))
+		return 0;
+
+	if (buf[len]) {
+		if (buf[len] != ',')
+			return 0;
+		buf += len + 1;
+	} else
+		buf = NULL;
+
+	return register_earlycon(buf, setup);
+}
+
 int __init of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
-- 
2.3.0
