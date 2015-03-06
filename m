From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 06/14] of: earlycon: of_setup_earlycon() requires CONFIG_OF_EARLY_FLATTREE
Date: Fri,  6 Mar 2015 14:25:22 -0500
Message-ID: <1425669930-22137-7-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

DT earlycon is only supported for CONFIG_OF_EARLY_FLATTREE=y; exclude
of_setup_earlycon() if not defined.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 023ebbb..1a37f27 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -217,6 +217,8 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);
 
+#ifdef CONFIG_OF_EARLY_FLATTREE
+
 int __init of_setup_earlycon(unsigned long addr,
 			     const struct of_device_id *match,
 			     const char *options)
@@ -245,3 +247,5 @@ int __init of_setup_earlycon(unsigned long addr,
 	register_console(early_console_dev.con);
 	return 0;
 }
+
+#endif /* CONFIG_OF_EARLY_FLATTREE */
-- 
2.3.1
