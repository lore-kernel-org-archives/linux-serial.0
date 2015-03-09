From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 -next 02/11] serial: core: Fix kernel doc for uart_console_write()
Date: Mon,  9 Mar 2015 16:27:13 -0400
Message-ID: <1425932842-21812-3-git-send-email-peter@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

'/**' is required to start a kernel-doc comment block.

Acked-by: Rob Herring <robh@kernel.org>
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
2.3.1
