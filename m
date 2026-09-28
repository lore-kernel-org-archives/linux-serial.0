Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4B4A843F
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595549; cv=none; b=mjnjjYf22uYRcEx/qMZnPj/ewy9YNL7s5e/k1fS0AlV+8Zj1QmRbHliL+3iTxLVWCDUAf0JCaPRX6PJ3/Ka2BuV54mfwE/TKRxRadPsrtFahoybPd7HLSnL7o5OviV2FiZkfKrPwWrxOT1LbCYLbWNdtiiRbDPrvr1/hRszP0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595549; c=relaxed/simple;
	bh=5TDPoWCckyGXXk+hFKWb/0f2xscKXVBZszF1X/wYCyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MilkM5kO0gLmk5G8ugSDM0tbWrYcX15n9lOG4zndUG/QA3a+jre1Vt3ar+do/BrCa/zHEOQw5UaL2dVosM28y6HOvUxyBPcX3asiIfVnsTVMCcYVvb2Ukh/dpjGrmGfAADwC4QJT93GF60IbqlnnUYe9pONg2+7BC59sMkO1DsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c5mLXwHf; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c5mLXwHf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KbbUpJOuwOGgxhXwyJHzEwOAbfFFMQsiwE9N40K7q8k=;
	b=c5mLXwHfLMTuHfMzX6NgRfrHiwuKaP/T7YlHGXENXWy3JJhdsvA5AS6c4v3pTPk5RJWWONsDF
	fWPkbSwcUVlXtQYr3mrMVwTDJN1LE+9PBRKfFJgzLUMsD4Q1MW/VdNW2OjqkfaVsBjMFcZaYvdm
	iCyFWQFwBhvj7HxjJ1eQ9cI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4htfCb0rxBzRhQs;
	Mon, 28 Sep 2026 19:26:51 +0800 (CST)
Received: from whupemk100018.china.huawei.com (unknown [7.152.184.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 11C984057F;
	Mon, 28 Sep 2026 19:38:56 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 whupemk100018.china.huawei.com (7.152.184.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 28 Sep 2026 19:38:54 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <lujialin4@huawei.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <kmehltretter@gmail.com>,
	<john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tony@atomide.com>
CC: <linux-serial@vger.kernel.org>
Subject: [PATCH -next,v3] serial: core: fix NULL/dangling port_dev on failed re-register
Date: Mon, 28 Sep 2026 19:34:56 +0800
Message-ID: <20260928113456.3118750-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework
Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
---
Changes in v3:
- Drop the already-registered port rejection: nothing in-tree can
  register the same port twice.
- Trim the comments per review.

Changes in v2:
- Drop the state slot restore from the registration error path.
- Move the port->port_dev read and the !port_dev bail in
  serial_core_unregister_port() under port_mutex.
- Reject registering a port that is already registered.
 drivers/tty/serial/serial_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..0a3dab5d556c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3358,6 +3358,7 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
+	port->port_dev = NULL;
 
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
@@ -3372,12 +3373,19 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct device *phys_dev = port->dev;
-	struct serial_port_device *port_dev = port->port_dev;
-	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+	struct serial_port_device *port_dev;
+	struct serial_ctrl_device *ctrl_dev;
 	int ctrl_id = port->ctrl_id;
 
 	guard(mutex)(&port_mutex);
 
+	/* May have never been registered. */
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

