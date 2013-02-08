From: George Spelvin <linux@horizon.com>
Subject: [PATCH 5/7] pps: Add pps_lookup_dev() function
Date: Fri, 8 Feb 2013 01:38:54 -0500
Message-ID: <8447846ad3b32400adc9a48d61ad6aa818ae3b8d.1360307140.git.linux@horizon.com>
References: <cover.1360307140.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36265 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946082Ab3BHJQi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 04:16:38 -0500
In-Reply-To: <cover.1360307140.git.linux@horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, giometti@linux.it

The PPS serial line discipline wants to attach a PPS device to a tty
without changing the tty code to add a struct pps_device * pointer.

Since the number of PPS devices in a typical system is generally very low
(n=1 is by far the most common), it's practical to search the entire list
of allocated pps devices.  (We capture the timestamp before the lookup,
so the timing isn't affected.)

It is a bit ugly that this function, which is part of the in-kernel
PPS API, has to be in pps.c as opposed to kapi,c, but that's not
something that affects users.

Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/pps/pps.c          | 35 +++++++++++++++++++++++++++++++++++
 include/linux/pps_kernel.h | 17 ++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 2420d5a..9a87565 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -357,6 +357,41 @@ void pps_unregister_cdev(struct pps_device *pps)
 }
 
 /*
+ * Look up a pps device by magic cookie.
+ * The cookie is usually a pointer to some enclosing device, but this
+ * code doesn't care; you should never be dereferencing it.
+ *
+ * This is a bit of a kludge that is currently used only by the PPS
+ * serial line discipline.  It may need to be tweaked when a second user
+ * is found.
+ *
+ * There is no function interface for setting the lookup_cookie field.
+ * It's initialized to NULL when the pps device is created, and if a
+ * client wants to use it, just fill it in afterward.
+ *
+ * A very important usage note is that the list used is the same as the
+ * list of assigned minor numbers.  Thus, a pps device can be looked up
+ * after pps_unregister_source time if there are open file handles preventing
+ * it from being deallocated.
+ *
+ * To ensure that this does not lead to duplicate cookies (which Would
+ * Be Bad), also set the cookie to NULL before unregistering.
+ */
+struct pps_device *pps_lookup_dev(void const *cookie)
+{
+	struct pps_device *pps;
+	unsigned id;
+
+	rcu_read_lock();
+	idr_for_each_entry(&pps_idr, pps, id)
+		if (cookie == pps->lookup_cookie)
+			break;
+	rcu_read_unlock();
+	return pps;
+}
+EXPORT_SYMBOL(pps_lookup_dev);
+
+/*
  * Module stuff
  */
 
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 0cc45ae..7db3eb9 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -43,7 +43,7 @@ struct pps_source_info {
 			int event, void *data);	/* PPS echo function */
 
 	struct module *owner;
-	struct device *dev;
+	struct device *dev;		/* Parent device for device_create */
 };
 
 struct pps_event_time {
@@ -69,6 +69,7 @@ struct pps_device {
 	wait_queue_head_t queue;		/* PPS event queue */
 
 	unsigned int id;			/* PPS source unique ID */
+	void const *lookup_cookie;		/* pps_lookup_dev only */
 	struct cdev cdev;
 	struct device *dev;
 	struct fasync_struct *async_queue;	/* fasync method */
@@ -82,16 +83,26 @@ struct pps_device {
 extern struct device_attribute pps_attrs[];
 
 /*
+ * Internal functions.
+ *
+ * These are not actually part of the exported API, but this is a
+ * convenient header file to put them in.
+ */
+
+extern int pps_register_cdev(struct pps_device *pps);
+extern void pps_unregister_cdev(struct pps_device *pps);
+
+/*
  * Exported functions
  */
 
 extern struct pps_device *pps_register_source(
 		struct pps_source_info *info, int default_params);
 extern void pps_unregister_source(struct pps_device *pps);
-extern int pps_register_cdev(struct pps_device *pps);
-extern void pps_unregister_cdev(struct pps_device *pps);
 extern void pps_event(struct pps_device *pps,
 		struct pps_event_time *ts, int event, void *data);
+/* Look up a pps device by magic cookie */
+struct pps_device *pps_lookup_dev(void const *cookie);
 
 static inline void timespec_to_pps_ktime(struct pps_ktime *kt,
 		struct timespec ts)
-- 
1.8.1.2

