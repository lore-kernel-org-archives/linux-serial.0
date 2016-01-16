From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 10/11] of: earlycon: Log more helpful message if stdout-path node not found
Date: Sat, 16 Jan 2016 13:37:23 -0800
Message-ID: <1452980244-20512-11-git-send-email-peter@hurleysoftware.com>
References: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
 <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Earlycon may fail to initialize for a variety of reasons, most of
which log the default early param message. If the stdout-path node is
not found, log the path which was not found (and suppress the
default early param message).

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 918809e..e2295b2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -820,11 +820,14 @@ static int __init early_init_dt_scan_chosen_serial(void)
 	q = strchrnul(p, ':');
 	if (*q != '\0')
 		options = q + 1;
+	l = q - p;
 
 	/* Get the node specified by stdout-path */
-	offset = fdt_path_offset_namelen(fdt, p, q - p);
-	if (offset < 0)
-		return -ENODEV;
+	offset = fdt_path_offset_namelen(fdt, p, l);
+	if (offset < 0) {
+		pr_warn("earlycon: stdout-path %.*s not found\n", l, p);
+		return 0;
+	}
 
 	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
 		if (!match->compatible[0])
-- 
2.7.0
