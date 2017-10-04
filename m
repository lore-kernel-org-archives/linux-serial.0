From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/9] Bluetooth: hci_bcm: Move bcm_platform_probe call out of bcm_acpi_probe
Date: Wed,  4 Oct 2017 20:43:37 +0200
Message-ID: <20171004184343.7855-3-hdegoede@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171004184343.7855-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Since bcm_acpi_probe calls bcm_platform_probe, bcm_probe always ends up
calling bcm_platform_probe.

This commit simplifies things by making bcm_probe always call
bcm_platform_probe itself.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2285ca673ae3..00103307a776 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -820,10 +820,6 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	if (ret)
 		return ret;
 
-	ret = bcm_platform_probe(dev);
-	if (ret)
-		return ret;
-
 	/* Retrieve UART ACPI info */
 	ret = acpi_dev_get_resources(ACPI_COMPANION(&dev->pdev->dev),
 				     &resources, bcm_resource, dev);
@@ -858,10 +854,13 @@ static int bcm_probe(struct platform_device *pdev)
 
 	dev->pdev = pdev;
 
-	if (has_acpi_companion(&pdev->dev))
+	if (has_acpi_companion(&pdev->dev)) {
 		ret = bcm_acpi_probe(dev);
-	else
-		ret = bcm_platform_probe(dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = bcm_platform_probe(dev);
 	if (ret)
 		return ret;
 
-- 
2.14.2

