From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 9/9] n_tty: Avoid false-sharing echo buffer indices
Date: Mon, 15 Apr 2013 11:29:47 -0400
Message-ID: <1366039787-8719-10-git-send-email-peter@hurleysoftware.com>
References: <1366039567-8620-1-git-send-email-peter@hurleysoftware.com>
 <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Separate the head & commit indices from the tail index to avoid
cache-line contention (so called 'false-sharing') between concurrent
threads.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index eb20777..aa63cd3 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -90,6 +90,8 @@ struct n_tty_data {
 	/* producer-published */
 	size_t read_head;
 	size_t canon_head;
+	size_t echo_head;
+	size_t echo_commit;
 	DECLARE_BITMAP(process_char_map, 256);
 
 	/* private to n_tty_receive_overrun (single-threaded) */
@@ -105,20 +107,17 @@ struct n_tty_data {
 	/* shared by producer and consumer */
 	char *read_buf;
 	DECLARE_BITMAP(read_flags, N_TTY_BUF_SIZE);
+	unsigned char *echo_buf;
 
 	int minimum_to_wake;
 
 	/* consumer-published */
 	size_t read_tail;
 
-	unsigned char *echo_buf;
-	size_t echo_head;
-	size_t echo_tail;
-	size_t echo_commit;
-
 	/* protected by output lock */
 	unsigned int column;
 	unsigned int canon_column;
+	size_t echo_tail;
 
 	struct mutex atomic_read_lock;
 	struct mutex output_lock;
-- 
1.8.1.2
