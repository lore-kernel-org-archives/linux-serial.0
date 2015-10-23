From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] of/fdt: fix error checking for earlycon address
Date: Fri, 23 Oct 2015 20:47:20 +0900
Message-ID: <1445600840-26749-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>
List-Id: linux-serial@vger.kernel.org

fdt_translate_address() returns OF_BAD_ADDR on error.  It is defined as
a u64 value, so the variable "addr" should be defined as u64 as well.

Fixes: fb11ffe74c79 ("of/fdt: add FDT serial scanning for earlycon")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/of/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9fc3568..196e449 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -822,14 +822,15 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		return -ENODEV;
 
 	while (match->compatible[0]) {
-		unsigned long addr;
+		u64 addr;
+
 		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
 			match++;
 			continue;
 		}
 
 		addr = fdt_translate_address(fdt, offset);
-		if (!addr)
+		if (addr == OF_BAD_ADDR)
 			return -ENXIO;
 
 		of_setup_earlycon(addr, match->data);
-- 
1.9.1
