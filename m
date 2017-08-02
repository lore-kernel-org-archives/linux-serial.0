From: Michael Moese <michael.moese@men.de>
Subject: [PATCH v2 1/2] mcb: introduce mcb_get_resource()
Date: Wed, 2 Aug 2017 09:58:52 +0200
Message-ID: <20170802075853.18911-1-michael.moese@men.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: michael.moese@men.de, johannes.thumshirn@suse.de, Johannes Thumshirn <jthumshirn@suse.de>
List-Id: linux-serial@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

Introduce mcb_get_resource() as a common accessor to a mcb device's memory or
IRQ resources.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/mcb/mcb-core.c | 20 +++++++++++++++++++-
 include/linux/mcb.h    |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 921a5d2a802b..bb5c5692dedc 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -418,6 +418,22 @@ void mcb_bus_add_devices(const struct mcb_bus *bus)
 EXPORT_SYMBOL_GPL(mcb_bus_add_devices);
 
 /**
+ * mcb_get_resource() - get a resource for a mcb device
+ * @dev: the mcb device
+ * @type: the type of resource
+ */
+struct resource *mcb_get_resource(struct mcb_device *dev, unsigned int type)
+{
+	if (type == IORESOURCE_MEM)
+		return &dev->mem;
+	else if (type == IORESOURCE_IRQ)
+		return &dev->irq;
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(mcb_get_resource);
+
+/**
  * mcb_request_mem() - Request memory
  * @dev: The @mcb_device the memory is for
  * @name: The name for the memory reference.
@@ -460,7 +476,9 @@ EXPORT_SYMBOL_GPL(mcb_release_mem);
 
 static int __mcb_get_irq(struct mcb_device *dev)
 {
-	struct resource *irq = &dev->irq;
+	struct resource *irq;
+
+	irq = mcb_get_resource(dev, IORESOURCE_IRQ);
 
 	return irq->start;
 }
diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index 4097ac9ea13a..b1a0ad9d23b3 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -136,5 +136,7 @@ extern struct resource *mcb_request_mem(struct mcb_device *dev,
 					const char *name);
 extern void mcb_release_mem(struct resource *mem);
 extern int mcb_get_irq(struct mcb_device *dev);
+extern struct resource *mcb_get_resource(struct mcb_device *dev,
+					 unsigned int type);
 
 #endif /* _LINUX_MCB_H */
-- 
2.12.3
