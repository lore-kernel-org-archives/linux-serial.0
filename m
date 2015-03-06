From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 01/14] of: earlycon: Fix 'stdout-path' with ':' path terminator
Date: Fri,  6 Mar 2015 14:25:17 -0500
Message-ID: <1425669930-22137-2-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

stdout-path defines ':' as a path terminator and commit 75c28c09af99a
("of: add optional options parameter to of_find_node_by_path()") added
the necessary support to parse paths terminated with ':'.
commit 7914a7c5651a5 ("of: support passing console options with
stdout-path") added options string support to the stdout-path property,
which broke earlycon.

Add the same support to earlycon to process 'stdout-path' properties
which contain an options string.

Requires: "libfdt: Add fdt_path_offset_namelen()"
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3a896c9..7cef9f9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -765,7 +765,7 @@ extern struct of_device_id __earlycon_of_table[];
 static int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
-	const char *p;
+	const char *p, *q;
 	int l;
 	const struct of_device_id *match = __earlycon_of_table;
 	const void *fdt = initial_boot_params;
@@ -782,8 +782,10 @@ static int __init early_init_dt_scan_chosen_serial(void)
 	if (!p || !l)
 		return -ENOENT;
 
+	q = strchrnul(p, ':');
+
 	/* Get the node specified by stdout-path */
-	offset = fdt_path_offset(fdt, p);
+	offset = fdt_path_offset_namelen(fdt, p, (int)(q - p));
 	if (offset < 0)
 		return -ENODEV;
 
-- 
2.3.1
