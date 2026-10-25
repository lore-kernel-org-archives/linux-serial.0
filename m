Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792893815;
	b=eITo598cnyYCvTMlFVlohXHO8XRrHgkakDepubOF9OwaksaPTzeu0wG6OQGxpXynwfKz
	 QmhJN8UO6rL73k8clMa6FGFqpvTywICZiPlZa/gFKCJxgUMtC30Ak1/P8y725YO7z9P1p
	 Jc60Q56Eh9ynRwi8sCfUwmTtAXDiqmsU8hbzqCH7gXJKx1kmeOqz+p8GssYo+Cf3YSGfL
	 lQFlVlAvTUcApfT0a38kgCchRI+8Zpp5RhG889JiysM5FBZERRec4NHT4olBH4ygO89Jz
	 hnZD4leN4IZLkIap9JRstBpwsEL1YkiSJ8Rg0Ksz7ruYEuTs04VSBkn9IxnLWznWrJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792893815;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KhbcRv2oakkY4ByxzgHw3su6e6Iys1rFr+/EFdJd8IY=;
	b=zMFAk5UDnd/duA4TLVPxykcZyk/qEa7RXucT7jh+ea70snpKxan3Ud0dwePo9xFHrq/P
	 0a2RrgJPdWhfimnBX93rWWzhzjm576yvV70JmcvyRW0pSjlv8DT2FrYnJlDIXh+jceo4f
	 MYwfqQyg0DFqw/xsZJaPPo3mTjIaPbcbR2qMze+/P6oEn1Tqd79ddif4mnIoxQnrNp4nf
	 4BHPpCcPdbQmOzn9kyqO5Ntw5WeqvoVTedhuxcnlFHAxC0JU6FS8UBTHIM5md+z/ID80Z
	 X8J5KzKzhvTyzB7UkbDH6RNiNT2Wt+loJ63xMIJWJ15HsJw7y33qa/zgSWgIux+XgJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=aNPBOUFj;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC431606A323
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC431606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=aNPBOUFj
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 49B0A3F442
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792893812;
	bh=KhbcRv2oakkY4ByxzgHw3su6e6Iys1rFr+/EFdJd8IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=aNPBOUFjX6kP94WEUeyL/GlCPLDsWxGCjUTe3ZyFioKTABD6j5YR9kVbDgkH9QjJc
	 jkJEIwEZXnNMNZUqzuoRfO09sy8gfH1yzfgm494o6Ae4rUtJ+t+VR/O7lQ6Qe6cG7R
	 UmJHA/bSEFr0R2e9EFHi4f406LbEYe6LMZ871BZIIbiKteXEqieG4AvsGTbQZMvwSQ
	 lUejO04PfVd9+EPdI7WOqEcPq7lFu5i9Fw3d+8Fj/lSHAESOK0QW5riuLx5qArPIZr
	 u0reJRqlozENO9oda6rttyTakSHd5loa9g4h5BibPqHkYUe1qJMS8rlyY0iJkUPYlk
	 Rpyk179KXNU7vzrIsFZ0VfJA4Vbzu5uIPLSL4YrQTXOvQQx4fhmdgyurOugKRhf5vp
	 hMo7Yu1qpuFR7YJht7j1radSqVUQTq8Nmo4ZFPQNsuaRySrMiaTO0EwvN3oTMQHPxx
	 r3Hv9aduIHFMt3xzkkQEiW6fy+gUqMyRNtf+4cWoR+MR7207TLAEk9Dc1gK3sLjNBg
	 2a0uXKc3ERXudrRZ3hBPzW/w5kC9qX95z8pJApMI8zqeBznFxa1zN4o6Vc1uan/qo7
	 9eamJobufSFdFsJrhGVxXXf+6BMAnGEhdLKqZdhEJiPUGfOXokHxDJNUKHl5jk+fyF
	 yz0WZvHEI4zcEsbT2OaYZwtA=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab27c28489so689439a91.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 19:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792893811; x=1793498611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KhbcRv2oakkY4ByxzgHw3su6e6Iys1rFr+/EFdJd8IY=;
        b=mo/JYf3CJ5477nQrxPsEKhInafatLTJj5N16TcjJyTp4U+j663YWfVIwsf+DES7xr3
         vmPQvs9cxRsU5JRIpk+Tb2Lpa1JKRPFySdTncmdA8RCP8VqHGMfo0c6eTsgYqD3YZ2b3
         W6zWBWQKPo72Wbd3pUwuXp6fqwPj7qsAK85eTFmhUdcnDJFAmOttbxEPzhreHhoTiuOh
         vz+/YSNIHDz8fMKaIfTZRbkIYWnNylpOgWqS4x2klQ4YjR2SLmM0kYYFpFHHgU1yWdLT
         Fpns9IZn8v/tP9/XXsjplHIu36pWmLJpRUmx/ZrHRF2Oepaic70/OpTjiGtP+Qmpj6Gp
         ktcw==
X-Gm-Message-State: AFq9FYJe2nasmb5tmRfI9xlzkEIe5gRGgUCblM35Vnh/+30b5iH12bRw
	zjE6Fv9/3pa0RuQlsxxwKGFGgqVWbuFel8IOy89809rdKHC2/WGPlo9Cd51HE7JO89SmAhxL1mc
	kXFDBS4kB1hKyw9rnAvOw6KexHvW3Ct8u1iRrpuo8vBqlTllNDy5nPjlrB3vbWiXdIs5Frl0VTc
	CCwMmgLSOaaxJjeg==
X-Gm-Gg: AYBFou27Cq6wwkjUFdbPlMbTgdMwKghpXfmll4MsE/cdyFHym0fVWZUWNzC2COTcsVz
	9kFQcOqLWA2XbLh18+bY7pDg+DMtJ3CHStyHTZPrpC6rX5aN/WzSHBsnTSn+WrEzoDYbl27ASqV
	ZTPqyHuGIgXhfKOxykH2rGDxBdN4igoXqmOLO35zX1fTO+Qfe1OcZ1+wrkW/TSH06KALJTV8dhF
	jy/IvqrFj+bdFrlgOcTpAcuJmVlvrwi6IMxG6o1WqPPTvcHyxKAWibHJ/8evoftAA+A15WKgoyq
	Utxdq704QMAEpXyn35PXHMes3+cUHKR84WlxJcyrlGMrBDZl5KebJa3SM2WRMlQveZtgaEpyPhk
	4urOVSoOOSh3BIB4jQ3p4uFQJtu6Wzzarz/P8EkaxpiZE+BdnDsblKuoyT3+w9wi8Q/2zYlUIwQ
	n1aoIme1lDNhyNG5iInsiWV6naN7oqFLNM/aXES/JlrAwStAiPI++pzO9cudyAtrI9+QvrR/1wa
	F/xruMdIrkXR8tt5DXqQHrv9gOiVkHc2bDCV4sRrQ==
X-Received: by 2002:a17:90b:3c0d:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ade9b35f05mr4793759a91.1.1792893810606;
        Sat, 24 Oct 2026 19:03:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0d:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ade9b35f05mr4793735a91.1.1792893810112;
        Sat, 24 Oct 2026 19:03:30 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-0e25-4b6d-1924-440d.dynamic-ip6.hinet.net. [2001:b011:2008:445c:e25:4b6d:1924:440d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm4226044a91.6.2026.10.24.19.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:03:29 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: [PATCH v6 1/3] serdev: handle devices without an ACPI or device tree node
Date: Sun, 25 Oct 2026 10:03:15 +0800
Message-Id: <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792856688.git.an.wu@canonical.com>
References: <cover.1792856688.git.an.wu@canonical.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Serdev clients instantiated by a driver have no ACPI companion and no
device tree node. Their modalias read returns -ENODEV, their add uevent
is suppressed, and they cannot be driver-matched, so creators force a
bind with device_driver_attach().

Resolve both TODOs in the serdev core by modelling matching on the SPI
bus: let the creator pass a modalias to serdev_device_add() and give
struct serdev_device_driver an id_table. ACPI and OF are still tried
first; clients without their own modalias keep returning -ENODEV. The
device name, derived from the controller, is unchanged.

Split struct serdev_device_id and its defines into a new
include/linux/device-id/serdev.h, following the pattern already used by
the SPI and I2C buses, and wire the new ID struct up in file2alias and
the of_table coccinelle check.

Update the existing serdev_device_add() callers to pass NULL. The two
in-tree firmware-less clients (dell-uart-backlight, yoga-tab2-pro-1380
fastcharger) also pass NULL here so the tree keeps building across the
series; the two following patches switch them to a real modalias and
drop their force_attach workarounds.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 MAINTAINERS                                   |  1 +
 .../platform/x86/dell/dell-uart-backlight.c   |  2 +-
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   |  2 +-
 .../platform/x86/x86-android-tablets/core.c   |  2 +-
 drivers/power/sequencing/pwrseq-pcie-m2.c     |  2 +-
 drivers/tty/serdev/core.c                     | 62 ++++++++++++++++---
 include/linux/device-id/serdev.h              | 19 ++++++
 include/linux/mod_devicetable.h               |  1 +
 include/linux/serdev.h                        | 11 +++-
 scripts/coccinelle/misc/of_table.cocci        | 16 ++---
 scripts/mod/devicetable-offsets.c             |  3 +
 scripts/mod/file2alias.c                      |  9 +++
 12 files changed, 108 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/device-id/serdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 917f3f72e31b..06e67aa5d9b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24905,6 +24905,7 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml
 F:	drivers/tty/serdev/
+F:	include/linux/device-id/serdev.h
 F:	include/linux/serdev.h
 F:	rust/helpers/serdev.c
 F:	rust/kernel/serdev.rs
diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index f323a667dc2d..f076cfac2bc5 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -354,7 +354,7 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
 	if (!serdev)
 		return -ENOMEM;
 
-	ret = serdev_device_add(serdev);
+	ret = serdev_device_add(serdev, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
 		serdev_device_put(serdev);
diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 8551ab4d2c7d..5e568fe1162d 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -260,7 +260,7 @@ static int yt2_1380_fc_pdev_probe(struct platform_device *pdev)
 	/* The fwnode is a managed node, so it will be auto-put on serdev_device_put() */
 	fwnode_handle_get(dev_fwnode(&serdev->dev));
 
-	ret = serdev_device_add(serdev);
+	ret = serdev_device_add(serdev, NULL);
 	if (ret) {
 		serdev_device_put(serdev);
 		return dev_err_probe(&pdev->dev, ret, "adding serdev\n");
diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index cfff7f5eac5d..853aa6ff5d50 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -317,7 +317,7 @@ static __init int x86_instantiate_serdev(const struct x86_dev_info *dev_info, in
 	ACPI_COMPANION_SET(&serdev->dev, serdev_adev);
 	acpi_device_set_enumerated(serdev_adev);
 
-	ret = serdev_device_add(serdev);
+	ret = serdev_device_add(serdev, NULL);
 	if (ret) {
 		dev_err(&serdev->dev, "error %d adding serdev\n", ret);
 		serdev_device_put(serdev);
diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e42e85f47629..e0482f2ef39f 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -309,7 +309,7 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pwrseq_pcie_m2_ctx *ctx,
 	if (ret)
 		goto err_free_serdev;
 
-	ret = serdev_device_add(pci_dev->serdev);
+	ret = serdev_device_add(pci_dev->serdev, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to add serdev for PCI device (%s): %d\n",
 			pci_name(pdev), ret);
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 7500efcdfc21..e0517d5a48da 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -29,13 +29,21 @@ static DEFINE_IDA(ctrl_ida);
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
+	const struct serdev_device *serdev = to_serdev_device(dev);
 	int len;
 
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-	return of_device_modalias(dev, buf, PAGE_SIZE);
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	if (!serdev->modalias[0])
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->modalias);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -47,15 +55,22 @@ ATTRIBUTE_GROUPS(serdev_device);
 
 static int serdev_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
+	const struct serdev_device *serdev = to_serdev_device(dev);
 	int rc;
 
-	/* TODO: platform modalias */
-
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
 
-	return of_device_uevent_modalias(dev, env);
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	if (!serdev->modalias[0])
+		return -ENODEV;
+
+	return add_uevent_var(env, "MODALIAS=%s%s", SERDEV_MODULE_PREFIX,
+			      serdev->modalias);
 }
 
 static void serdev_device_release(struct device *dev)
@@ -86,28 +101,57 @@ static const struct device_type serdev_ctrl_type = {
 	.release	= serdev_ctrl_release,
 };
 
+static const struct serdev_device_id *serdev_match_id(const struct serdev_device_id *id,
+						      const char *modalias)
+{
+	if (!id || !modalias[0])
+		return NULL;
+
+	while (id->name[0]) {
+		if (!strcmp(modalias, id->name))
+			return id;
+		id++;
+	}
+
+	return NULL;
+}
+
 static int serdev_device_match(struct device *dev, const struct device_driver *drv)
 {
+	const struct serdev_device *serdev;
+	const struct serdev_device_driver *sdrv;
+
 	if (!is_serdev_device(dev))
 		return 0;
 
-	/* TODO: platform matching */
+	serdev = to_serdev_device(dev);
+	sdrv = to_serdev_device_driver(drv);
+
 	if (acpi_driver_match_device(dev, drv))
 		return 1;
 
-	return of_driver_match_device(dev, drv);
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	return !!serdev_match_id(sdrv->id_table, serdev->modalias);
 }
 
 /**
  * serdev_device_add() - add a device previously constructed via serdev_device_alloc()
  * @serdev:	serdev_device to be added
+ * @modalias:	Driver name or alias, used to match devices which have neither
+ *		an ACPI companion nor a device tree node. NULL for devices
+ *		enumerated from firmware.
  */
-int serdev_device_add(struct serdev_device *serdev)
+int serdev_device_add(struct serdev_device *serdev, const char *modalias)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
 	struct device *parent = serdev->dev.parent;
 	int err;
 
+	if (modalias)
+		strscpy(serdev->modalias, modalias);
+
 	dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
 
 	/* Only a single slave device is currently supported. */
@@ -553,7 +597,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 
 		device_set_node(&serdev->dev, of_fwnode_handle(node));
 
-		err = serdev_device_add(serdev);
+		err = serdev_device_add(serdev, NULL);
 		if (err) {
 			dev_err(&serdev->dev,
 				"failure adding device. status %pe\n",
@@ -707,7 +751,7 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 	ACPI_COMPANION_SET(&serdev->dev, adev);
 	acpi_device_set_enumerated(adev);
 
-	err = serdev_device_add(serdev);
+	err = serdev_device_add(serdev, NULL);
 	if (err) {
 		dev_err(&serdev->dev,
 			"failure adding ACPI serdev device. status %pe\n",
diff --git a/include/linux/device-id/serdev.h b/include/linux/device-id/serdev.h
new file mode 100644
index 000000000000..96644953cece
--- /dev/null
+++ b/include/linux/device-id/serdev.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_DEVICE_ID_SERDEV_H
+#define LINUX_DEVICE_ID_SERDEV_H
+
+#ifdef __KERNEL__
+typedef unsigned long kernel_ulong_t;
+#endif
+
+/* serdev */
+
+#define SERDEV_NAME_SIZE	40
+#define SERDEV_MODULE_PREFIX	"serial:"
+
+struct serdev_device_id {
+	char name[SERDEV_NAME_SIZE];
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
+#endif /* ifndef LINUX_DEVICE_ID_SERDEV_H */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 318c4b5c3451..4cb18c41254a 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -52,6 +52,7 @@
 #include "device-id/rpmsg.h"
 #include "device-id/sdio.h"
 #include "device-id/sdw.h"
+#include "device-id/serdev.h"
 #include "device-id/serio.h"
 #include "device-id/slim.h"
 #include "device-id/spi.h"
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index b6c3d957ec15..81528c69456a 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/device-id/serdev.h>
 #include <linux/iopoll.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
@@ -35,6 +36,10 @@ struct serdev_device_ops {
  * struct serdev_device - Basic representation of an serdev device
  * @dev:	Driver model representation of the device.
  * @nr:		Device number on serdev bus.
+ * @modalias:	Name of the driver to use with this device, or the alias
+ *		for it. Empty for devices enumerated from firmware, which
+ *		are identified through their ACPI companion or their device
+ *		tree node instead. See serdev_device_add().
  * @ctrl:	serdev controller managing this device.
  * @ops:	Device operations.
  * @write_comp:	Completion used by serdev_device_write() internally
@@ -43,6 +48,7 @@ struct serdev_device_ops {
 struct serdev_device {
 	struct device dev;
 	int nr;
+	char modalias[SERDEV_NAME_SIZE];
 	struct serdev_controller *ctrl;
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
@@ -55,12 +61,15 @@ struct serdev_device {
  * struct serdev_device_driver - serdev slave device driver
  * @driver:	serdev device drivers should initialize name field of this
  *		structure.
+ * @id_table:	List of serdev devices supported by this driver, used to
+ *		match devices which are not enumerated from firmware.
  * @probe:	binds this driver to a serdev device.
  * @remove:	unbinds this driver from the serdev device.
  * @shutdown:	shut down this serdev device.
  */
 struct serdev_device_driver {
 	struct device_driver driver;
+	const struct serdev_device_id *id_table;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
 	void	(*shutdown)(struct serdev_device *);
@@ -158,7 +167,7 @@ static inline void serdev_controller_put(struct serdev_controller *ctrl)
 }
 
 struct serdev_device *serdev_device_alloc(struct serdev_controller *);
-int serdev_device_add(struct serdev_device *);
+int serdev_device_add(struct serdev_device *serdev, const char *modalias);
 void serdev_device_remove(struct serdev_device *);
 
 struct serdev_controller *serdev_controller_alloc(struct device *host,
diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 17881cb0884b..3b6dc2c13703 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-/// Make sure (of/i2c/platform/spi)_device_id tables are NULL terminated
+/// Make sure (of/i2c/platform/serdev/spi)_device_id tables are NULL terminated
 //
-// Keywords: of_table i2c_table platform_table
+// Keywords: of_table i2c_table platform_table serdev_table
 // Confidence: Medium
 // Options: --include-headers
 
@@ -15,14 +15,14 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
 *	}
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_device_id \| spi_device_id\) arr[] = {
 	...,
 *	{ ..., E, ... },
 };
@@ -33,7 +33,7 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -42,7 +42,7 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\)
 +	{ }
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_device_id \| spi_device_id\) arr[] = {
 	...,
 	{ ..., E, ... },
 +	{ },
@@ -55,7 +55,7 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -63,7 +63,7 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\)
 	@p1
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| serdev_device_id \| spi_device_id\) arr[] = {
 	...,
 	{ ..., E, ... }
 	@p1
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 1492e9fdc7cb..522bea285c7a 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -158,6 +158,9 @@ int main(void)
 	DEVID_FIELD(slim_device_id, manf_id);
 	DEVID_FIELD(slim_device_id, prod_code);
 
+	DEVID(serdev_device_id);
+	DEVID_FIELD(serdev_device_id, name);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 980d7da456bb..552847deab94 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -886,6 +886,14 @@ static void do_slim_entry(struct module *mod, void *symval)
 	module_alias_printf(mod, false, "slim:%x:%x:*", manf_id, prod_code);
 }
 
+/* Looks like: serial:S */
+static void do_serdev_entry(struct module *mod, void *symval)
+{
+	DEF_FIELD_ADDR(symval, serdev_device_id, name);
+
+	module_alias_printf(mod, false, SERDEV_MODULE_PREFIX "%s", *name);
+}
+
 /* Looks like: spi:S */
 static void do_spi_entry(struct module *mod, void *symval)
 {
@@ -1500,6 +1508,7 @@ static const struct devtable devtable[] = {
 	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
 	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
 	{"i3c", SIZE_i3c_device_id, do_i3c_entry},
+	{"serdev", SIZE_serdev_device_id, do_serdev_entry},
 	{"slim", SIZE_slim_device_id, do_slim_entry},
 	{"spi", SIZE_spi_device_id, do_spi_entry},
 	{"dmi", SIZE_dmi_system_id, do_dmi_entry},
-- 
2.34.1

