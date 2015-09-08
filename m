From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: [RFC 1/5] arm64: move acpi/dt decision earlier in boot process
Date: Tue,  8 Sep 2015 13:43:33 +0100
Message-ID: <1441716217-23786-2-git-send-email-leif.lindholm@linaro.org>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, al.stone@linaro.org, torez@redhat.com, jcm@redhat.com, graeme.gregory@linaro.org, linaro-acpi@lists.linaro.org, lv.zheng@intel.com
List-Id: linux-serial@vger.kernel.org

In order to support selecting earlycon via either ACPI or DT, move
the decision on whether to attempt ACPI configuration into the
early_param handling. Then make acpi_boot_table_init() bail out if
acpi_disabled.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 arch/arm64/kernel/acpi.c | 53 +++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 19de753..b9a5623 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -39,6 +39,19 @@ EXPORT_SYMBOL(acpi_pci_disabled);
 static bool param_acpi_off __initdata;
 static bool param_acpi_force __initdata;
 
+static int __init dt_scan_depth1_nodes(unsigned long node,
+				       const char *uname, int depth,
+				       void *data)
+{
+	/*
+	 * Return 1 as soon as we encounter a node at depth 1 that is
+	 * not the /chosen node.
+	 */
+	if (depth == 1 && (strcmp(uname, "chosen") != 0))
+		return 1;
+	return 0;
+}
+
 static int __init parse_acpi(char *arg)
 {
 	if (!arg)
@@ -52,22 +65,25 @@ static int __init parse_acpi(char *arg)
 	else
 		return -EINVAL;	/* Core will print when we return error */
 
-	return 0;
-}
-early_param("acpi", parse_acpi);
+	/*
+	 * Enable ACPI instead of device tree unless
+	 * - ACPI has been disabled explicitly (acpi=off), or
+	 * - the device tree is not empty (it has more than just a /chosen node)
+	 *   and ACPI has not been force enabled (acpi=force)
+	 */
+	if (param_acpi_off ||
+	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
+		return 0;
 
-static int __init dt_scan_depth1_nodes(unsigned long node,
-				       const char *uname, int depth,
-				       void *data)
-{
 	/*
-	 * Return 1 as soon as we encounter a node at depth 1 that is
-	 * not the /chosen node.
+	 * ACPI is disabled at this point. Enable it in order to parse
+	 * the ACPI tables and carry out sanity checks
 	 */
-	if (depth == 1 && (strcmp(uname, "chosen") != 0))
-		return 1;
+	enable_acpi();
+
 	return 0;
 }
+early_param("acpi", parse_acpi);
 
 /*
  * __acpi_map_table() will be called before page_init(), so early_ioremap()
@@ -176,23 +192,10 @@ out:
  */
 void __init acpi_boot_table_init(void)
 {
-	/*
-	 * Enable ACPI instead of device tree unless
-	 * - ACPI has been disabled explicitly (acpi=off), or
-	 * - the device tree is not empty (it has more than just a /chosen node)
-	 *   and ACPI has not been force enabled (acpi=force)
-	 */
-	if (param_acpi_off ||
-	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
+	if (acpi_disabled)
 		return;
 
 	/*
-	 * ACPI is disabled at this point. Enable it in order to parse
-	 * the ACPI tables and carry out sanity checks
-	 */
-	enable_acpi();
-
-	/*
 	 * If ACPI tables are initialized and FADT sanity checks passed,
 	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
 	 * on initialization error.
-- 
2.1.4

