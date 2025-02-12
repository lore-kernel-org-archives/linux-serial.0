Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AC1D86F2;
	Wed, 12 Feb 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361599; cv=none; b=Hxek5RruQAu/rCChqgGofBETksTVdwHchSjAjcLCXGFNYYAY/hVjruiLXzf+bzws+nLkR7Tk0bSEpH5SMKO8PUJhLVUDvJnAqoATFOd4hT2dkfsn1BEKXRzmU1+CWirEoj9MdShgPu+9cyf8g0eyLWl9tYJ9/BffWw8mLyeh1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361599; c=relaxed/simple;
	bh=1TphKRSQH24z/D94PUERmRCaNpsikwq0THoIo/pF8Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jd+Ka+HHTdpoUB50x5rzyGg9YDNh0Wj3IoRhhh+Gv2Um1GzyWj5n91OvixneHh270sFnnJwgzVAbMbAjxmG3uOUqpyHVO0rMsYHgbT9hZGcoAnINfbBQJC9Dl2yQBer+eFkr9zXY2Ss1/Hx9QY/m+EN4w9a0BtZjaxvW7HQMTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izZxeLCM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izZxeLCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739361599; x=1770897599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1TphKRSQH24z/D94PUERmRCaNpsikwq0THoIo/pF8Mw=;
  b=izZxeLCMw5zEa5UhBe2qb0uTwrP+99XH84DjxKZ4SPdK7VAF7q4WRD+M
   xd1EMEr3qktZJGbnG2v6jBh8Hz1VhPKYPa32Ar4b0cJQJ8ue48+TnAh+R
   1rOzyQD9csFA1nYqMylnBaY7Mr3Yv2lWPCweftuJnV7Ir3KDCrYBllxrz
   9xJlBeXWIj1bfNjkljoB+m/j6wq47iHqsYicylDgZudpvzxoZbZepOQS9
   9KGWX/Lw4cFHT+ZkICJ7q5hj/pMzuQx6Z88fF8tDsRA+f5VWKj24hq+k3
   lw+kPuH9ZgUYx3v9q7heqPvjKW+qxiiWUuZVnw1j2huaiaahOUTfcHIMR
   g==;
X-CSE-ConnectionGUID: BHIljHVzSDu974/AjEdO1g==
X-CSE-MsgGUID: gn3tY8sOSKiKaPw8RoTQzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43776906"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="43776906"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:59:58 -0800
X-CSE-ConnectionGUID: bH42X5qNTxuCxJGrA/BjJA==
X-CSE-MsgGUID: erRzaxz7R3KC1ALy7IMsyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113298008"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 12 Feb 2025 03:59:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4260D1FD; Wed, 12 Feb 2025 13:59:54 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 1/1] serial: 8250_dw: Call dw8250_quirks() conditionally
Date: Wed, 12 Feb 2025 13:59:07 +0200
Message-ID: <20250212115952.2312444-1-andriy.shevchenko@linux.intel.com>
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
Also make sure IRQ handler won't crash, it also requires driver data
to be present.

Fixes: bfd3d4a40f39 ("serial: 8250_dw: Drop unneeded NULL checks in dw8250_quirks()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502121529.f7e65d49-lkp@intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: made sure IRQ handler won't be called when no driver data provided

Note, there is no Cc: stable@ as the culprit is only in Linux Next.

 drivers/tty/serial/8250/8250_dw.c | 36 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ac3987513564..af24ec25d976 100644
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
@@ -520,7 +524,6 @@ static int dw8250_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
 	spin_lock_init(&p->lock);
-	p->handle_irq	= dw8250_handle_irq;
 	p->pm		= dw8250_do_pm;
 	p->type		= PORT_8250;
 	p->flags	= UPF_FIXED_PORT;
@@ -532,13 +535,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->data.dma.fn = dw8250_fallback_dma_filter;
-	data->pdata = device_get_match_data(p->dev);
 	p->private_data = &data->data;
 
-	data->uart_16550_compatible = device_property_read_bool(dev,
-						"snps,uart-16550-compatible");
-
 	p->mapbase = regs->start;
 	p->mapsize = resource_size(regs);
 
@@ -626,11 +624,19 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	dw8250_quirks(p, data);
+	data->uart_16550_compatible = device_property_read_bool(dev, "snps,uart-16550-compatible");
+
+	data->pdata = device_get_match_data(p->dev);
+	if (data->pdata)
+		dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
 	if (data->uart_16550_compatible)
 		p->handle_irq = NULL;
+	else if (data->pdata)
+		p->handle_irq = dw8250_handle_irq;
+
+	dw8250_setup_dma_filter(p, data);
 
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
-- 
2.45.1.3035.g276e886db78b

