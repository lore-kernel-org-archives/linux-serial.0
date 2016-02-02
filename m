From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 02/10] ata: ahci_mvebu: add support for Armada 3700 variant
Date: Tue,  2 Feb 2016 19:07:40 +0100
Message-ID: <1454436468-4241-3-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Lior Amsalem <alior@marvell.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Lior Amsalem <alior@marvell.com>

The main difference in the new Armada 3700 is that no address
decoding needs to take place in the driver probe.

[gregory.clement@free-electrons.com: reformulate the commit log]

Signed-off-by: Lior Amsalem <alior@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Tested-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/ata/Kconfig      |  2 +-
 drivers/ata/ahci_mvebu.c | 14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 861643ea91b5..1cc0c966ff88 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -144,7 +144,7 @@ config AHCI_CEVA
 
 config AHCI_MVEBU
 	tristate "Marvell EBU AHCI SATA support"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || ARCH_ARMADA_3700
 	help
 	  This option enables support for the Marvebu EBU SoC's
 	  onboard AHCI SATA.
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index f7a7fa81740e..de7128d81e9c 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -112,12 +112,15 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	dram = mv_mbus_dram_info();
-	if (!dram)
-		return -ENODEV;
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "marvell,armada-380-ahci")) {
+		dram = mv_mbus_dram_info();
+		if (!dram)
+			return -ENODEV;
 
-	ahci_mvebu_mbus_config(hpriv, dram);
-	ahci_mvebu_regret_option(hpriv);
+		ahci_mvebu_mbus_config(hpriv, dram);
+		ahci_mvebu_regret_option(hpriv);
+	}
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
 				     &ahci_platform_sht);
@@ -133,6 +136,7 @@ disable_resources:
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
 	{ .compatible = "marvell,armada-380-ahci", },
+	{ .compatible = "marvell,armada-3700-ahci", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
-- 
2.5.0
