Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AFDF76;
	Fri, 13 Feb 2026 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972694; cv=none; b=p+FNrQjOa/uSbvkF/ZoF88d+8Bsw28IAw0ZvB0616fW+2K47aMFS1bMdHk8zzJ9MlZeeTPTwcumHXX8gYB5D9K2RwgQIF7FE3RXs9ZlgwKlqwszjClayYnqKAOyuLJrHzwY8hOhGpWUC7u2A1uYADftsaRs/41wIVxaJW5omCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972694; c=relaxed/simple;
	bh=pGf1xMNFxHELKvc0uj8vkFMCQoqVE2rlHLFNhhZc9k4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dck60sx4GYQocQgk93DNO0Ewdt2ifYmCpY/hhvZaOl1xXLbWdDDeQLZS6KReAMf+QVOQ1c7EB0HQ1VE+5QB1/WhpwZou4XNzOq9V+r9M9WDZd5oY14c1anN26fFFTaQoCtOCoI0SvamCTQF240c4I0k+ViaCJBnHfuqb4sLnLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nRCmGjcR; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nRCmGjcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WF
	GgI0P+cTdq21jdyEC107gayMhsbk9KXpCX2oAuOUE=; b=nRCmGjcRIdEB2LWDcX
	SVeeWEDVIT9lKobawmB/IqQ1bQ80+SyTUVL6cgailXPDn0TQoRzc+ND3+m0jeKeF
	vF9AZlAs507uGzhxd//kPJV349ExAx+ccS3Iq0/5SERJOBapSbwD5cQUtOcWIOtQ
	doLuR7is+UsQEwDUX37uDa26g=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3tWXg5Y5pXSdTLQ--.33893S2;
	Fri, 13 Feb 2026 16:50:41 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	m.szyprowski@samsung.com,
	tommaso.merciai.xr@bp.renesas.com,
	geert@linux-m68k.org
Cc: hch@infradead.org,
	tj@kernel.org,
	jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v10] tty: tty_port: add workqueue to flip TTY buffer
Date: Fri, 13 Feb 2026 16:50:39 +0800
Message-Id: <20260213085039.3274704-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3tWXg5Y5pXSdTLQ--.33893S2
X-Coremail-Antispam: 1Uf129KBjvAXoWftF13KF1DWrWfZr48tFyxZrb_yoW8uFyxGo
	Z3Ww15J3Z5JryxAa4vyrnrAF1fZa9rCrW5AayUCrZ8Za40qa4Yg39rK3y5Xa4jgr18Kr15
	Z3W7J3Z7tF47Aa4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4Ro7KFUUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5wKvuWmO5eJqewAA3C

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. The tty_flip_buffer_push() interface in the TTY
layer uses system_dfl_wq to handle the flipping of the TTY buffer.
Although the unbound workqueue can create new threads on demand and wake
up the kworker thread on an idle CPU, it may be preempted by real-time
tasks or other high-prio tasks.

flush_to_ldisc() needs to wake up the relevant data handle thread. When
executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
does not disable preemption but disables migration in RT-Linux. This
prevents the kworker thread from being migrated to other cores by CPU's
balancing logic, resulting in long delays. The call trace is as follows:
    __wake_up_common_lock
    __wake_up
    ep_poll_callback
    __wake_up_common
    __wake_up_common_lock
    __wake_up
    n_tty_receive_buf_common
    n_tty_receive_buf2
    tty_ldisc_receive_buf
    tty_port_default_receive_buf
    flush_to_ldisc

In our system, the processing interval for each frame of IMU data
transmitted via UART can experience significant jitter due to this issue.
Instead of the expected 10 to 15 ms frame processing interval, we see
spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
be 2 to 3 occurrences of such high jitter, which is quite frequent. This
jitter exceeds the software's tolerable limit of 20 ms.

Introduce flip_wq in tty_port which can be set by tty_port_link_wq() or as
default linked to default workqueue allocated when tty_register_driver().
The default workqueue is allocated with flag WQ_SYSFS, so that cpumask and
nice can be set dynamically. The execution timing of tty_port_link_wq() is
not clearly restricted. The newly added function tty_port_link_driver_wq()
checks whether the flip_wq of the tty_port has already been assigned when
linking the default tty_driver's workqueue to the port. After the user has
set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
system will only use this custom workqueue, even if tty_driver does not
have %TTY_DRIVER_NO_WORKQUEUE flag. When tty_port register device, flip_wq
link operation is done by tty_port_link_driver_wq(), but for in-memory
devices the link operation cannot cover all the cases. Although
tty_port_install() is dedicated for in-memory devices lik PTY to link port
allocated on demand, the logic of tty_port_install() is so simple that
people may not call it, vc_cons[0].d->port is one such case. We check the
buf.flip_wq when flip TTY buffer, if buf.flip_wq of TTY port is NULL, use
system_dfl_wq as a backup.

To avoid naming conflict of the default tty_driver's workqueue, using
'"%s-%s", driver->name, driver->driver_name' as the workqueue name. In
cases where driver_name is not specified and therefore is NULL, the
workqueue is not created. Drivers that do not define driver_name are
potentially in-memory devices like vty, which generally do not require
special workqueue settings. Even with the combination of name and
driver_name, the workqueue names can still be duplicated, as many tty
serial drivers use "ttyS" as dev_name and "serial" as driver_name. I
modified the conflicting driver_name of these drivers by appending a
suffix of _xx based on the corresponding .c file. If this modification is
not made, it could not only lead to duplicate workqueue names but also
result in duplicate entries for the /proc/tty/driver/<driver_name> nodes.

Introduce %TTY_DRIVER_NO_WORKQUEUE flag meaning not to create the
default single tty_driver workqueue. Two reasons why need to introduce the
%TTY_DRIVER_NO_WORKQUEUE flag:
1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
fail when trying to create a workqueue with the same name. The pty is an
example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
2. Different TTY ports may be used for different tasks, which may require
separate core binding control via workqueues. In this case, the workqueue
created by default in the TTY driver is unnecessary. Enabling this flag
prevents the creation of this redundant workqueue.

After applying this patch, we can set the related UART TTY flip buffer
workqueue by sysfs. We set the cpumask to CPU cores associated with the
IMU tasks, and set the nice to -20. Testing has shown significant
improvement in the previously described issue, with almost no stuttering
occurring anymore.

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---

Change in v10:
- Modify the driver_name of several tty serial drivers to avoid duplicate
  workqueue names.

Change in v9:
- Fix 'cannot create duplicate filename' problem, when create flip_wq
  workqueue, use '"%s-%s", ... driver->name, driver->driver_name' as
  flip_wq workqueue name, as suggested by Marek Szyprowski.
  driver_name maybe NULL, do not create driver flip_wq workqueue  when
  driver_name is NULL. Drivers that do not define driver_name are
  potentially in-memory devices like vty, which generally do not require
  special workqueue settings.
- Fix 'NULL pointer panic' problem, tty_flip_buffer_push() now check
  whether buf.flip_wq is NULL, use system_dfl_wq instead if buf.flip_wq
  is NULL. Therefore, no longer need to call tty_port_link_wq() to link
  system_dfl_wq to pty ports.
- Set buf.flip_wq to NULL in tty_port_destroy() and
  tty_port_unregister_device().
- Link to v9: https://lore.kernel.org/linux-serial/20260205101948.594577-1-jackzxcui1989@163.com/

Change in v8:
- Rebase code, use system_dfl_wq instead of system_unbound_wq.
- Link to v8: https://lore.kernel.org/linux-serial/20260129103129.2928955-1-jackzxcui1989@163.com/T/#m8697be62ae18c8c7bcb677cbd96599c23b3dab4d

Change in v7:
- Pty simply link to system_unbound_wq instead of allocating a custom one,
  as suggested by Jiri Slaby.
- Modify some inappropriate expressions in the code comments,
  as suggested by Jiri Slaby.
- Link to v7: https://lore.kernel.org/all/20251210125028.4174917-1-jackzxcui1989@163.com/T/#u

Change in v6:
- Modify many inappropriate expressions in the commit log and code comments,
  as suggested by Jiri Slaby.
- Add reasons why need to introduce the %TTY_DRIVER_CUSTOM_WORKQUEUE in
  commit log.
- Modify the error handling related to the allocation failure of workqueue in
  tty_register_driver(), as suggested by Jiri Slaby.
- Add description of tty_port_link_driver_wq() in the commit log,
  as suggested by Jiri Slaby.
- Link to v6: https://lore.kernel.org/all/20251210031827.3771327-1-jackzxcui1989@163.com/

Change in v5:
- Do not allocate workqueue twice when CONFIG_UNIX98_PTYS and
  CONFIG_LEGACY_PTYS are all enabled.
- Link to v5: https://lore.kernel.org/all/20251205030829.1829987-1-jackzxcui1989@163.com/

Change in v4:
- Simplify the logic for creating and releasing the workqueue,
  as suggested by Tejun Heo.
- Allocate single workqueue of one tty_driver as default, link it to
  port when tty_port register device or tty_driver.
- Introduce tty_port_link_wq() to link specific workqueue to port.
- Add driver flag %TTY_DRIVER_CUSTOM_WORKQUEUE meaning not to create the
  default single tty_driver workqueue.
- Link to v4: https://lore.kernel.org/all/202512041303.7192024b-lkp@intel.com/T/#t

Change in v3:
- Add tty flip workqueue for all tty ports, as suggested by Greg KH.
  Every tty port use an individual flip workqueue, while all pty ports
  share the same workqueue created in pty_flip_wq_init().
- Modify the commit log to describe the reason for latency spikes in
  RT-Linux.
- Link to v3: https://lore.kernel.org/all/20251027060929.394053-1-jackzxcui1989@163.com/

Change in v2:
- Do not add new module parameters
  as suggested by Greg KH
- Set WQ_SYSFS to allow properties changes from userspace
  as suggested by Tejun Heo
- Link to v2: https://lore.kernel.org/all/20251024155534.2302590-1-jackzxcui1989@163.com
---
 drivers/tty/pty.c                   | 12 ++++++++----
 drivers/tty/serial/8250/8250_core.c |  2 +-
 drivers/tty/serial/apbuart.c        |  2 +-
 drivers/tty/serial/dz.c             |  2 +-
 drivers/tty/serial/ip22zilog.c      |  2 +-
 drivers/tty/serial/zs.c             |  2 +-
 drivers/tty/tty_buffer.c            | 15 +++++++++++----
 drivers/tty/tty_io.c                | 25 ++++++++++++++++++++++++-
 drivers/tty/tty_port.c              | 22 ++++++++++++++++++++++
 include/linux/tty_buffer.h          |  1 +
 include/linux/tty_driver.h          |  7 +++++++
 include/linux/tty_port.h            | 13 +++++++++++++
 12 files changed, 91 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 6120d827a..6c406c741 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -532,14 +532,16 @@ static void __init legacy_pty_init(void)
 	pty_driver = tty_alloc_driver(legacy_count,
 			TTY_DRIVER_RESET_TERMIOS |
 			TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_NO_WORKQUEUE);
 	if (IS_ERR(pty_driver))
 		panic("Couldn't allocate pty driver");
 
 	pty_slave_driver = tty_alloc_driver(legacy_count,
 			TTY_DRIVER_RESET_TERMIOS |
 			TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_NO_WORKQUEUE);
 	if (IS_ERR(pty_slave_driver))
 		panic("Couldn't allocate pty slave driver");
 
@@ -849,7 +851,8 @@ static void __init unix98_pty_init(void)
 			TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV |
 			TTY_DRIVER_DEVPTS_MEM |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_NO_WORKQUEUE);
 	if (IS_ERR(ptm_driver))
 		panic("Couldn't allocate Unix98 ptm driver");
 	pts_driver = tty_alloc_driver(NR_UNIX98_PTY_MAX,
@@ -857,7 +860,8 @@ static void __init unix98_pty_init(void)
 			TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV |
 			TTY_DRIVER_DEVPTS_MEM |
-			TTY_DRIVER_DYNAMIC_ALLOC);
+			TTY_DRIVER_DYNAMIC_ALLOC |
+			TTY_DRIVER_NO_WORKQUEUE);
 	if (IS_ERR(pts_driver))
 		panic("Couldn't allocate Unix98 pts driver");
 
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0e81f78c6..7a9b7005b 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -524,7 +524,7 @@ console_initcall(univ8250_console_init);
 
 struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "serial",
+	.driver_name		= "serial_8250",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 364599f25..3e46341cf 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -505,7 +505,7 @@ console_initcall(apbuart_console_init);
 
 static struct uart_driver grlib_apbuart_driver = {
 	.owner = THIS_MODULE,
-	.driver_name = "serial",
+	.driver_name = "serial_apbuart",
 	.dev_name = "ttyS",
 	.major = SERIAL_APBUART_MAJOR,
 	.minor = SERIAL_APBUART_MINOR,
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index eba91daed..e53c54353 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -914,7 +914,7 @@ console_initcall(dz_serial_console_init);
 
 static struct uart_driver dz_reg = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "serial",
+	.driver_name		= "serial_dz",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 6e19c6713..a69b06893 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -1015,7 +1015,7 @@ static struct console ip22zilog_console = {
 
 static struct uart_driver ip22zilog_reg = {
 	.owner		= THIS_MODULE,
-	.driver_name	= "serial",
+	.driver_name	= "serial_ip22zilog",
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 79ea7108a..72a3c0d90 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -1252,7 +1252,7 @@ console_initcall(zs_serial_console_init);
 
 static struct uart_driver zs_reg = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "serial",
+	.driver_name		= "serial_zs",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 1a5673acd..1a2b29135 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -59,6 +59,13 @@ void tty_buffer_lock_exclusive(struct tty_port *port)
 }
 EXPORT_SYMBOL_GPL(tty_buffer_lock_exclusive);
 
+static bool tty_buffer_queue_work(struct tty_bufhead *buf)
+{
+	struct workqueue_struct *flip_wq = READ_ONCE(buf->flip_wq);
+
+	return queue_work(flip_wq ?: system_dfl_wq, &buf->work);
+}
+
 /**
  * tty_buffer_unlock_exclusive	-	release exclusive access
  * @port: tty port owning the flip buffer
@@ -76,7 +83,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 	mutex_unlock(&buf->lock);
 
 	if (restart)
-		queue_work(system_dfl_wq, &buf->work);
+		tty_buffer_queue_work(buf);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
@@ -530,7 +537,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 
 	tty_flip_buffer_commit(buf->tail);
-	queue_work(system_dfl_wq, &buf->work);
+	tty_buffer_queue_work(buf);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -560,7 +567,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 		tty_flip_buffer_commit(buf->tail);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	queue_work(system_dfl_wq, &buf->work);
+	tty_buffer_queue_work(buf);
 
 	return size;
 }
@@ -613,7 +620,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
 
 bool tty_buffer_restart_work(struct tty_port *port)
 {
-	return queue_work(system_dfl_wq, &port->buf.work);
+	return tty_buffer_queue_work(&port->buf);
 }
 
 bool tty_buffer_cancel_work(struct tty_port *port)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70..a8674a20a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3446,10 +3446,27 @@ int tty_register_driver(struct tty_driver *driver)
 	if (error < 0)
 		goto err;
 
+	/*
+	 * Drivers that do not define driver_name are potentially in-memory devices
+	 * like vty, which generally do not require special workqueue settings.
+	 */
+	if (!(driver->flags & TTY_DRIVER_NO_WORKQUEUE) && driver->driver_name) {
+		driver->flip_wq = alloc_workqueue("%s-%s", WQ_UNBOUND | WQ_SYSFS,
+						  0, driver->name, driver->driver_name);
+		if (!driver->flip_wq) {
+			error = -ENOMEM;
+			goto err_unreg_char;
+		}
+		for (i = 0; i < driver->num; i++) {
+			if (driver->ports[i])
+				tty_port_link_driver_wq(driver->ports[i], driver);
+		}
+	}
+
 	if (driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) {
 		error = tty_cdev_add(driver, dev, 0, driver->num);
 		if (error)
-			goto err_unreg_char;
+			goto err_destroy_wq;
 	}
 
 	scoped_guard(mutex, &tty_mutex)
@@ -3475,6 +3492,10 @@ int tty_register_driver(struct tty_driver *driver)
 	scoped_guard(mutex, &tty_mutex)
 		list_del(&driver->tty_drivers);
 
+err_destroy_wq:
+	if (driver->flip_wq)
+		destroy_workqueue(driver->flip_wq);
+
 err_unreg_char:
 	unregister_chrdev_region(dev, driver->num);
 err:
@@ -3494,6 +3515,8 @@ void tty_unregister_driver(struct tty_driver *driver)
 				driver->num);
 	scoped_guard(mutex, &tty_mutex)
 		list_del(&driver->tty_drivers);
+	if (driver->flip_wq)
+		destroy_workqueue(driver->flip_wq);
 }
 EXPORT_SYMBOL(tty_unregister_driver);
 
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index fe67c5cb0..54359310e 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -99,6 +99,23 @@ void tty_port_init(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_port_init);
 
+/**
+ * tty_port_link_wq - link tty_port and flip workqueue
+ * @port: tty_port of the device
+ * @flip_wq: workqueue to queue flip buffer work on
+ *
+ * Whenever %TTY_DRIVER_NO_WORKQUEUE is used, every tty_port can be linked to
+ * a workqueue manually by this function.
+ * tty_port will use system_dfl_wq when buf.flip_wq is NULL.
+ *
+ * Note that tty_port API will NOT destroy the workqueue.
+ */
+void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
+{
+	port->buf.flip_wq = flip_wq;
+}
+EXPORT_SYMBOL_GPL(tty_port_link_wq);
+
 /**
  * tty_port_link_device - link tty and tty_port
  * @port: tty_port of the device
@@ -157,6 +174,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 		const struct attribute_group **attr_grp)
 {
 	tty_port_link_device(port, driver, index);
+	tty_port_link_driver_wq(port, driver);
 	return tty_register_device_attr(driver, index, device, drvdata,
 			attr_grp);
 }
@@ -183,6 +201,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 	struct device *dev;
 
 	tty_port_link_device(port, driver, index);
+	tty_port_link_driver_wq(port, driver);
 
 	dev = serdev_tty_port_register(port, host, parent, driver, index);
 	if (PTR_ERR(dev) != -ENODEV) {
@@ -210,6 +229,7 @@ void tty_port_unregister_device(struct tty_port *port,
 {
 	int ret;
 
+	WRITE_ONCE(port->buf.flip_wq, NULL);
 	ret = serdev_tty_port_unregister(port);
 	if (ret == 0)
 		return;
@@ -257,6 +277,7 @@ void tty_port_destroy(struct tty_port *port)
 {
 	tty_buffer_cancel_work(port);
 	tty_buffer_free_all(port);
+	WRITE_ONCE(port->buf.flip_wq, NULL);
 }
 EXPORT_SYMBOL(tty_port_destroy);
 
@@ -703,6 +724,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
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
index 188ee9b76..1f2896e56 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -69,6 +69,10 @@ struct serial_struct;
  *	Do not create numbered ``/dev`` nodes. For example, create
  *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
  *	driver for a single tty device is being allocated.
+ *
+ * @TTY_DRIVER_NO_WORKQUEUE:
+ *	Do not create workqueue when tty_register_driver(). Whenever set, flip
+ *	buffer workqueue can be set by tty_port_link_wq() for every port.
  */
 enum tty_driver_flag {
 	TTY_DRIVER_INSTALLED		= BIT(0),
@@ -79,6 +83,7 @@ enum tty_driver_flag {
 	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
 	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
 	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
+	TTY_DRIVER_NO_WORKQUEUE		= BIT(8),
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
index 660c254f1..d2a7882c0 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -138,6 +138,7 @@ struct tty_port {
 					   kernel */
 
 void tty_port_init(struct tty_port *port);
+void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq);
 void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
 		unsigned index);
 struct device *tty_port_register_device(struct tty_port *port,
@@ -165,6 +166,18 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
 	return NULL;
 }
 
+/*
+ * Never overwrite the workqueue set by tty_port_link_wq().
+ * No effect when %TTY_DRIVER_NO_WORKQUEUE is set, as driver->flip_wq is
+ * %NULL.
+ */
+static inline void tty_port_link_driver_wq(struct tty_port *port,
+					   struct tty_driver *driver)
+{
+	if (!port->buf.flip_wq)
+		tty_port_link_wq(port, driver->flip_wq);
+}
+
 /* If the cts flow control is enabled, return true. */
 static inline bool tty_port_cts_enabled(const struct tty_port *port)
 {
-- 
2.34.1

