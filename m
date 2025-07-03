Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB52E2EED
	for <linux-serial@vger.kernel.org>; Thu,  3 Jul 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542073; cv=none; b=GC9orW+/dVWo98iq3sRLb8L39v807UOROY+dd0fKs4nIN4gdgJfhy4YhQxqfpy26wAVMlWXQPNFzirIK8pqqKnEmeqMwkNUrzLn+FhHCtl5QO/heRibklMURYSKASKGEfKWjIDLtIRjxfwVictmWA5mY7m4fJkJKl9sPCONUH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542073; c=relaxed/simple;
	bh=VFHVp92oUtdD8O/al59Afa61BRyaZZLLREdoqIPcQBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbuJWK3MeFQRlmlN5vf1sIBf9OjZKVWIA75VaWpSGF6XVIT4tKjfzD4CukJxEQ9x4VfuHDPENhlXBccANOHSMI6skXGoaUyWTM1A/CPk3tQIHa3rLB7ICduTJk86eoRsWbOGrR1LTBFVR7crJZ2/wO7/lMZ3XtjUie3u9hZhDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ce9zA/zE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ce9zA/zE"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo9718541a12.3
        for <linux-serial@vger.kernel.org>; Thu, 03 Jul 2025 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751542067; x=1752146867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00v7jImDBQ2eMu0i8J3EDPnWwIf7Eay4sawX2tdcIjU=;
        b=ce9zA/zEvvLqxk6gQN2n3Y1W4udkQvyd342x9EDUA/DKO4eeV4d+878b9lbaVA6P3V
         GPqS+Nr3UGfqjvK20PED5zHJjbnopkb/qAmi+Lq1ppJcsqlPQ8+p99FZHpgI21JUBxZX
         yUETSH2XYRlIBx/nMBZGMbnceR0jwjDGC158FKNSQmPvBeUTfq+lvw1s9v8Pc8R+97oC
         d6Y3HWPjpzeghPM/Ha+EncWl9K7tjDpLQrto5XP2JcItmnkA2jM0KzU74/ALQ3nrXo/2
         Dgu48ckltY1MjfnQ4Kl9t0dkofDf1YDvo06SZx39+8LsrQihhuLO0f8/JodmAGBbFMsp
         HLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751542067; x=1752146867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00v7jImDBQ2eMu0i8J3EDPnWwIf7Eay4sawX2tdcIjU=;
        b=m5+2H82QVWLqKzfjZrOxUIUjyfpy+FC4GTp9oI28CvRhWP8QBDe9nNiktSfUMKyt4m
         pMld/VN6ml5lukIFY/3unrr8q6RjMgiYz+KhNxnDDVoabF8KYcXA/39NXRaFzwSaHg97
         t4sFSFotaH7kiGUuQQKfxpd3VEPhDs2BHxa8TFNYDhFOZ9+o0qDcz+mIu+IJHZJ/CsGk
         t/XOakW1iegossqs0wgh5I/hUwkCKzV7aYE28ZFbyvEzcLaw3lVAY+iX1SnsxWAFxD22
         cKQT8PEtBQPJtlsxRrcUU9zi7pmctEPUi6tIwb+/rOOmk9Z2v+7cB2dqNqCr5RjcXfPT
         tObw==
X-Forwarded-Encrypted: i=1; AJvYcCXtTMwXz2RX2HVEGG1iuOiySqEJR6nWUAN8znzv2qYZJBSxOG6zepoun7GWTp08AmSRoSErNkRW1yWI/XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rSSwbP/5a8gOW3mqbmDITZD9J0yFRVCt3dwj4m+qP1qh9SFG
	8VtvVpnDiBjCG+Wxd0H1us0qq2wVi2vXXh+1iZFCuNJcy/FtdkSd+5Zv60n0E9R3Ru8=
X-Gm-Gg: ASbGncuJbMGbfLFjH7f3iakntNdxYVTR/v2lIXikKFgT2b9/rytFGTueyz+2os1tpFr
	8czdeThzCUIrQ0Dd4BtltpMaOZ85L5HmUtzNG9J7eLThUEz9H134+cP48az/BO57qkNMGqyCLEP
	x7Wy9qrV+uYoq2bwD8yHWBcfmT51Gb17oCwAZdxXcakVi4X5BUmNNNKTWqXIEI380ib3qj93WMd
	vjho9Az2gmzzh6Lb418gXIofeUY7OC+htUJSiKmuTPw15KXq10Nv6WnxhqJABYRBKKMJr7Hq2Tx
	SOpzgTJiIzCbvLJ+OMxGsx0fl5GUOuo47iGSKAbE0U7bQ0go1y0BZqIK7Rgc3MJ1P09KHVBT1KQ
	N7BMlSe8MKhYq7Gg=
X-Google-Smtp-Source: AGHT+IEGjD3eSI1D9oPtbbf+Qd+7ik/ERcGzIN30TUY3t1ZpkWKdf4ycZcaIs03RCZW44chHMZB55g==
X-Received: by 2002:a17:907:d8a:b0:ade:4121:8d3d with SMTP id a640c23a62f3a-ae3c2b3bf4amr586271766b.12.1751542066863;
        Thu, 03 Jul 2025 04:27:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a75fsm1247016966b.67.2025.07.03.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:27:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	mathieu.poirier@linaro.org,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	robh@kernel.org,
	jirislaby@kernel.org,
	saravanak@google.com,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 1/3] PM: domains: Add flags to specify power on attach/detach
Date: Thu,  3 Jul 2025 14:27:06 +0300
Message-ID: <20250703112708.1621607-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Calling dev_pm_domain_attach()/dev_pm_domain_detach() in bus driver
probe/remove functions can affect system behavior when the drivers attached
to the bus use devres-managed resources. Since devres actions may need to
access device registers, calling dev_pm_domain_detach() too early, i.e.,
before these actions complete, can cause failures on some systems. One such
example is Renesas RZ/G3S SoC-based platforms.

If the device clocks are managed via PM domains, invoking
dev_pm_domain_detach() in the bus driver's remove function removes the
device's clocks from the PM domain, preventing any subsequent
pm_runtime_resume*() calls from enabling those clocks.

The second argument of dev_pm_domain_attach() specifies whether the PM
domain should be powered on during attachment. Likewise, the second
argument of dev_pm_domain_detach() indicates whether the domain should be
powered off during detachment.

Upcoming commits address the issue described above (initially for the
platform bus only) by deferring the call to dev_pm_domain_detach() until
after devres_release_all() in device_unbind_cleanup(). The detach_power_off
field in struct dev_pm_info stores the detach power off info from the
second argument of dev_pm_domain_attach().

Because there are cases where the device's PM domain power-on/off behavior
must be conditional (e.g., in i2c_device_probe()), the patch introduces
PD_FLAG_ATTACH_POWER_ON and PD_FLAG_DETACH_POWER_OFF flags to be passed to
dev_pm_domain_attach().

Finally, dev_pm_domain_attach() and its users are updated to use the newly
introduced PD_FLAG_ATTACH_POWER_ON and PD_FLAG_DETACH_POWER_OFF macros.

This is a preparatory commit.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none; this patch is new

 drivers/amba/bus.c                       |  4 ++--
 drivers/base/auxiliary.c                 |  2 +-
 drivers/base/platform.c                  |  2 +-
 drivers/base/power/common.c              |  6 +++---
 drivers/clk/qcom/apcs-sdx55.c            |  2 +-
 drivers/gpu/drm/display/drm_dp_aux_bus.c |  2 +-
 drivers/i2c/i2c-core-base.c              |  2 +-
 drivers/mmc/core/sdio_bus.c              |  2 +-
 drivers/rpmsg/rpmsg_core.c               |  2 +-
 drivers/soundwire/bus_type.c             |  2 +-
 drivers/spi/spi.c                        |  2 +-
 drivers/tty/serdev/core.c                |  2 +-
 include/linux/pm_domain.h                | 10 ++++++++--
 13 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 71482d639a6d..74e34a07ef72 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -138,7 +138,7 @@ static int amba_read_periphid(struct amba_device *dev)
 	void __iomem *tmp;
 	int i, ret;
 
-	ret = dev_pm_domain_attach(&dev->dev, true);
+	ret = dev_pm_domain_attach(&dev->dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret) {
 		dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
 		goto err_out;
@@ -291,7 +291,7 @@ static int amba_probe(struct device *dev)
 		if (ret < 0)
 			break;
 
-		ret = dev_pm_domain_attach(dev, true);
+		ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 		if (ret)
 			break;
 
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index dba7c8e13a53..44cd3f85b659 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -217,7 +217,7 @@ static int auxiliary_bus_probe(struct device *dev)
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret) {
 		dev_warn(dev, "Failed to attach to PM Domain : %d\n", ret);
 		return ret;
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 075ec1d1b73a..df1ec34fdf56 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1396,7 +1396,7 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
+	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		goto out;
 
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 781968a128ff..fecb85fa85ac 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
 /**
  * dev_pm_domain_attach - Attach a device to its PM domain.
  * @dev: Device to attach.
- * @power_on: Used to indicate whether we should power on the device.
+ * @flags: indicate whether we should power on/off the device on attach/detach
  *
  * The @dev may only be attached to a single PM domain. By iterating through
  * the available alternatives we try to find a valid PM domain for the device.
@@ -100,14 +100,14 @@ EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
  * Returns 0 on successfully attached PM domain, or when it is found that the
  * device doesn't need a PM domain, else a negative error code.
  */
-int dev_pm_domain_attach(struct device *dev, bool power_on)
+int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
 	int ret;
 
 	if (dev->pm_domain)
 		return 0;
 
-	ret = acpi_dev_pm_attach(dev, power_on);
+	ret = acpi_dev_pm_attach(dev, !!(flags & PD_FLAG_ATTACH_POWER_ON));
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
diff --git a/drivers/clk/qcom/apcs-sdx55.c b/drivers/clk/qcom/apcs-sdx55.c
index 3ba01622d8f0..90dd1f1855c2 100644
--- a/drivers/clk/qcom/apcs-sdx55.c
+++ b/drivers/clk/qcom/apcs-sdx55.c
@@ -111,7 +111,7 @@ static int qcom_apcs_sdx55_clk_probe(struct platform_device *pdev)
 	 * driver, there seems to be no better place to do this. So do it here!
 	 */
 	cpu_dev = get_cpu_device(0);
-	ret = dev_pm_domain_attach(cpu_dev, true);
+	ret = dev_pm_domain_attach(cpu_dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret) {
 		dev_err_probe(dev, ret, "can't get PM domain: %d\n", ret);
 		goto err;
diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index 7b9afcf48836..2d279e82922f 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -58,7 +58,7 @@ static int dp_aux_ep_probe(struct device *dev)
 		container_of(aux_ep, struct dp_aux_ep_device_with_data, aux_ep);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to attach to PM Domain\n");
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 2ad2b1838f0f..38eabf1173da 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -573,7 +573,7 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on);
+	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
 	if (status)
 		goto err_clear_wakeup_irq;
 
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index b66b637e2d57..656601754966 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -161,7 +161,7 @@ static int sdio_bus_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
-	ret = dev_pm_domain_attach(dev, false);
+	ret = dev_pm_domain_attach(dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 6ee36adcbdba..bece5e635ee9 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -479,7 +479,7 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, true);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (err)
 		goto out;
 
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 75d6f16efced..bc1e653080d9 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -101,7 +101,7 @@ static int sdw_drv_probe(struct device *dev)
 	/*
 	 * attach to power domain but don't turn on (last arg)
 	 */
-	ret = dev_pm_domain_attach(dev, false);
+	ret = dev_pm_domain_attach(dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1bc0fdbb1bd7..8200b47b2295 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -427,7 +427,7 @@ static int spi_probe(struct device *dev)
 	if (spi->irq < 0)
 		spi->irq = 0;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return ret;
 
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 0213381fa358..d16c207a1a9b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -399,7 +399,7 @@ static int serdev_drv_probe(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 0b18160901a2..62a35a78ce9b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -36,10 +36,16 @@
  *				isn't specified, the index just follows the
  *				index for the attached PM domain.
  *
+ * PD_FLAG_ATTACH_POWER_ON:	Power on the domain during attach.
+ *
+ * PD_FLAG_DETACH_POWER_OFF:	Power off the domain during detach.
+ *
  */
 #define PD_FLAG_NO_DEV_LINK		BIT(0)
 #define PD_FLAG_DEV_LINK_ON		BIT(1)
 #define PD_FLAG_REQUIRED_OPP		BIT(2)
+#define PD_FLAG_ATTACH_POWER_ON		BIT(3)
+#define PD_FLAG_DETACH_POWER_OFF	BIT(4)
 
 struct dev_pm_domain_attach_data {
 	const char * const *pd_names;
@@ -501,7 +507,7 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-int dev_pm_domain_attach(struct device *dev, bool power_on);
+int dev_pm_domain_attach(struct device *dev, u32 flags);
 struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
@@ -518,7 +524,7 @@ int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
 #else
-static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
+static inline int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
 	return 0;
 }
-- 
2.43.0

