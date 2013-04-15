From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 07/24] tty: Deprecate ldisc .chars_in_buffer() method
Date: Mon, 15 Apr 2013 11:19:11 -0400
Message-ID: <1366039168-8510-8-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c37f250..0bc0869 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -297,6 +297,7 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
 
 static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
 {
+	WARN_ONCE(1, "%s is deprecated and scheduled for removal.", __func__);
 	return chars_in_buffer(tty);
 }
 
-- 
1.8.1.2
