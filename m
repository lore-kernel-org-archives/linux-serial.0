From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 8/9] Bluetooth: hci_bcm: Make suspend/resume functions platform_dev independent
Date: Wed,  4 Oct 2017 20:43:42 +0200
Message-ID: <20171004184343.7855-8-hdegoede@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171004184343.7855-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use dev_get_drvdata instead of platform_get_drvdata in the suspend /
resume functions. This is a preparation patch for adding (runtime)pm
support to the serdev path.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index e577547c4acf..e7494efb56e9 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -558,7 +558,7 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 #ifdef CONFIG_PM
 static int bcm_suspend_device(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	struct bcm_device *bdev = dev_get_drvdata(dev);
 
 	bt_dev_dbg(bdev, "");
 
@@ -581,7 +581,7 @@ static int bcm_suspend_device(struct device *dev)
 
 static int bcm_resume_device(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	struct bcm_device *bdev = dev_get_drvdata(dev);
 
 	bt_dev_dbg(bdev, "");
 
@@ -606,7 +606,7 @@ static int bcm_resume_device(struct device *dev)
 /* Platform suspend callback */
 static int bcm_suspend(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	struct bcm_device *bdev = dev_get_drvdata(dev);
 	int error;
 
 	bt_dev_dbg(bdev, "suspend: is_suspended %d", bdev->is_suspended);
@@ -638,7 +638,7 @@ static int bcm_suspend(struct device *dev)
 /* Platform resume callback */
 static int bcm_resume(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	struct bcm_device *bdev = dev_get_drvdata(dev);
 
 	bt_dev_dbg(bdev, "resume: is_suspended %d", bdev->is_suspended);
 
-- 
2.14.2

