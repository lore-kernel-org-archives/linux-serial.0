From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6 01/12] of: earlycon: of_setup_earlycon() requires CONFIG_OF_EARLY_FLATTREE
Date: Sat, 16 Jan 2016 15:23:38 -0800
Message-ID: <1452986629-17210-2-git-send-email-peter@hurleysoftware.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

DT earlycon is only supported for CONFIG_OF_EARLY_FLATTREE=y; exclude
of_setup_earlycon() if not defined.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 3f24236..54419a2 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -204,6 +204,8 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);
 
+#ifdef CONFIG_OF_EARLY_FLATTREE
+
 int __init of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
@@ -227,3 +229,5 @@ int __init of_setup_earlycon(unsigned long addr,
 	register_console(early_console_dev.con);
 	return 0;
 }
+
+#endif /* CONFIG_OF_EARLY_FLATTREE */
-- 
2.7.0
