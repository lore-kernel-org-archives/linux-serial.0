From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 06/13] of: earlycon: of_setup_earlycon() requires CONFIG_OF_EARLY_FLATTREE
Date: Wed,  8 Apr 2015 13:45:12 -0400
Message-ID: <1428515119-25248-7-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

DT earlycon is only supported for CONFIG_OF_EARLY_FLATTREE=y; exclude
of_setup_earlycon() if not defined.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 46f39c9..96e3ad1 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -209,6 +209,8 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);
 
+#ifdef CONFIG_OF_EARLY_FLATTREE
+
 int __init of_setup_earlycon(unsigned long addr,
 			     const struct earlycon_id *match,
 			     const char *options)
@@ -236,3 +238,5 @@ int __init of_setup_earlycon(unsigned long addr,
 	register_console(early_console_dev.con);
 	return 0;
 }
+
+#endif /* CONFIG_OF_EARLY_FLATTREE */
-- 
2.3.5
