From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] tty: rocket: fix comment of ROCKET_SPD_HI
Date: Mon, 11 May 2015 10:25:58 +0900
Message-ID: <1431307558-8482-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This comment does not reflect the actual code.  It should be 57600,
not 56000.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/rocket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/rocket.h b/drivers/tty/rocket.h
index ec863f3..c11a939 100644
--- a/drivers/tty/rocket.h
+++ b/drivers/tty/rocket.h
@@ -44,7 +44,7 @@ struct rocket_version {
 #define ROCKET_HUP_NOTIFY	0x00000004
 #define ROCKET_SPLIT_TERMIOS	0x00000008
 #define ROCKET_SPD_MASK		0x00000070
-#define ROCKET_SPD_HI		0x00000010	/* Use 56000 instead of 38400 bps */
+#define ROCKET_SPD_HI		0x00000010	/* Use 57600 instead of 38400 bps */
 #define ROCKET_SPD_VHI		0x00000020	/* Use 115200 instead of 38400 bps */
 #define ROCKET_SPD_SHI		0x00000030	/* Use 230400 instead of 38400 bps */
 #define ROCKET_SPD_WARP	        0x00000040	/* Use 460800 instead of 38400 bps */
-- 
1.9.1
