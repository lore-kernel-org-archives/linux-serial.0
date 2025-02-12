Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47D207DE3;
	Wed, 12 Feb 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360568; cv=none; b=fRbIqQx/5FI2DePYINAAKbM7TjB0fdb2J4M/+8ejgjahNyNhGxl41movdzdVnpuMv+Om083CQ+6To7RwhhbjdOcD8rwhG1oXbdFKHzVhF10ewAEa/Nbi59Sw8UBObgYx36Mp7Tm+081jBsFIdSWQavlt+cUOOHla3cfSOXwEutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360568; c=relaxed/simple;
	bh=Qr4MclPt2jNvi8MS6wyZRbwpPxzbWaldK4i16cfsStw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Klnlggytw6SusquAvCqYDpd5u29OuXGURPYOE0Wacaq23fpRgPf+gZ7xOp8u/R4m8ixdNffOLM30MROc1k8RwagjTXqdDc9I9p9XymHOfqWpBfEcBlqHnRwcOrbmsyPCxERXAMQ39rnh5VEwhpWsIHUGUjXRB5z8A2dRm4Vmm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrw5/h5R; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrw5/h5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739360567; x=1770896567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qr4MclPt2jNvi8MS6wyZRbwpPxzbWaldK4i16cfsStw=;
  b=hrw5/h5RbRy3DxtynWcUSdvJj4Iz/tb3WJItIw6YgEfrjwCTNqqvdi4q
   6S9QTPxTXTIxhJfqTV2itbDdE6j0ciqCjZ7pPNR9gip1LjCytObf7KqHw
   NFREH1n/nbeurdcQ4GGOi5mjeWCU9ljWO7j9ICz0Td8C/+5kBkh8qgALR
   9DCtkWBO24P2ICX4OSRMHayuk3IMFj8XNXb1rHDi+67LXpG5jE2JZ4j+u
   Q57kZGZnYIXzp7ZWzYxs4e+c8/1V/LERLBvkQ74fkLGzjWAPPTB9N0XYy
   qxfceu+kB+WYNM9wG6tdts5LGtKRlCpbmQOhWaiQLG7JquG9FS35rDtf2
   Q==;
X-CSE-ConnectionGUID: ek87+OELRiaUahvafPN2kg==
X-CSE-MsgGUID: scu6/njkTDytEbmEFY5ZVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57546223"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57546223"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:42:46 -0800
X-CSE-ConnectionGUID: LlNkJchiS3+gr2by8YlSIw==
X-CSE-MsgGUID: agbJnvPDQPeTifgBfu018A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="113459050"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 12 Feb 2025 03:42:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 537A41FD; Wed, 12 Feb 2025 13:42:43 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v1 1/1] serial: 8250_dw: Call dw8250_quirks() conditionally
Date: Wed, 12 Feb 2025 13:38:17 +0200
Message-ID: <20250212113817.2208483-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all the cases provide the driver data, that is represented by
an object instance of struct dw8250_platform_data. Id est the change
missed the case when the driver is instantiated via board files as
pure platform driver. Fix this by calling dw8250_quirks() conditionally.
This will require splitting dw8250_setup_dma_filter() out of dw8250_quirks().

Fixes: bfd3d4a40f39 ("serial: 8250_dw: Drop unneeded NULL checks in dw8250_quirks()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502121529.f7e65d49-lkp@intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ac3987513564..288e7826017c 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -421,6 +421,18 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev;
 }
 
+static void dw8250_setup_dma_filter(struct uart_port *p, struct dw8250_data *data)
+{
+	/* Platforms with iDMA 64-bit */
+	if (platform_get_resource_byname(to_platform_device(p->dev), IORESOURCE_MEM, "lpss_priv")) {
+		data->data.dma.rx_param = p->dev->parent;
+		data->data.dma.tx_param = p->dev->parent;
+		data->data.dma.fn = dw8250_idma_filter;
+	} else {
+		data->data.dma.fn = dw8250_fallback_dma_filter;
+	}
+}
+
 static u32 dw8250_rzn1_get_dmacr_burst(int max_burst)
 {
 	if (max_burst >= 8)
@@ -491,14 +503,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_in = dw8250_serial_in32;
 		data->uart_16550_compatible = true;
 	}
-
-	/* Platforms with iDMA 64-bit */
-	if (platform_get_resource_byname(to_platform_device(p->dev),
-					 IORESOURCE_MEM, "lpss_priv")) {
-		data->data.dma.rx_param = p->dev->parent;
-		data->data.dma.tx_param = p->dev->parent;
-		data->data.dma.fn = dw8250_idma_filter;
-	}
 }
 
 static void dw8250_reset_control_assert(void *data)
@@ -532,13 +536,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->data.dma.fn = dw8250_fallback_dma_filter;
 	data->pdata = device_get_match_data(p->dev);
 	p->private_data = &data->data;
 
-	data->uart_16550_compatible = device_property_read_bool(dev,
-						"snps,uart-16550-compatible");
-
 	p->mapbase = regs->start;
 	p->mapsize = resource_size(regs);
 
@@ -626,12 +626,16 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	dw8250_quirks(p, data);
+	data->uart_16550_compatible = device_property_read_bool(dev, "snps,uart-16550-compatible");
+	if (data->pdata)
+		dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
 	if (data->uart_16550_compatible)
 		p->handle_irq = NULL;
 
+	dw8250_setup_dma_filter(p, data);
+
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
-- 
2.45.1.3035.g276e886db78b

