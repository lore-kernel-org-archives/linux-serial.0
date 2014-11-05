From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 2/3] tty: Convert tty->closing to int
Date: Wed,  5 Nov 2014 12:40:04 -0500
Message-ID: <1415209205-16309-3-git-send-email-peter@hurleysoftware.com>
References: <1415209205-16309-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415209205-16309-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty->closing is a bitfield member; prevent corruption from non-atomic
update by assigning a unique memory location.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index c52a689..7d66ae5 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -284,7 +284,7 @@ struct tty_struct {
 
 #define N_TTY_BUF_SIZE 4096
 
-	unsigned char closing:1;
+	int closing;
 	unsigned char *write_buf;
 	int write_cnt;
 	/* If the tty has a pending do_SAK, queue it here - akpm */
-- 
2.1.3
