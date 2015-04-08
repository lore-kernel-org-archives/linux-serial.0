From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 11/13] of: earlycon: Log more helpful message if earlycon not found
Date: Wed,  8 Apr 2015 13:45:17 -0400
Message-ID: <1428515119-25248-12-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
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
index 007c330..f55c77c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -800,7 +800,8 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		of_setup_earlycon(match, offset, options);
 		return 0;
 	}
-	return -ENODEV;
+	pr_warn("earlycon: %.*s no match\n", (int)(q - p), p);
+	return 0;
 }
 
 static int __init setup_of_earlycon(char *buf)
-- 
2.3.5
