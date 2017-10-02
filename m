From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 8/9] Bluetooth: hci_bcm: Make suspend/resume functions platform_dev independent
Date: Mon,  2 Oct 2017 17:23:55 +0200
Message-ID: <20171002152356.4714-9-hdegoede@redhat.com>
References: <20171002152356.4714-1-hdegoede@redhat.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171002152356.4714-1-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Use dev_get_drvdata instead of platform_get_drvdata in the suspend /
resume functions. This is a preparation patch for adding (runtime)pm
support to the serdev path.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 48a428909958..7191cee5ced0 100644
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
