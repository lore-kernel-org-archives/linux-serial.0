Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71338253B59;
	Fri, 28 Nov 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764353503; cv=none; b=NXhgFCWcttQfWuCwwTKiHJpBazEfF9owidSU7cbTn9WJo81c8UYlIkjISE8BKxAsQDeCqvKp1hEg1Jm8fzcGWAVxTznTHPPNLj2MDuB8MpPna3/kk4Nqhdc7BfNy9D+2WfnuWIB4rHuhCSN3dNNt/reuwade1hYhlcQDqvOlCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764353503; c=relaxed/simple;
	bh=5G078yH9I71iAWEV7F1eezQABlJYoto+UQncVe4bLG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMm7XHseuKy/EQqLA6RqwGNEbttZrU+fEHOM/KQUB4ej7smWCw+190hLmUeuWbvTSrDKTN/7FMnRz0WbbAZ+ILRkE8q+bYN0rfZ79pM21tnm/TiADT91bJ/p1YESJJsJT85oIw/jxwv3uX0K5bwQll0ux7J+kOxBSVnyj5GsS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f59bH5ha; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f59bH5ha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+c
	VJHyg8Dppgn54bS34XzjplKS/1ummL6piiOT+BwEQ=; b=f59bH5ha7eigiKcD3+
	XU4Rcw/NhyOCiFqnQncg+RX1mifBL/7FZXTiGsxgOofhPcCfohGiKKClsUmPG8Mh
	s57UMxm/rn1ZVqSMxXNLDRT/fpFtLpfjW7Ilzxi6DFLiDX0D0FTyeV6hv5vC4X8Z
	1SZ4Fl41FnsGkPj03LlS8k+Xo=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB386ir5Slp1158Dg--.28857S2;
	Sat, 29 Nov 2025 02:10:52 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	tj@kernel.org
Cc: hch@infradead.org,
	jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4] tty: tty_port: add workqueue to flip tty buffer
Date: Sat, 29 Nov 2025 02:10:48 +0800
Message-Id: <20251128181048.429570-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB386ir5Slp1158Dg--.28857S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3tr4xtFykJr43Cr17JryDGFg_yoW8Gr4xJo
	Z3WF15A3Z5Jr1xAayFyrn7ZF1fXa9ruFZ8CayUArZ8X34jq3W5XrZrG3y3Xa43Wr45CF45
	Z3WUJ3ZayF4xAa4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RRoGmDUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwAxJU2kp5az6SwAA3u

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. The tty_flip_buffer_push interface in the TTY
layer uses system_unbound_wq to handle the flipping of the TTY buffer.
Although the unbound workqueue can create new threads on demand and wake
up the kworker thread on an idle CPU, it may be preeempted by real-time
tasks or other high-prio tasks.
In flush_to_ldisc, when executing n_tty_receive_buf_common, it wakes up
other tasks. __wake_up_common_lock calls spin_lock_irqsave, which does
not disable preemption but disable migration in RT-Linux. This prevents
the kworker thread from being migrated to other cores by CPU's balancing
logic, resulting in long delays.
In our system, the processing interval for each frame of IMU data
transmitted via UART can experience significant jitter due to this issue.
Instead of the expected 10 to 15 ms frame processing interval, we see
spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
be 2 to 3 occurrences of such high jitter, which is quite frequent. This
jitter exceeds the software's tolerable limit of 20 ms.
Introduce flip_wq in tty_port which can be set by tty_port_link_wq or as
default linked to workqueue allocated when tty_register_driver using flag
WQ_SYSFS, so that cpumask and nice can be set dynamically.
Introduce TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
default single tty_driver workqueue.
We set the cpumask to the same cpu where the IMU data is handled and has
less long-time high-prio jobs, and then set nice to -20, the frame
processing interval remains between 10 and 15ms, no jitter occurs.

---
Change in v4:
- Simplifying the logic for creating and releasing the workqueue,
  as suggested by Tejun Heo.
- Allocate single workqueue of one tty_driver as default, link it to
  port when tty_port register device or tty_driver.
- Introduce tty_port_link_wq to link specific workqueue to port.
- Add driver flag TTY_DRIVER_CUSTOM_WORKQUEUE meaning not to create the
  default single tty_driver workqueue.

Change in v3:
- Add tty flip workqueue for all tty ports, as suggested by Greg KH.
  Every tty port use an individual flip workqueue, while all pty ports
  share the same workqueue created in pty_flip_wq_init.
- Modify the commit log to describe the reason for latency spikes in
  RT-Linux.
- Link to v3: https://lore.kernel.org/all/20251027060929.394053-1-jackzxcui1989@163.com/

Change in v2:
- Do not add new module parameters
  as suggested by Greg KH
- Set WQ_SYSFS to allow properties changes from userspace
  as suggested by Tejun Heo
- Link to v2: https://lore.kernel.org/all/20251024155534.2302590-1-jackzxcui1989@163.com

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 drivers/tty/pty.c          | 24 ++++++++++++++++++++----
 drivers/tty/tty_buffer.c   |  8 ++++----
 drivers/tty/tty_io.c       | 19 +++++++++++++++++++
 drivers/tty/tty_port.c     | 19 +++++++++++++++++++
 include/linux/tty_buffer.h |  1 +
 include/linux/tty_driver.h |  7 +++++++
 include/linux/tty_port.h   |  9 +++++++++
 7 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8bb1a01fe..e3db1a4d3 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -44,6 +44,8 @@ static struct tty_driver *pts_driver;
 static DEFINE_MUTEX(devpts_mutex);
 #endif
 
+static struct workqueue_struct *pty_flip_wq;
+
 static void pty_close(struct tty_struct *tty, struct file *filp)
 {
 	if (tty->driver->subtype == PTY_TYPE_MASTER)
@@ -407,6 +409,8 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 	o_tty->link = tty;
 	tty_port_init(ports[0]);
 	tty_port_init(ports[1]);
+	tty_port_link_wq(ports[0], pty_flip_wq);
+	tty_port_link_wq(ports[1], pty_flip_wq);
 	tty_buffer_set_limit(ports[0], 8192);
 	tty_buffer_set_limit(ports[1], 8192);
 	o_tty->port = ports[0];
@@ -536,17 +540,23 @@ static void __init legacy_pty_init(void)
 	pty_driver = tty_alloc_driver(legacy_count,
 			TTY_DRIVER_RESET_TERMIOS |
 			TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_CUSTOM_WORKQUEUE);
 	if (IS_ERR(pty_driver))
 		panic("Couldn't allocate pty driver");
 
 	pty_slave_driver = tty_alloc_driver(legacy_count,
 			TTY_DRIVER_RESET_TERMIOS |
 			TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_CUSTOM_WORKQUEUE);
 	if (IS_ERR(pty_slave_driver))
 		panic("Couldn't allocate pty slave driver");
 
+	pty_flip_wq = alloc_workqueue("pty-flip-wq", WQ_UNBOUND | WQ_SYSFS, 0);
+	if (!pty_flip_wq)
+		panic("Couldn't allocate pty flip workqueue");
+
 	pty_driver->driver_name = "pty_master";
 	pty_driver->name = "pty";
 	pty_driver->major = PTY_MASTER_MAJOR;
@@ -877,7 +887,8 @@ static void __init unix98_pty_init(void)
 			TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV |
 			TTY_DRIVER_DEVPTS_MEM |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_CUSTOM_WORKQUEUE);
 	if (IS_ERR(ptm_driver))
 		panic("Couldn't allocate Unix98 ptm driver");
 	pts_driver = tty_alloc_driver(NR_UNIX98_PTY_MAX,
@@ -885,10 +896,15 @@ static void __init unix98_pty_init(void)
 			TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV |
 			TTY_DRIVER_DEVPTS_MEM |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_CUSTOM_WORKQUEUE);
 	if (IS_ERR(pts_driver))
 		panic("Couldn't allocate Unix98 pts driver");
 
+	pty_flip_wq = alloc_workqueue("pty-flip-wq", WQ_UNBOUND | WQ_SYSFS, 0);
+	if (!pty_flip_wq)
+		panic("Couldn't allocate pty flip workqueue");
+
 	ptm_driver->driver_name = "pty_master";
 	ptm_driver->name = "ptm";
 	ptm_driver->major = UNIX98_PTY_MASTER_MAJOR;
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 67271fc0b..86e1e7178 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -76,7 +76,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 	mutex_unlock(&buf->lock);
 
 	if (restart)
-		queue_work(system_unbound_wq, &buf->work);
+		queue_work(buf->flip_wq, &buf->work);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
@@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 
 	tty_flip_buffer_commit(buf->tail);
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(buf->flip_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -560,7 +560,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 		tty_flip_buffer_commit(buf->tail);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(buf->flip_wq, &buf->work);
 
 	return size;
 }
@@ -613,7 +613,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
 
 bool tty_buffer_restart_work(struct tty_port *port)
 {
-	return queue_work(system_unbound_wq, &port->buf.work);
+	return queue_work(port->buf.flip_wq, &port->buf.work);
 }
 
 bool tty_buffer_cancel_work(struct tty_port *port)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70..a3e019873 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3452,6 +3452,20 @@ int tty_register_driver(struct tty_driver *driver)
 			goto err_unreg_char;
 	}
 
+	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
+		driver->flip_wq = alloc_workqueue("%s-flip-wq",
+						WQ_UNBOUND | WQ_SYSFS,
+						0, driver->name);
+		if (!driver->flip_wq) {
+			error = -ENOMEM;
+			goto err_unreg_char;
+		}
+		for (i = 0; i < driver->num; i++) {
+			if (driver->ports[i] && !driver->ports[i]->buf.flip_wq)
+				tty_port_link_driver_wq(driver->ports[i], driver);
+		}
+	}
+
 	scoped_guard(mutex, &tty_mutex)
 		list_add(&driver->tty_drivers, &tty_drivers);
 
@@ -3475,6 +3489,9 @@ int tty_register_driver(struct tty_driver *driver)
 	scoped_guard(mutex, &tty_mutex)
 		list_del(&driver->tty_drivers);
 
+	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
+		destroy_workqueue(driver->flip_wq);
+
 err_unreg_char:
 	unregister_chrdev_region(dev, driver->num);
 err:
@@ -3494,6 +3511,8 @@ void tty_unregister_driver(struct tty_driver *driver)
 				driver->num);
 	scoped_guard(mutex, &tty_mutex)
 		list_del(&driver->tty_drivers);
+	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
+		destroy_workqueue(driver->flip_wq);
 }
 EXPORT_SYMBOL(tty_unregister_driver);
 
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 5b4d5fb99..b8ca89e45 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -103,6 +103,22 @@ void tty_port_init(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_port_init);
 
+/**
+ * tty_port_link_wq - link tty_port and flip workqueue
+ * @port: tty_port of the device
+ * @flip_wq: workqueue to queue flip buffer work on
+ *
+ * Assign a specific workqueue to a certain port, instead of using the
+ * workqueue allocated in tty_register_driver when TTY_DRIVER_CUSTOM_WORKQUEUE
+ *
+ * Note tty port api will not destroy the workqueue in tty_port_destroy.
+ */
+void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
+{
+	port->buf.flip_wq = flip_wq;
+}
+EXPORT_SYMBOL(tty_port_link_wq);
+
 /**
  * tty_port_link_device - link tty and tty_port
  * @port: tty_port of the device
@@ -161,6 +177,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 		const struct attribute_group **attr_grp)
 {
 	tty_port_link_device(port, driver, index);
+	tty_port_link_driver_wq(port, driver);
 	return tty_register_device_attr(driver, index, device, drvdata,
 			attr_grp);
 }
@@ -187,6 +204,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 	struct device *dev;
 
 	tty_port_link_device(port, driver, index);
+	tty_port_link_driver_wq(port, driver);
 
 	dev = serdev_tty_port_register(port, host, parent, driver, index);
 	if (PTR_ERR(dev) != -ENODEV) {
@@ -718,6 +736,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
 		struct tty_struct *tty)
 {
 	tty->port = port;
+	tty_port_link_driver_wq(port, driver);
 	return tty_standard_install(driver, tty);
 }
 EXPORT_SYMBOL_GPL(tty_port_install);
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 31125e3be..48adcb0e8 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -34,6 +34,7 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 
 struct tty_bufhead {
 	struct tty_buffer *head;	/* Queue head */
+	struct workqueue_struct *flip_wq;
 	struct work_struct work;
 	struct mutex	   lock;
 	atomic_t	   priority;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 188ee9b76..cd93345bd 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -69,6 +69,10 @@ struct serial_struct;
  *	Do not create numbered ``/dev`` nodes. For example, create
  *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
  *	driver for a single tty device is being allocated.
+ *
+ * @TTY_DRIVER_CUSTOM_WORKQUEUE:
+ *	Do not create workqueue when tty_register_driver. Set flip buffer
+ *	workqueue by tty_port_link_wq every port.
  */
 enum tty_driver_flag {
 	TTY_DRIVER_INSTALLED		= BIT(0),
@@ -79,6 +83,7 @@ enum tty_driver_flag {
 	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
 	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
 	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
+	TTY_DRIVER_CUSTOM_WORKQUEUE	= BIT(8),
 };
 
 enum tty_driver_type {
@@ -506,6 +511,7 @@ struct tty_operations {
  * @flags: tty driver flags (%TTY_DRIVER_)
  * @proc_entry: proc fs entry, used internally
  * @other: driver of the linked tty; only used for the PTY driver
+ * @flip_wq: workqueue to queue flip buffer work on
  * @ttys: array of active &struct tty_struct, set by tty_standard_install()
  * @ports: array of &struct tty_port; can be set during initialization by
  *	   tty_port_link_device() and similar
@@ -539,6 +545,7 @@ struct tty_driver {
 	unsigned long	flags;
 	struct proc_dir_entry *proc_entry;
 	struct tty_driver *other;
+	struct workqueue_struct *flip_wq;
 
 	/*
 	 * Pointer to the tty data structures
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 332ddb936..86e01bd51 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -138,6 +138,7 @@ struct tty_port {
 					   kernel */
 
 void tty_port_init(struct tty_port *port);
+void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq);
 void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
 		unsigned index);
 struct device *tty_port_register_device(struct tty_port *port,
@@ -165,6 +166,14 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
 	return NULL;
 }
 
+/* No effect when TTY_DRIVER_CUSTOM_WORKQUEUE, as driver->flip_wq is NULL */
+static inline void tty_port_link_driver_wq(struct tty_port *port,
+					   struct tty_driver *driver)
+{
+	if (!port->buf.flip_wq)
+		port->buf.flip_wq = driver->flip_wq;
+}
+
 /* If the cts flow control is enabled, return true. */
 static inline bool tty_port_cts_enabled(const struct tty_port *port)
 {
-- 
2.34.1

