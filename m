From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 11/14] of: earlycon: Allow multiple OF_EARLYCON_DECLARE() with same name
Date: Fri,  6 Mar 2015 14:25:27 -0500
Message-ID: <1425669930-22137-12-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Since matching is performed only on the compatible string, allow
multiple declarations of OF_EARLYCON_DECLARE() with the same name.
For example,
    OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
    OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
    OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);

Generate a unique identifier for each declaration in the current
compilation unit.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 675d36f..0a711a7 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -362,7 +362,7 @@ extern int of_setup_earlycon(const struct of_device_id *match,
 #endif
 
 #define OF_EARLYCON_DECLARE(_name, compat, fn)				\
-	static const struct of_device_id __of_table_##_name		\
+	static const struct of_device_id __UNIQUE_ID(_name)		\
 		EARLYCON_OF_TABLE_ATTR					\
 		 = { .name = __stringify(_name),			\
 		     .compatible = compat,				\
-- 
2.3.1
