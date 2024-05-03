Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6DD29E;
	Fri,  3 May 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705812; cv=none; b=Vvny3VNvG5yPkleMaT+JZ4AGogzsvMqExeyLytfIeYm1fXS6Fi642wxVXzyFLOo7eRO9yVeQxE4g7/KdJwFP6YFLD1dD9VtpUaC4/tzHvw49u9pna2I5vJCECGfamPIV5phduPRCCNezfIOrRGmP5nCGVXOJy5/iMVj9uqloUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705812; c=relaxed/simple;
	bh=kJ3ojKJAVBcz2RiA3BFjiDMat6Xto/qsEw0mYP6/uZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQeTufRhRmGDIfKYmxHI25emejYpDldEMTiq2zeZqBwuyu2WRbIulKFynP/rRiwIFp//LJh9YGFqku7MYZiSCQv6KArVw3WQDJlnbMb6E9YhE+fuBzgYmz0rGTa1yJNlstquP11XIHgl8TiWlwav6u5Hr78W/hngWkdrpLt0woQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcO72kla; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcO72kla"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e5715a9ebdso73831745ad.2;
        Thu, 02 May 2024 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714705810; x=1715310610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRq8CUSvJnsXeuAcvVriayUMzf92ciMQ2l30uycbhdU=;
        b=LcO72klaAbBDw511hlInUDvK564eNZc7OlJzyQOiwNXlUYp7O4ktT8qeuKc4SwaWO+
         79ld34Y69xoQoLkrU4geUYcTgWcmHap9xOWQRF31y07Jg0y33gIroBsBJyA3o46S17UB
         M/3Zm9o7w6EDU7wdNjX41LRi3Cdeist7BvxYpjfn0vD6OCgImhfcKcbwrj0PbHOqz7mk
         6HdxKHIKsZAkFIBsP9+pYfCR4emmfMVX/LkSx3u0A5BWh92JQcZOCKmUm+1OLI9PKUvK
         r7Xtz9MRv8ej6xBsPFwmq97EEr7CiJLIgWU32WjKGAX8LhCPLJ+eR7lAdizzr5B6jJB1
         vDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714705810; x=1715310610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRq8CUSvJnsXeuAcvVriayUMzf92ciMQ2l30uycbhdU=;
        b=rx/1rIjg5sQ6jWmRRqwHpLFmjTugccsnl4XjPPRG5WnLfTZ60I/j7zBG8acK59ovfV
         RFXJyoAY3R+yVwVmCQCV5U1/aJ1epGbhkDLrknFAeCOJvbVwR6On4BpxW4H9d5xj0LGA
         kXGIvvafhaD9xi3icKGkzgLMpuvzCRFj5LBy/36QcNeMBEJE4i44KVGgYTchePTweCdK
         sZnjUEk90D0D0Q8ZkCTV+YgrCDitPoJvMP6x0g4rDn/IAIWHUii58PdW/coDSxjuxJe1
         PGI0gsyTyEEjZtSyK1YoGD3VNLYQX6osANYtUzPefyb3Nrktn1OuyFCOVMM7HHs+xrC0
         2ANw==
X-Forwarded-Encrypted: i=1; AJvYcCXWLxC6DQ5GVDk8oQ9N7dgU3ZmSgeBlEqtCX2kt59hYlaUCam4tYn9MzUVCNmKQorBIoHy1dkQl7KX1iFFer2rjONDEhrp9uFvM5GdV
X-Gm-Message-State: AOJu0Yz52QZ/iClIbpoq9I5mLqw1ThmAJBv69z2kmvCzSfRNScO67hUN
	E/Vphr9JiJg0qGJmuaV0KRiAce8Iy5pxat72+JGPijiZ5yYAkK/lS9E3t5sKOJSqzPZK
X-Google-Smtp-Source: AGHT+IGP4wCaT+laolf/XY16B+KqRL3WNhpXx/bBCSd0DC5Fp8Kr56Nu3+hTg3Ca48KeYvmVCwGg6A==
X-Received: by 2002:a17:903:2656:b0:1eb:632d:f622 with SMTP id je22-20020a170903265600b001eb632df622mr1379845plb.40.1714705809711;
        Thu, 02 May 2024 20:10:09 -0700 (PDT)
Received: from localhost ([103.192.225.105])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001ec636c883csm2144545plb.105.2024.05.02.20.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 20:10:09 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] platform/surface: aggregator: Log critical errors during SAM probing
Date: Fri,  3 May 2024 11:08:47 +0800
Message-ID: <20240503030900.1334763-3-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503030900.1334763-1-weifeng.liu.z@gmail.com>
References: <20240503030900.1334763-1-weifeng.liu.z@gmail.com>
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
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 drivers/platform/surface/aggregator/core.c | 32 ++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 87dea91f91fe..b3359ce13e0d 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -623,8 +623,9 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	acpi_status astatus;
 	int status;
 
-	if (gpiod_count(&serdev->dev, NULL) < 0)
-		return -ENODEV;
+	status = gpiod_count(&serdev->dev, NULL);
+	if (status < 0)
+		return dev_err_probe(&serdev->dev, status, "no GPIO found\n");
 
 	status = devm_acpi_dev_add_driver_gpios(&serdev->dev, ssam_acpi_gpios);
 	if (status)
@@ -637,8 +638,11 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 
 	/* Initialize controller. */
 	status = ssam_controller_init(ctrl, serdev);
-	if (status)
+	if (status) {
+		dev_err_probe(&serdev->dev, status,
+			      "failed to initialize ssam controller\n");
 		goto err_ctrl_init;
+	}
 
 	ssam_controller_lock(ctrl);
 
@@ -664,7 +668,8 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 
 	astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
 	if (ACPI_FAILURE(astatus)) {
-		status = -ENXIO;
+		status = dev_err_probe(&serdev->dev, -ENXIO,
+				       "failed to setup serdev\n");
 		goto err_devinit;
 	}
 
@@ -680,16 +685,25 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	 * states.
 	 */
 	status = ssam_log_firmware_version(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(&serdev->dev, status,
+			      "failed to get firmware version\n");
 		goto err_initrq;
+	}
 
 	status = ssam_ctrl_notif_d0_entry(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(&serdev->dev, status,
+			      "failed to notify EC of entry of D0\n");
 		goto err_initrq;
+	}
 
 	status = ssam_ctrl_notif_display_on(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(&serdev->dev, status,
+			      "failed to notify EC of display on\n");
 		goto err_initrq;
+	}
 
 	status = sysfs_create_group(&serdev->dev.kobj, &ssam_sam_group);
 	if (status)
@@ -697,8 +711,10 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 
 	/* Set up IRQ. */
 	status = ssam_irq_setup(ctrl);
-	if (status)
+	if (status) {
+		dev_err_probe(&serdev->dev, status, "failed to setup IRQ\n");
 		goto err_irq;
+	}
 
 	/* Finally, set main controller reference. */
 	status = ssam_try_set_controller(ctrl);
-- 
2.44.0

