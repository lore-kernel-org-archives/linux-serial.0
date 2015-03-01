From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 04/13] serial: core: Fix kernel doc for uart_console_write()
Date: Sun,  1 Mar 2015 11:05:49 -0500
Message-ID: <1425225958-17908-5-git-send-email-peter@hurleysoftware.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

'/**' is required to start a kernel-doc comment block.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3f823c26..373cfde 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1766,7 +1766,7 @@ static const struct file_operations uart_proc_fops = {
 #endif
 
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
-/*
+/**
  *	uart_console_write - write a console message to a serial port
  *	@port: the port to write the message
  *	@s: array of characters
-- 
2.3.0
