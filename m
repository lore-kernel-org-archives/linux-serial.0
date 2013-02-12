From: George Spelvin <linux@horizon.com>
Subject: [PATCH v2 3/9] pps: Fix a use-after free bug when unregistering a
 source.
Date: Tue, 12 Feb 2013 02:27:20 -0500
Message-ID: <9a0942515d100e71c19c3471d50bead14e722421.1360677367.git.linux@horizon.com>
References: <cover.1360677367.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:57521 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761260Ab3BLOxi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Feb 2013 09:53:38 -0500
In-Reply-To: <cover.1360677367.git.linux@horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, giometti@linux.it, linux@horizon.com

Remove the cdev from the system (with cdev_del) *before* deallocating it
(in pps_device_destruct, called via kobject_put from device_destroy).

Also prevent deallocating a device with open file handles.

A better long-term fix is probably to remove the cdev from the pps_device
entirely, and instead have all devices reference one global cdev.  Then
the deallocation ordering becomes simpler.

But that's more complex and invasive change, so we leave that
for later.

Signed-off-by: George Spelvin <linux@horizon.com>
Cc: stable@kernel.org
---
 drivers/pps/pps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index a70e384..6437703 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -247,12 +247,15 @@ static int pps_cdev_open(struct inode *inode, struct file *file)
 	struct pps_device *pps = container_of(inode->i_cdev,
 						struct pps_device, cdev);
 	file->private_data = pps;
-
+	kobject_get(&pps->dev->kobj);
 	return 0;
 }
 
 static int pps_cdev_release(struct inode *inode, struct file *file)
 {
+	struct pps_device *pps = container_of(inode->i_cdev,
+						struct pps_device, cdev);
+	kobject_put(&pps->dev->kobj);
 	return 0;
 }
 
@@ -274,8 +277,10 @@ static void pps_device_destruct(struct device *dev)
 {
 	struct pps_device *pps = dev_get_drvdata(dev);
 
-	/* release id here to protect others from using it while it's
-	 * still in use */
+	cdev_del(&pps->cdev);
+
+	/* Now we can release the ID for re-use */
+	pr_debug("deallocating pps%d\n", pps->id);
 	mutex_lock(&pps_idr_lock);
 	idr_remove(&pps_idr, pps->id);
 	mutex_unlock(&pps_idr_lock);
@@ -332,6 +337,7 @@ int pps_register_cdev(struct pps_device *pps)
 		goto del_cdev;
 	}
 
+	/* Override the release function with our own */
 	pps->dev->release = pps_device_destruct;
 
 	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name,
@@ -352,9 +358,9 @@ free_idr:
 
 void pps_unregister_cdev(struct pps_device *pps)
 {
+	pr_debug("unregistering pps%d\n", pps->id);
 	pps->lookup_cookie = NULL;
 	device_destroy(pps_class, pps->dev->devt);
-	cdev_del(&pps->cdev);
 }
 
 /*
-- 
1.8.1.3

