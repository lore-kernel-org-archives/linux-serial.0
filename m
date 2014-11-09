From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
Date: Sun,  9 Nov 2014 00:55:47 -0800
Message-ID: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64644 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaKII41 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Nov 2014 03:56:27 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, stable@vger.kernel.org

__earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
it will never be NULL.  Checking it against NULL causes the match loop to
run past the end of the array, and eventually match a bogus entry, under
the following conditions:

 - Kernel command line specifies "earlycon" with no parameters
 - DT has a stdout-path pointing to a UART node
 - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
   driver is compiled out)

Fix this by checking to see if match->compatible is a non-empty string.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Cc: <stable@vger.kernel.org> # 3.16+
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1ffca8..30e97bc 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -773,7 +773,7 @@ int __init early_init_dt_scan_chosen_serial(void)
 	if (offset < 0)
 		return -ENODEV;
 
-	while (match->compatible) {
+	while (match->compatible[0]) {
 		unsigned long addr;
 		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
 			match++;
-- 
2.1.1

