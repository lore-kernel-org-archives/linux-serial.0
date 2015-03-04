From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 10/12] of: earlycon: Log more helpful message if earlycon not found
Date: Wed,  4 Mar 2015 12:24:29 -0500
Message-ID: <1425489871-22415-11-git-send-email-peter@hurleysoftware.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Earlycon may fail to initialize for a variety of reasons, most of
which log the default early param message. If the earlycon is
not found, log the OF path which was not found (and suppress the
default early param message).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dd2baae..dca5382 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -800,7 +800,8 @@ int __init early_init_dt_scan_chosen_serial(void)
 		of_setup_earlycon(match, offset, options);
 		return 0;
 	}
-	return -ENODEV;
+	pr_warn("earlycon: %s no match\n", p);
+	return 0;
 }
 
 static int __init setup_of_earlycon(char *buf)
-- 
2.3.1
