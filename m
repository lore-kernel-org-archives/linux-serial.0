From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 7/9] tty: Document defunct ASYNC_SPLIT_TERMIOS flag in uapi header
Date: Wed,  5 Nov 2014 12:26:30 -0500
Message-ID: <1415208392-16189-8-git-send-email-peter@hurleysoftware.com>
References: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The last vestige of ASYNC_SPLIT_TERMIOS was removed by commit
'cris: Remove obsolete ASYNC_SPLIT_TERMIOS behavior'. Mark the flag
as defunct in the uapi header.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/uapi/linux/tty_flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 4e021e3..d2bc4ff 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -14,7 +14,7 @@
 				    * on the callout port */
 #define ASYNCB_FOURPORT		 1 /* Set OU1, OUT2 per AST Fourport settings */
 #define ASYNCB_SAK		 2 /* Secure Attention Key (Orange book) */
-#define ASYNCB_SPLIT_TERMIOS	 3 /* Separate termios for dialin/callout */
+#define ASYNCB_SPLIT_TERMIOS	 3 /* [x] Separate termios for dialin/callout */
 #define ASYNCB_SPD_HI		 4 /* Use 56000 instead of 38400 bps */
 #define ASYNCB_SPD_VHI		 5 /* Use 115200 instead of 38400 bps */
 #define ASYNCB_SKIP_TEST	 6 /* Skip UART test during autoconfiguration */
-- 
2.1.3
