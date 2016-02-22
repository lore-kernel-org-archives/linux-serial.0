From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 1/8] arm64: move acpi/dt decision earlier in boot process
Date: Mon, 22 Feb 2016 16:46:49 +0300
Message-ID: <1456148818-26257-2-git-send-email-aleksey.makarov@linaro.org>
References: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-serial@vger.kernel.org

From: Leif Lindholm <leif.lindholm@linaro.org>

In order to support selecting earlycon via either ACPI or DT, move
the decision on whether to attempt ACPI configuration into the
early_param handling. Then make acpi_boot_table_init() bail out if
acpi_disabled.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 arch/arm64/kernel/acpi.c | 54 ++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2..7a944f7 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -44,6 +44,19 @@ EXPORT_SYMBOL(acpi_pci_disabled);
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
@@ -57,23 +70,27 @@ static int __init parse_acpi(char *arg)
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
+
 /*
  * __acpi_map_table() will be called before page_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
@@ -181,23 +198,10 @@ out:
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
2.7.1

