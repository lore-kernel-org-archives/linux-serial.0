Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153118C36;
	Sun,  5 May 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914530; cv=none; b=XuOnVnyA0/MCjRGFpldq9xAQMNObgOLVnFe8FPM1zhv9bTGo5Gnl5r9HNNnukWEpi97NAOLscun7hi2bOqon+E39zYENx7MsFXw80bukuLcY8vDPVsC3BzA6whCf9mgaKJakGGZ1Ln7sxVBsaKhr0XIppyOa7XKQpW6lNkwM6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914530; c=relaxed/simple;
	bh=zq43g6gAg6FMvS7N1fUSfXeG+KHgEaE4anQQnw0VFRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx0waYeCE1Vu1Hr21TKn7GoOsm9/WKrXICuLW9pnt/48wVNZcXazPR3y6ltpF6hKN+e5RnA9ijHHm/GreVGmUX/GHi1CHQ+0AwdR2mZlakE1H6Mk//kaTmySdZRl+cH0pgJfCv6WuQ/io16v3zZdwp9s7Vvi0T75aJHOcVjNKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5v5hmLL; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5v5hmLL"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2058b16d3so270257eaf.1;
        Sun, 05 May 2024 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714914527; x=1715519327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xriyLlmRhNTWVyp8sYeonBH1Bp/KhxXjUXeTasaaqA=;
        b=G5v5hmLLXIgMkhSsWplo5juiJWm77ykBu/dBYoYOmxd5+znsx4QJbQbLw46ukkJxav
         eCBdwVFglOG5BbISMkhwqwkYNQqSB3yd+m2y2RFU7HLgscgty7DEKqE0yg+4q72zvmKB
         4WtyxyR9gDIxt85JZYPAAeCsBVVmIGrV2RvOoUUKnfvIvyWRDAwzAhozJpZ9VOm8guDB
         Z+xciFT0c9TlU1f9DxUmE8K5tX5RCNo56lDK+GTLa8f+OcPI2IL0+b9sJbmEYi2szwA1
         nFXMb1g3B30/OQVRwGzBs/5qh7+Kn/n0DErtI0n3NVuVb2x+3vtXjuj/LdSuAzccBMbc
         92tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714914527; x=1715519327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xriyLlmRhNTWVyp8sYeonBH1Bp/KhxXjUXeTasaaqA=;
        b=Snk5jcjBAnvmcvrlc8FMeul1HztkYp4dGUaZYoEUF5DKj6FdOjnKJcq/DExZIDUB9y
         uKhdUKKMvcpkobIjBBY7zJ0D1UZXUWyTCSbOFoTBhW3UbnTtQ5QNY+Hnj2S+KvnHL+uZ
         89rY35QibDNCj9OP0b4djUD0heTmN9j0m9GX/876qg5EDe1SHUxpQXQARH/zTNZM6ldc
         Vef9foHDF8Cm0OaFrJkPCE6gbnq2DxLmfWTy8vysaR6zyTQ0tKbRz24+lZv5adME3WHM
         6DvGkQ0lSw7CS1UsMA7Q8b7dVX0Ol3iXZfG/4Qov9iLljtiaImGmhR/sdM9vtiXhiwhC
         l6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWdbVAeGz+ZXBBD6/zHt1QHVTBv79wyK3qKlBi/HRK00ex6hm5r5cffq1NaJvbN9dgp9P0Nk4AraxOB6cpIQgFjUGHRflATSR614UV
X-Gm-Message-State: AOJu0YydTi7FX/QJsg1FoHQ5kRIiN/yeV19f5PYiuvUXEgUqBB4t7HXe
	Ocn92Y+kOJIcXcGq7Skusus8LYmbmJd4Fqh573UJXsR1ex+7PCS20jLmArj0r/WpoC8S
X-Google-Smtp-Source: AGHT+IG9oC3Gm1PNn3QyUlvVeLRCJloUh/6bXiz7sJ8ofFB8AP1X4Ysqr6OLLfISQk3FQ/H1Zz3LHw==
X-Received: by 2002:a05:6358:2996:b0:186:3fea:b69f with SMTP id j22-20020a056358299600b001863feab69fmr14232170rwc.21.1714914527084;
        Sun, 05 May 2024 06:08:47 -0700 (PDT)
Received: from localhost ([103.192.227.200])
        by smtp.gmail.com with ESMTPSA id h64-20020a638343000000b0061a943e043fsm5869933pge.80.2024.05.05.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 06:08:46 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] platform/surface: aggregator: Log critical errors during SAM probing
Date: Sun,  5 May 2024 21:07:50 +0800
Message-ID: <20240505130800.2546640-3-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
References: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emits messages upon errors during probing of SAM.  Hopefully this could
provide useful context to user for the purpose of diagnosis when
something miserable happen.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 drivers/platform/surface/aggregator/core.c | 42 ++++++++++++++--------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 7b1871eb7a6f..046fa63446bf 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -618,15 +618,17 @@ static const struct acpi_gpio_mapping ssam_acpi_gpios[] = {
 
 static int ssam_serial_hub_probe(struct serdev_device *serdev)
 {
-	struct acpi_device *ssh = ACPI_COMPANION(&serdev->dev);
+	struct device *dev = &serdev->dev;
+	struct acpi_device *ssh = ACPI_COMPANION(dev);
 	struct ssam_controller *ctrl;
 	acpi_status astatus;
 	int status;
 
-	if (gpiod_count(&serdev->dev, NULL) < 0)
-		return -ENODEV;
+	status = gpiod_count(dev, NULL);
+	if (status < 0)
+		return dev_err_probe(dev, status, "no GPIO found\n");
 
-	status = devm_acpi_dev_add_driver_gpios(&serdev->dev, ssam_acpi_gpios);
+	status = devm_acpi_dev_add_driver_gpios(dev, ssam_acpi_gpios);
 	if (status)
 		return status;
 
@@ -637,8 +639,11 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 
 	/* Initialize controller. */
 	status = ssam_controller_init(ctrl, serdev);
-	if (status)
+	if (status) {
+		dev_err_probe(dev, status,
+			      "failed to initialize ssam controller\n");
 		goto err_ctrl_init;
+	}
 
 	ssam_controller_lock(ctrl);
 
@@ -657,14 +662,13 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	if (status == -ENXIO)
 		status = -EPROBE_DEFER;
 	if (status) {
-		dev_err_probe(&serdev->dev, status,
-			      "failed to open serdev device\n");
+		dev_err_probe(dev, status, "failed to open serdev device\n");
 		goto err_devopen;
 	}
 
 	astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
 	if (ACPI_FAILURE(astatus)) {
-		status = -ENXIO;
+		status = dev_err_probe(dev, -ENXIO, "failed to setup serdev\n");
 		goto err_devinit;
 	}
 
@@ -680,25 +684,33 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	 * states.
 	 */
 	status = ssam_log_firmware_version(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(dev, status, "failed to get firmware version\n");
 		goto err_initrq;
+	}
 
 	status = ssam_ctrl_notif_d0_entry(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(dev, status, "D0-entry notification failed\n");
 		goto err_initrq;
+	}
 
 	status = ssam_ctrl_notif_display_on(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(dev, status, "display-on notification failed\n");
 		goto err_initrq;
+	}
 
-	status = sysfs_create_group(&serdev->dev.kobj, &ssam_sam_group);
+	status = sysfs_create_group(&dev->kobj, &ssam_sam_group);
 	if (status)
 		goto err_initrq;
 
 	/* Set up IRQ. */
 	status = ssam_irq_setup(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(dev, status, "failed to setup IRQ\n");
 		goto err_irq;
+	}
 
 	/* Finally, set main controller reference. */
 	status = ssam_try_set_controller(ctrl);
@@ -715,7 +727,7 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	 *       resumed. In short, this causes some spurious unwanted wake-ups.
 	 *       For now let's thus default power/wakeup to false.
 	 */
-	device_set_wakeup_capable(&serdev->dev, true);
+	device_set_wakeup_capable(dev, true);
 	acpi_dev_clear_dependencies(ssh);
 
 	return 0;
@@ -723,7 +735,7 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 err_mainref:
 	ssam_irq_free(ctrl);
 err_irq:
-	sysfs_remove_group(&serdev->dev.kobj, &ssam_sam_group);
+	sysfs_remove_group(&dev->kobj, &ssam_sam_group);
 err_initrq:
 	ssam_controller_lock(ctrl);
 	ssam_controller_shutdown(ctrl);
-- 
2.44.0

