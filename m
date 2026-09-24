Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615247C101
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255751; cv=none; b=u/2tGy+2ipsjMkskWTQ0E/mTJTDu3dgpxfg5JJ8uLyCEa4OsLNr4inAZQGgERl/2R/dAtL77/gv27pmFXOSoxrpDCnu/ahn0ZX42brv+ybMCSVQgS3DZnOzkrqV9cyeSkz0Fy7vWepXDh0qfRQUl/y0PjLwDyS9jm9Q3XYkFbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255751; c=relaxed/simple;
	bh=hWgIPgiBxgOsf6YXfU/k0qbmK+VY1zynuQyWF+Mv2Js=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vy1pdRqns+2TChckELjwILINPWNG7lXlFmlxOUY+dlwYNk+gsi7jeZD+BaVEbliyH7IPMgxzBJ0w1EMEvsqEjxvvrjD/X35NvvGGfPl18M45UaoDrvarehbL6q5QNexVdmERXbzh3BnQCi8YofZrVMWV/1O4FVUeRR9/vyzvmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6n3o9bZA; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6n3o9bZA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ksljnFuAce9kt687K6k+DmmVpQqGJ0Yf2dXfezzjINg=;
	b=6n3o9bZALvCA1nOfX9jymFvwOYOfa9jVw+oRf7qBTOvj00rHqFbzdUaZhi8gJx2xRjZwqgGir
	jAuHDSzrViiu0bmDEC5qsqxXiyUVz6GZgieNO76QA8+S7TF023i5E3tXtiUj2q72kBNIJcb4NkR
	mWGIwtk78s2ahd6D/lsgPys=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hrDY94gqZzpStW;
	Thu, 24 Sep 2026 21:03:41 +0800 (CST)
Received: from whupemk100018.china.huawei.com (unknown [7.152.184.13])
	by mail.maildlp.com (Postfix) with ESMTPS id B0C5A40561;
	Thu, 24 Sep 2026 21:15:41 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 whupemk100018.china.huawei.com (7.152.184.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 21:15:40 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <lujialin4@huawei.com>,
	<gongruiqi1@huawei.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <hvilleneuve@dimonoff.com>, <kmehltretter@gmail.com>,
	<john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tony@atomide.com>
CC: <linux-serial@vger.kernel.org>
Subject: [PATCH -next,v2] serial: core: fix NULL/dangling port_dev on failed re-register
Date: Thu, 24 Sep 2026 21:11:47 +0800
Message-ID: <20260924131147.1952634-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100018.china.huawei.com (7.152.184.13)

From: Cui GaoSheng <cuigaosheng1@huawei.com>

serial8250_unregister_port() removes a port and then re-registers it
against the legacy serial8250 device when that device is still
present, ignoring the return value of uart_add_one_port(). When the
re-register fails, the error path of serial_core_register_port()
removes the port device but leaves port->port_dev dangling (or NULL
if the port device allocation itself failed). serial8250 matches
ports on ->dev, so such half-registered slots still reach
serial_core_unregister_port() on the next unbind:

  Oops: general protection fault ... SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x40-0x47]
  RIP: serial_core_unregister_port+0xe5/0xa00
    serial8250_unregister_port+0x103
    serial8250_remove+0x61
    device_release_driver_internal+0x38c
    unbind_store+0xd1
    kernfs_fop_write_iter+0x329
    vfs_write+0x5d0
    ksys_write+0xf7
    do_syscall_64+0xdd
    entry_SYSCALL_64_after_hwframe+0x77

Fix the error path to clear port->port_dev, and bail out of
serial_core_unregister_port() when port_dev is NULL. Read
port->port_dev under port_mutex, like all of its writers.

Reject registering a port that is already registered: a duplicate
attempt would otherwise mark the live port dead and orphan its
serial core port device before failing in serial_core_add_one_port(),
and the port could then no longer be unregistered.

No state slot restore is needed on the error path:
serial_core_add_one_port() has no failure exit after linking
state->uart_port, so a failed registration never links the state
slot in the first place.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework
Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
---
Changes in v2:
- Drop the state slot restore from the registration error path.
- Move the port->port_dev read and the !port_dev bail in
  serial_core_unregister_port() under port_mutex.
- Reject registering a port that is already registered.
 drivers/tty/serial/serial_core.c | 37 +++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..5651313a2468 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3318,10 +3318,20 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
-	int ret;
+	int i, ret;
 
 	guard(mutex)(&port_mutex);
 
+	/*
+	 * Reject registration of a port that is already registered. Bail
+	 * out before taking any steps (UPF_DEAD, serial core devices) so
+	 * that a duplicate attempt cannot disturb the live registration.
+	 */
+	for (i = 0; i < drv->nr; i++) {
+		if (drv->state[i].uart_port == port)
+			return -EINVAL;
+	}
+
 	/*
 	 * Prevent serial_port_runtime_resume() from trying to use the port
 	 * until serial_core_add_one_port() has completed
@@ -3358,6 +3368,14 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
+	/*
+	 * serial_base_port_device_remove() dropped the last reference to
+	 * the port device, so leave no dangling ->port_dev behind. No
+	 * state slot restore is needed: serial_core_add_one_port() has no
+	 * failure exit after linking state->uart_port, so a failed
+	 * registration never links the state slot.
+	 */
+	port->port_dev = NULL;
 
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
@@ -3372,12 +3390,25 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct device *phys_dev = port->dev;
-	struct serial_port_device *port_dev = port->port_dev;
-	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+	struct serial_port_device *port_dev;
+	struct serial_ctrl_device *ctrl_dev;
 	int ctrl_id = port->ctrl_id;
 
 	guard(mutex)(&port_mutex);
 
+	/*
+	 * A port may be unregistered even though it was never successfully
+	 * registered (e.g. an allocation failure aborted serial_core_register_port()
+	 * part-way). Drivers like serial8250 remove ports matching on ->dev, so
+	 * those half-registered ports still reach us with port_dev == NULL. Read
+	 * ->port_dev under port_mutex like all of its writers.
+	 */
+	port_dev = port->port_dev;
+	if (!port_dev)
+		return;
+
+	ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+
 	port->flags |= UPF_DEAD;
 
 	serial_core_remove_one_port(drv, port);
-- 
2.43.0

