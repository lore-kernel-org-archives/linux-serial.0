From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/68] TTY: serial, simplify ASYNC_USR_MASK
Date: Mon,  5 Mar 2012 14:51:55 +0100
Message-ID: <1330955575-26641-9-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-serial@vger.kernel.org

By using ASYNC_SPD_MASK instead of the single speed bits.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/serial.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial.h b/include/linux/serial.h
index 3d86517..441980e 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -152,8 +152,8 @@ struct serial_uart_config {
 #define ASYNC_AUTOPROBE		(1U << ASYNCB_AUTOPROBE)
 
 #define ASYNC_FLAGS		((1U << (ASYNCB_LAST_USER + 1)) - 1)
-#define ASYNC_USR_MASK		(ASYNC_SPD_HI|ASYNC_SPD_VHI| \
-		ASYNC_CALLOUT_NOHUP|ASYNC_SPD_SHI|ASYNC_LOW_LATENCY)
+#define ASYNC_USR_MASK		(ASYNC_SPD_MASK|ASYNC_CALLOUT_NOHUP| \
+		ASYNC_LOW_LATENCY)
 #define ASYNC_SPD_CUST		(ASYNC_SPD_HI|ASYNC_SPD_VHI)
 #define ASYNC_SPD_WARP		(ASYNC_SPD_HI|ASYNC_SPD_SHI)
 #define ASYNC_SPD_MASK		(ASYNC_SPD_HI|ASYNC_SPD_VHI|ASYNC_SPD_SHI)
-- 
1.7.9.2
