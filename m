From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 09/13] serial: earlycon: Ignore parse_options() error code
Date: Sun,  1 Mar 2015 11:05:54 -0500
Message-ID: <1425225958-17908-10-git-send-email-peter@hurleysoftware.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Because setup_earlycon() continues to attempt console registration
if an error occurred parsing the option string, the actual value of
the error code from parse_options() is ignored.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 0480c8f..da5e8c8 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -114,9 +114,8 @@ int __init setup_earlycon(char *buf, const char *match,
 
 	buf += len + 1;
 
-	err = parse_options(&early_console_dev, buf);
 	/* On parsing error, pass the options buf to the setup function */
-	if (!err)
+	if (!parse_options(&early_console_dev, buf))
 		buf = NULL;
 
 	port->uartclk = BASE_BAUD * 16;
-- 
2.3.0
