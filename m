From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/68] TTY: serialP, remove DECLARE_WAITQUEUE check
Date: Mon,  5 Mar 2012 14:52:00 +0100
Message-ID: <1330955575-26641-14-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-serial@vger.kernel.org

The macro is always defined now. This was there only for historical
reasons.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/serialP.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/serialP.h b/include/linux/serialP.h
index e811a61..ec27b34 100644
--- a/include/linux/serialP.h
+++ b/include/linux/serialP.h
@@ -79,15 +79,9 @@ struct async_struct {
 	int			io_type;
 	struct work_struct			work;
 	struct tasklet_struct	tlet;
-#ifdef DECLARE_WAITQUEUE
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
 	wait_queue_head_t	delta_msr_wait;
-#else	
-	struct wait_queue	*open_wait;
-	struct wait_queue	*close_wait;
-	struct wait_queue	*delta_msr_wait;
-#endif	
 	struct async_struct	*next_port; /* For the linked list */
 	struct async_struct	*prev_port;
 };
-- 
1.7.9.2
