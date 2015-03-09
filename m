From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 -next 08/11] serial: earlycon: Skip parse_options() if empty string
Date: Mon,  9 Mar 2015 16:27:19 -0400
Message-ID: <1425932842-21812-9-git-send-email-peter@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Earlycon param strings of the form
   earlycon=<name>
are rejected from parse_options() with an error (which, in turn,
results in a NULL argument for the setup() method options parameter).

Only pass non-empty string to parse_options(); this will enable
handling actual parse errors differently than expected and allow
formats.

Acked-by: Rob Herring <robh@kernel.org>
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
2.3.1
