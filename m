From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH] drivers/tty/serial/mcf.c: fix typo on MCF_CONSOLE
Date: Sun, 12 Apr 2015 17:10:01 +0200
Message-ID: <1428851401-5008-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

Correct reference in C-comment after #endif.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
I found this issue with ./scripts/checkkconfigsymbols.py
---
 drivers/tty/serial/mcf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index a9b0ab38a68c..a61031eca1b7 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -597,7 +597,7 @@ console_initcall(mcf_console_init);
 #define	MCF_CONSOLE	NULL
 
 /****************************************************************************/
-#endif /* CONFIG_MCF_CONSOLE */
+#endif /* MCF_CONSOLE */
 /****************************************************************************/
 
 /*
-- 
2.1.0
