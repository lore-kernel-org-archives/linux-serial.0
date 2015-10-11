From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] tty: synclink, fix indentation
Date: Sun, 11 Oct 2015 15:22:45 +0200
Message-ID: <1444569765-9081-2-git-send-email-jslaby@suse.cz>
References: <1444569765-9081-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444569765-9081-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

The statement after if should be indenteted. So fix this.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/synclink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 701dd4e3446d..97ad9df048b5 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -6633,7 +6633,7 @@ static bool mgsl_get_rx_frame(struct mgsl_struct *info)
 			unsigned char *ptmp = info->intermediate_rxbuffer;
 
 			if ( !(status & RXSTATUS_CRC_ERROR))
-			info->icount.rxok++;
+				info->icount.rxok++;
 			
 			while(copy_count) {
 				int partial_count;
-- 
2.6.1
