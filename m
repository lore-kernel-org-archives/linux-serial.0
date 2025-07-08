Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39A220F36;
	Tue,  8 Jul 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965117; cv=none; b=W+2OMc3/+UDycJLEz3Oe7m6NLFYJ5uIEZv3DQHYc5OKL9I+WxhdmfEh/1ej19WiJKIWyyTpOOGuaYM+Ma+sK5jnXzhXUaj5z9P9xMBLPJcMFtjUeuV/lBWRnUsIypNH1fKfAPgnDUNVBvC/wtcJ+9mAJbFw5DdzL9PGr2EoVvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965117; c=relaxed/simple;
	bh=3crF5tiVWA7WIsu4HOqTW/k1OSqDf0be25nX2X8tHXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1CvWx7yjiB2jrW0ycgBW+/aglpJcoPJtE2fvkTlaP4uRA45tu3qpjLArte68wmVuesWyn6ogzUQkq274n5Xm80hd+KHj4v3AX6ySotVytWU7bHnxd4/j051sIlx6K8CCESKNyNv5y67NRt9C6DhnV78xhtAX7XeC126q5aaFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUoRiKt3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUoRiKt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C51C4CEED;
	Tue,  8 Jul 2025 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751965116;
	bh=3crF5tiVWA7WIsu4HOqTW/k1OSqDf0be25nX2X8tHXg=;
	h=From:To:Cc:Subject:Date:From;
	b=LUoRiKt3/DE+6BT0WMVG+BUBrtVWISV6s4GbKb1K5WycDFgbbEPwaqN5ZibPSnNjP
	 y8khM9ihZ3VDg6OjMRr9VGLlXwAEJToQFbSmfX/NzaxuPa/QWpzjLC8i3ljbubx70Y
	 WDY5ZVYVZ3oYepfTC5z1g5n/kfKO/N32hPCPtUPIDh/EhSM9Nip/q56b08Zswswr9K
	 0LOjk3cU4ikBVtpKsNolIfmnbih8T+mRI9i3nS/N2oW9JQBunESiRdrs31in4WtXts
	 oe9jh3qhfhYjD6z1nPRr+OrG8+mtuaT7qF2hSTLqLlPm94/MjGLBHdnGyAtS0gGut8
	 /n9aI6xR/zvnQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZ49k-000000004BW-3nsJ;
	Tue, 08 Jul 2025 10:58:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Aidan Stewart <astewart@tektelic.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] serial: core: fix OF node leak
Date: Tue,  8 Jul 2025 10:58:17 +0200
Message-ID: <20250708085817.16070-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the OF node reference taken when initialising the
control and port devices when the devices are later released.

Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
Cc: Aidan Stewart <astewart@tektelic.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_base_bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index cb3b127b06b6..22749ab0428a 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -93,6 +94,7 @@ static void serial_base_ctrl_release(struct device *dev)
 {
 	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
 
+	of_node_put(dev->of_node);
 	kfree(ctrl_dev);
 }
 
@@ -140,6 +142,7 @@ static void serial_base_port_release(struct device *dev)
 {
 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
 
+	of_node_put(dev->of_node);
 	kfree(port_dev);
 }
 
-- 
2.49.0

