Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D719D07A
	for <linux-serial@vger.kernel.org>; Sat,  4 Apr 2026 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261265; cv=none; b=e114fZ9qFF7WK0LuefP0BFupJXeRMcucm4u3uPJjdskJyuHQlP3ELvPpMwCU8nwQ6P1/z0DkS0+ikFTlM2YN2eYI/aE/g87HS7DETbyzWAXax+1Di764WhEz2j2Zmxk7v43/2uomFSLPtVQlxKGlBEQjE8zgPAv5L8RCATfoxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261265; c=relaxed/simple;
	bh=d23SS4JYDl51gvVRVxBmRbh490gs/+zf7Nk228iDvk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ6+SFe52pTj0AlF+1s2sRzfUiiKj+9bNNINnYlEF8PS0D8VgzujNFohTxKVAhzwwZ1fU/m5x/Vrdjs0cN1oontOBnQbdLujYVLvL1R2DagoZHtZdwVywxgp7KIE2dGbhqHFIr4Ttwois9OfffsSOrjtHiCqp9RgyCH6ria5zJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hMxqXADh; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hMxqXADh"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c54c68db4dso4526388eec.0
        for <linux-serial@vger.kernel.org>; Fri, 03 Apr 2026 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261262; x=1775866062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2v/+uE3FItR13RHlHLOGT8kS+I6Lrtj4w+A1WuT72k=;
        b=hMxqXADhxHEB8PpGdPLT3E9BO7OEHrvpWlZgyRi1Z2P4yHLA/qTd/aCjzL1Dc6fFZB
         konlEU2Rq7JWysWGyGFiBmz0kHvfShFp2gkJPzuPGYtBJ5wUHk5GvMiN8CNOWZUFhHjm
         bnHr67qxcR3dgctlQitioXagTk5MeQd9NKn30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261262; x=1775866062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2v/+uE3FItR13RHlHLOGT8kS+I6Lrtj4w+A1WuT72k=;
        b=IxOsdIHoYf+cNQeNJ7byBoRo+CnOhK5roAVZ7WhHHb4MJb6zY/KHTkCQZdZ7FVFnCO
         V6NTmbpzSOEOA4cw9BbtpovkHeYAw8MnrVC431O8XVqAlpyAyh6kq8l1ImXpyXsx0l4h
         /AhqOGuiq25OxSK4e7G+1wuRa6yypC1+zgBDjPVi68A2dVmGNVCOyrZg3Iona77q+vyt
         Ol70V7OHdEWvFUsDFR+yWQftzekpR/BJfvsUWkuakjZjlsuazLTUDsDdSfEHFvj2Uro6
         kZYStcmdSn+u8eOiuIDR5EVA9FhtteOHKgs//xVLE9oe77A2q55Pedgb3sDm5qYfMtvY
         DarQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKrf8OdYqZYzCIwbKzQZPhEe8hDtJ7C90Nw7F+gz+x1qHDZXFFIMbkq/nFWZ0AsZiiICIxH/nJ4/RRdAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gGwD85XVDMaBhcNGl8Piui7ZWsORETYJC7TPNuhsO2ZKvnmw
	Tsc5joX1olf2e/Gq3omUTUNjfeGilQvn0NPVXioGJzCC3YMym+l6prdPTCSklI4BMQ==
X-Gm-Gg: AeBDiev4mC2C1dDNFw9UljuED3wCwaf/0FhVLsDh6rr6oo2YZdE5qN2P9F8Sl3nEMmP
	YCrEcQGWH1VkatctuKjka6wyobfwTC7m4PwupZYO4awbNepp43xLDXqnqcpGVhfSnwVAXfqjyCy
	7lQLO5xuw/NeadvZPqUJnwxGwglT82171IeP5DbYTvhND9Gh/LpO00gOinzC6PgXIXllKZnAQow
	jaV8ywpRkYBlNTlEaTL2U/WJAVVPAbuBxgta8KlCLSQBvgpDnrtLiFxuPMQOSTYTDmEU2H9Wnj3
	X8e2+gw8AuM9MXTdxo7+pJTTiPGfxUj7E5DGHxeDvmjv3St112LnXNemH/+xbbPjDie+LchQXvl
	889zXKAkluV9qolViNXUxuLaF8uNqoPShAAAHWpeIlNSDieSqyjQgzGEd6ivqvMGXoW+8gb6Eb7
	elVrI6lJL26SunpAEqAh8wVpfdpMoPGqDbICqBErg8xwWPQsvYjvzn7iNgUiUCEjAIbcrlO/S9m
	PxXBH7X1xA=
X-Received: by 2002:a05:7300:b54b:b0:2c5:347:e628 with SMTP id 5a478bee46e88-2cbfbf77d5bmr2583156eec.21.1775261262312;
        Fri, 03 Apr 2026 17:07:42 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:41 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	bhelgaas@google.com,
	brgl@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	driver-core@lists.linux.dev,
	hkallweit1@gmail.com,
	jirislaby@kernel.org,
	joel@jms.id.au,
	kees@kernel.org,
	kuba@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	mani@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Subject: [PATCH v4 8/9] driver core: Replace dev->of_node_reused with dev_of_node_reused()
Date: Fri,  3 Apr 2026 17:05:02 -0700
Message-ID: <20260403170432.v4.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
References: <20260404000644.522677-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "of_node_reused" over to the "flags"
field so modifications are safe.

Cc: Johan Hovold <johan@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 drivers/base/core.c                      | 2 +-
 drivers/base/pinctrl.c                   | 2 +-
 drivers/base/platform.c                  | 2 +-
 drivers/net/pcs/pcs-xpcs-plat.c          | 2 +-
 drivers/of/device.c                      | 6 +++---
 drivers/pci/of.c                         | 2 +-
 drivers/pci/pwrctrl/core.c               | 2 +-
 drivers/regulator/bq257xx-regulator.c    | 2 +-
 drivers/regulator/rk808-regulator.c      | 2 +-
 drivers/tty/serial/serial_base_bus.c     | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 +-
 include/linux/device.h                   | 7 ++++---
 12 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 531f02a5469a..f12f3b53b4d0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5281,7 +5281,7 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 {
 	of_node_put(dev->of_node);
 	dev->of_node = of_node_get(dev2->of_node);
-	dev->of_node_reused = true;
+	dev_set_of_node_reused(dev);
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
 
diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index 6e250272c843..0bbc83231234 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -24,7 +24,7 @@ int pinctrl_bind_pins(struct device *dev)
 {
 	int ret;
 
-	if (dev->of_node_reused)
+	if (dev_of_node_reused(dev))
 		return 0;
 
 	dev->pins = devm_kzalloc(dev, sizeof(*(dev->pins)), GFP_KERNEL);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d44591d52e36..199e6fb25770 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -856,7 +856,7 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.parent = pdevinfo->parent;
 	pdev->dev.fwnode = pdevinfo->fwnode;
 	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
-	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
+	dev_assign_of_node_reused(&pdev->dev, pdevinfo->of_node_reused);
 
 	if (pdevinfo->dma_mask) {
 		pdev->platform_dma_mask = pdevinfo->dma_mask;
diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index b8c48f9effbf..f4b1b8246ce9 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -349,7 +349,7 @@ static int xpcs_plat_init_dev(struct dw_xpcs_plat *pxpcs)
 	 * up later. Make sure DD-core is aware of the OF-node being re-used.
 	 */
 	device_set_node(&mdiodev->dev, fwnode_handle_get(dev_fwnode(dev)));
-	mdiodev->dev.of_node_reused = true;
+	dev_set_of_node_reused(&mdiodev->dev);
 
 	/* Pass the data further so the DW XPCS driver core could use it */
 	mdiodev->dev.platform_data = (void *)device_get_match_data(dev);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index f7e75e527667..be4e1584e0af 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -26,7 +26,7 @@
 const struct of_device_id *of_match_device(const struct of_device_id *matches,
 					   const struct device *dev)
 {
-	if (!matches || !dev->of_node || dev->of_node_reused)
+	if (!matches || !dev->of_node || dev_of_node_reused(dev))
 		return NULL;
 	return of_match_node(matches, dev->of_node);
 }
@@ -192,7 +192,7 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
 	ssize_t sl;
 
-	if (!dev || !dev->of_node || dev->of_node_reused)
+	if (!dev || !dev->of_node || dev_of_node_reused(dev))
 		return -ENODEV;
 
 	sl = of_modalias(dev->of_node, str, len - 2);
@@ -254,7 +254,7 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 {
 	int sl;
 
-	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
+	if ((!dev) || (!dev->of_node) || dev_of_node_reused(dev))
 		return -ENODEV;
 
 	/* Devicetree modalias is tricky, we add it in 2 steps */
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9f8eb5df279e..1f9b669abdb0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -38,7 +38,7 @@ int pci_set_of_node(struct pci_dev *dev)
 	struct device *pdev __free(put_device) =
 		bus_find_device_by_of_node(&platform_bus_type, node);
 	if (pdev)
-		dev->bus->dev.of_node_reused = true;
+		dev_set_of_node_reused(&dev->bus->dev);
 
 	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 7754baed67f2..72963a92362a 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -39,7 +39,7 @@ static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 		 * If we got here then the PCI device is the second after the
 		 * power control platform device. Mark its OF node as reused.
 		 */
-		dev->of_node_reused = true;
+		dev_set_of_node_reused(dev);
 		break;
 	}
 
diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..40e0f1a7ae81 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -143,7 +143,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct regulator_config cfg = {};
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	dev_set_of_node_reused(&pdev->dev);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e66408f23bb6..8297d31cde9f 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -2115,7 +2115,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	int ret, i, nregulators;
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	dev_set_of_node_reused(&pdev->dev);
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index a12935f6b992..5f23284a8778 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -74,7 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
-	dev->of_node_reused = true;
+	dev_set_of_node_reused(dev);
 
 	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 2ecd049dacc2..8b9449d16324 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -593,7 +593,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 		d->gadget.max_speed = USB_SPEED_HIGH;
 	d->gadget.speed = USB_SPEED_UNKNOWN;
 	d->gadget.dev.of_node = vhub->pdev->dev.of_node;
-	d->gadget.dev.of_node_reused = true;
+	dev_set_of_node_reused(&d->gadget.dev);
 
 	rc = usb_add_gadget_udc(d->port_dev, &d->gadget);
 	if (rc != 0)
diff --git a/include/linux/device.h b/include/linux/device.h
index fca986cef2ed..8132aab17e04 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -483,6 +483,8 @@ struct device_physical_location {
  *		driver/bus sync_state() callback.
  * @DEV_FLAG_DMA_COHERENT: This particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
+ *		ancestor device.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,
@@ -492,6 +494,7 @@ enum struct_device_flags {
 	DEV_FLAG_DMA_OPS_BYPASS = 4,
 	DEV_FLAG_STATE_SYNCED = 5,
 	DEV_FLAG_DMA_COHERENT = 6,
+	DEV_FLAG_OF_NODE_REUSED = 7,
 
 	DEV_FLAG_COUNT
 };
@@ -573,8 +576,6 @@ enum struct_device_flags {
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
- * @of_node_reused: Set if the device-tree node is shared with an ancestor
- *              device.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -681,7 +682,6 @@ struct device {
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-	bool			of_node_reused:1;
 
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
@@ -715,6 +715,7 @@ __create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
 __create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
 __create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
 __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
+__create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
 
 /**
  * struct device_link - Device link representation.
-- 
2.53.0.1213.gd9a14994de-goog

