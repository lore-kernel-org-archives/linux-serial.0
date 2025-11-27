Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83962D7DC6;
	Thu, 27 Nov 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261418; cv=none; b=epSTVL+NsqYYl+uwRlVNMTMpUg0F0yc0C7BgOG1tTm4Jod09ywCEF5qkh5G8t1Njuehsy0yAeXU+bGujLKfT/Du2KAyZB32tN90MeOzzIgmpSxwiJSLYSAzPbd9+qllZFNvqJFdgEVWz0hpVBBO6l83GC3au4NyrZtUTIKbWDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261418; c=relaxed/simple;
	bh=HNRtxNWGMAoYPgE8jAI+CQN7N4PFShztq2c7p47KbL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9DpPGtQPflkTcesrjbaQzjCCXV3zicPlFZ4f1b0Z3e6luHQ5S3L56EeqA0T1xQB47dUqCOjDaB6x7nbwlnG2hkfN/QAMlhKAIG5bQUhE15IA4efeu44jll2aW3p79673SGKpTBxZ8d694sWLdbqJ37VcGgvwuoG/iqIr8Ty46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJXkvkKQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJXkvkKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764261417; x=1795797417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNRtxNWGMAoYPgE8jAI+CQN7N4PFShztq2c7p47KbL8=;
  b=FJXkvkKQYVt1HWn1XQZNMvKyhIIsI72Jg6LhR7tkaWU8Q1xCAZLoEhrc
   9Y1sSLnrZF+JwfxevjLM3M2DVRb6MpmBTGDSUvcoE88SEr7LYm0dxFCrj
   WHpRF6ca26UsIFJOonDn1tO+0LNeyGXoSwcP4zP7gYIjgy3nCnQY4+MCX
   tF4+wBpp2/UXOUkNv9TQJiYgFRsvt2ce7fg03jADVZ34KsBjYa+3T5Hv6
   1n1MNbxR+WUm5l8YIKAuEmLY35FY1qu50K1EjFAk2wtm3dhURD2KxXef8
   UvVC1jMiA0I2WIAJCVHvt2E+Xs4y+PePDCakgE3fkqQP277KKGE365Ja7
   Q==;
X-CSE-ConnectionGUID: 23sIPgozTj2RdsEDbX/+aQ==
X-CSE-MsgGUID: HrSMaxhXSZGqqHYBP8eb2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="83703447"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="83703447"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:36:56 -0800
X-CSE-ConnectionGUID: Z0NrCnTkTry7xzr0hCMfbA==
X-CSE-MsgGUID: 4k26KqbJRiqXjMvtKhsl/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="194071977"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 27 Nov 2025 08:36:54 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 66E54A0; Thu, 27 Nov 2025 17:36:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
Date: Thu, 27 Nov 2025 17:36:50 +0100
Message-ID: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change that restores sysfs fwnode information does it only for OF cases.
Update the fix to cover all possible types of fwnodes.

Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_base_bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 22749ab0428a..8e891984cdc0 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -13,7 +13,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -60,6 +60,7 @@ void serial_base_driver_unregister(struct device_driver *driver)
 	driver_unregister(driver);
 }
 
+/* On failure the caller must put device @dev with put_device() */
 static int serial_base_device_init(struct uart_port *port,
 				   struct device *dev,
 				   struct device *parent_dev,
@@ -73,7 +74,8 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
-	device_set_of_node_from_dev(dev, parent_dev);
+
+	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
 
 	if (!serial_base_initialized) {
 		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
@@ -94,7 +96,7 @@ static void serial_base_ctrl_release(struct device *dev)
 {
 	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
 
-	of_node_put(dev->of_node);
+	fwnode_handle_put(dev_fwnode(dev));
 	kfree(ctrl_dev);
 }
 
@@ -142,7 +144,7 @@ static void serial_base_port_release(struct device *dev)
 {
 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
 
-	of_node_put(dev->of_node);
+	fwnode_handle_put(dev_fwnode(dev));
 	kfree(port_dev);
 }
 
-- 
2.50.1

