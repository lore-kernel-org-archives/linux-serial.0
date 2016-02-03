From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 04/12] ata: ahci_mvebu: add support for Armada 3700 variant
Date: Wed,  3 Feb 2016 19:41:21 +0100
Message-ID: <1454524889-9207-5-git-send-email-gregory.clement@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
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
 drivers/ata/ahci_mvebu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

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
