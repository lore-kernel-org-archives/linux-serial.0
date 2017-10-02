From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6/9] Bluetooth: hci_bcm: Rename bcm_platform_probe to bcm_get_resources
Date: Mon,  2 Oct 2017 17:23:53 +0200
Message-ID: <20171002152356.4714-7-hdegoede@redhat.com>
References: <20171002152356.4714-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171002152356.4714-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

After our previous changes, there is nothing platform specific about
bcm_platform_probe anymore, rename it to bcm_get_resources.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index cfc87fb5051c..5c8371d8aace 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -756,7 +756,7 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 }
 #endif /* CONFIG_ACPI */
 
-static int bcm_platform_probe(struct bcm_device *dev)
+static int bcm_get_resources(struct bcm_device *dev)
 {
 	dev->name = dev_name(dev->dev);
 
@@ -857,7 +857,7 @@ static int bcm_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = bcm_platform_probe(dev);
+	ret = bcm_get_resources(dev);
 	if (ret)
 		return ret;
 
-- 
2.14.2

