From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 3/9] ia64: Pin controlling tty for unaligned fault message
Date: Sun, 10 Jan 2016 20:36:10 -0800
Message-ID: <1452486976-7594-4-git-send-email-peter@hurleysoftware.com>
References: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prevent destruction of the controlling tty before tty_write_message()
can determine if the tty is safe to use.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 arch/ia64/kernel/unaligned.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/unaligned.c b/arch/ia64/kernel/unaligned.c
index 622772b..e7ae608 100644
--- a/arch/ia64/kernel/unaligned.c
+++ b/arch/ia64/kernel/unaligned.c
@@ -1336,8 +1336,11 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 			 * Don't call tty_write_message() if we're in the kernel; we might
 			 * be holding locks...
 			 */
-			if (user_mode(regs))
-				tty_write_message(current->signal->tty, buf);
+			if (user_mode(regs)) {
+				struct tty_struct *tty = get_current_tty();
+				tty_write_message(tty, buf);
+				tty_kref_put(tty);
+			}
 			buf[len-1] = '\0';	/* drop '\r' */
 			/* watch for command names containing %s */
 			printk(KERN_WARNING "%s", buf);
-- 
2.7.0
