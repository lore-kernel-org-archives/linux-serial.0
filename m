Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B0C3D9029
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394148; cv=none; b=C7GsOXGqIq+AULQIixiROPqzaKh2rLMOF+shSElz38xrxseYoITp2Qn/d9FW3gVQNWgHAo+rMry7p4AiUeyuMCulx+OfX8k9W0OryFxrdMh0tDDs6EWxb3CZg1KQSvc4Qr1T8qNHnfPkuePDz3N+yNSotGOUg+cU8JiWCu5se7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394148; c=relaxed/simple;
	bh=6YFhhAHJgHPeMub/eJbrPyoZsFaSF2mpwNE00TjtPtQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CbKrEbrh50CRzKieDXGVM6imhss/GdWhm/N/sIssgw3wkfodzsT93Srv83C57rGutARDe8KZCViqd2nfDJ6exZIpmonW8hxntAco6Jb1nKMMPB4PAY7y6r31SItAAPt8ddkgoDFPJAAPbJxqNfr9AS7gsDLOZUTYCmGbZK7Y8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UUlb0O1U; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UUlb0O1U"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SnlvRJl6HCaG4U0DTK0yUJR48lDUQMQoC0wIrbEgnho=;
	b=UUlb0O1URPJ61z1tEs0Z1IbuuX3BB8KUJ36tBV/eo/PENsxbUAri9A4gg6fwso3sSpYw3fHve
	ldl0T1a55cZAmR6Vsi/jp1275Rb8N2sQFqhnJQr9Gqqvg6I+hJG4DiWdZbE6ez8JFj1xH2dmzav
	7WDQOVPEyMGNhwIArE1giPk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hk5wz3hS7z1prKW;
	Mon, 14 Sep 2026 21:44:35 +0800 (CST)
Received: from whupemk100018.china.huawei.com (unknown [7.152.184.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A7C040561;
	Mon, 14 Sep 2026 21:55:34 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 whupemk100018.china.huawei.com (7.152.184.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 14 Sep 2026 21:55:33 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <lujialin4@huawei.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <kmehltretter@gmail.com>,
	<john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tony@atomide.com>
CC: <linux-serial@vger.kernel.org>
Subject: [PATCH -next] serial: core: fix NULL/dangling port_dev on failed re-register
Date: Mon, 14 Sep 2026 21:51:54 +0800
Message-ID: <20260914135154.3260303-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100018.china.huawei.com (7.152.184.13)

From: Cui GaoSheng <cuigaosheng1@huawei.com>

serial8250_unregister_port() removes a port and then re-registers it
against the legacy serial8250 device when that device is still
present, ignoring the return value of uart_add_one_port(). When the
re-register fails, the error path of serial_core_register_port()
removes the port device but leaves port->port_dev dangling. A port
that was never successfully registered (e.g. serial_core_port_device_add()
failed) also reaches the unregister path with port->port_dev unset.
serial8250 matches ports on ->dev, so such half-registered slots
still reach serial_core_unregister_port() on the next unbind:

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

Fix the error path to clear port->port_dev and restore the state slot
(guarded by line range) to the "not registered" state, and bail out of
serial_core_unregister_port() when port_dev is NULL (either dangling
from a failed re-register or never set).

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
---
 drivers/tty/serial/serial_core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..62d93c5964e2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3358,6 +3358,17 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
+	/*
+	 * serial_base_port_device_remove() dropped the last reference to the
+	 * port device, so leave no dangling ->port_dev behind. Restore the
+	 * state slot to the same "not registered" state that
+	 * serial_core_remove_one_port() produces on the normal path; the
+	 * line range guard also covers the -EINVAL exit of
+	 * serial_core_add_one_port() where line >= drv->nr.
+	 */
+	port->port_dev = NULL;
+	if (port->line < drv->nr && drv->state[port->line].uart_port == port)
+		drv->state[port->line].uart_port = NULL;
 
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
@@ -3373,11 +3384,23 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 {
 	struct device *phys_dev = port->dev;
 	struct serial_port_device *port_dev = port->port_dev;
-	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+	struct serial_ctrl_device *ctrl_dev;
 	int ctrl_id = port->ctrl_id;
 
+	/*
+	 * A port may be unregistered even though it was never successfully
+	 * registered (e.g. an allocation failure aborted serial_core_register_port()
+	 * part-way). Drivers like serial8250 remove ports matching on ->dev, so
+	 * those half-registered ports still reach us with port_dev == NULL. Do not
+	 * dereference it.
+	 */
+	if (!port_dev)
+		return;
+
 	guard(mutex)(&port_mutex);
 
+	ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+
 	port->flags |= UPF_DEAD;
 
 	serial_core_remove_one_port(drv, port);
-- 
2.43.0

