Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB61CA81;
	Thu,  2 May 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622608; cv=none; b=BMD4w9df1E0oxp8UmwC8upOmDgtBVdQwjIPKcMPgAVhwUGAcyLiARx8ptdnk1fDqOSzLGh8qXH9+BH5SfA9OnATNpQnYPfSlS9ukELrFA4Oab1GHYLLc6hOunOI0lHzEQjVGmPgA0w+fkJAqhoPDyoPtBT1O9eRPAN+0zgClEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622608; c=relaxed/simple;
	bh=IuncjCinTZcslylQsvcuG6xMFQyq83RRDqafU+ZCgxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMJvSOIZUiKTJ9NE9iSoqgSMtqO56JPONs2XulJDu03KuE3FRzRRPgkh/MEKgJeF0cfbByLyk6EAnEVGfYPYqDdnSLRaHaSj49PjhdaRO0KiBALTT2h+DHUMfG32783okTQcAZgtj7uAQaEptsuKtq19ra62hy5Zz604xQD8PQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBcfYu/h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBcfYu/h"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4266673bbso67885265ad.2;
        Wed, 01 May 2024 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714622606; x=1715227406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzB+rQYevMvBz8BfUKIQPgyqZ5Qo5yjxtUsNJAd5VcU=;
        b=JBcfYu/h5rvZPoIYuhvnqzkag3hU73o4ld4SAbonh3ToBVNdbxeSRSOVOyDKuGl5EN
         r0O3NQ0IfjPBu+x/+OMj6wIMOg9/wj2ZoLeoUIT3ZElQ/EWHW6KC7EpuyFNyD0OsyPMI
         1haqqPiCWq3lSo5oe5mdLZ382K7aBitdzGciWz80hAsnow2UmziMeMUzh2b9rqVR2JSx
         n5JO8N5Oowu5R+BesSZ536C/dO1/K80YWa14BqITL/Lj+l+tGGW3jsyx8g3DtwEGHRMD
         +BNHMIavWzYyt0Hxz/cUn+PQhjMWcfdqBG7nIHHzvNgIUF5l6G6C67Y+5bkrRaItFNGu
         B/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622606; x=1715227406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzB+rQYevMvBz8BfUKIQPgyqZ5Qo5yjxtUsNJAd5VcU=;
        b=mU2b+uGIoGwJgrSKc/yjh5ZoPdCmCZhL4lI5qxtrJDNcQvDFUNolrt9r+jINWH2WPy
         yQlT7kMbXoGjSVueNUlvOr5e2C2nm2nBAG2P2cQLB0eSSKacr++Uu+OuSaFTJzMS1Ryl
         e1bS+pi2TLxSadYtVN2OQpYdB7Q72MImg8VAHVZQpzDnUOP1w9hXCYuMHOc0prn7V+9b
         G7qTNtGcXNOtvLXO4p649KnPa2JIuYDiunSz+MjWCPIp+tWDIME1wBePAG7s0HqjYEzU
         eqOUsyZ1XPoFF/WbXRGJ+aba0x2n9CR40X/zPnOoLfnpfqIrX0UXsYpLG67fcDUFvxL2
         0S0w==
X-Forwarded-Encrypted: i=1; AJvYcCUwciB8eqfryFSmhZO+Lx1ADVTi0R7fIKBoNvnDxm+EG2z0dltyufsaIXQr539ncf97LmCNseAl4SJsdmuW7tcEml/yA/vmDZItZrkj
X-Gm-Message-State: AOJu0YwIVVozQqNvB1kRux0OPGREylRZirkSoQdNWZhToyjxnXcKfrqV
	lEA7N3qIR/Fu7obeU9HlUjFacnH5kYsFPSmx33wnG1sn9J9OmTqC1Yc1m2LclPRVndfp
X-Google-Smtp-Source: AGHT+IEgmgmDky3WRliZBT1htC7pgAKivWc36rcaCzUAStw0m/Yj4RL/HpOTXm0ONiO30QMMbkiXyA==
X-Received: by 2002:a17:902:c14c:b0:1ea:1d2:90bc with SMTP id 12-20020a170902c14c00b001ea01d290bcmr4393641plj.24.1714622605733;
        Wed, 01 May 2024 21:03:25 -0700 (PDT)
Received: from localhost ([103.192.225.104])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b001e96982c4fbsm158119plg.118.2024.05.01.21.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:03:25 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [RFC PATCH 2/2] platform/surface: aggregator: Log critical errors during SAM probing
Date: Thu,  2 May 2024 12:02:47 +0800
Message-ID: <20240502040255.655957-4-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502040255.655957-2-weifeng.liu.z@gmail.com>
References: <20240502040255.655957-2-weifeng.liu.z@gmail.com>
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

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 drivers/platform/surface/aggregator/core.c | 26 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 72a521dd729c..4e2e70f4dcf5 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -623,8 +623,10 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	acpi_status astatus;
 	int status;
 
-	if (gpiod_count(&serdev->dev, NULL) < 0)
+	if (gpiod_count(&serdev->dev, NULL) < 0) {
+		dev_err(&serdev->dev, "no GPIO found\n");
 		return -ENODEV;
+	}
 
 	status = devm_acpi_dev_add_driver_gpios(&serdev->dev, ssam_acpi_gpios);
 	if (status)
@@ -637,8 +639,11 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 
 	/* Initialize controller. */
 	status = ssam_controller_init(ctrl, serdev);
-	if (status)
+	if (status) {
+		dev_err_probe(&serdev->dev, status,
+			      "failed to initialize ssam controller\n");
 		goto err_ctrl_init;
+	}
 
 	ssam_controller_lock(ctrl);
 
@@ -663,6 +668,7 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
 	if (ACPI_FAILURE(astatus)) {
 		status = -ENXIO;
+		dev_err(&serdev->dev, "failed to setup serdev\n");
 		goto err_devinit;
 	}
 
@@ -678,16 +684,22 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	 * states.
 	 */
 	status = ssam_log_firmware_version(ctrl);
-	if (status)
+	if (status) {
+		dev_err(&serdev->dev, "failed to get firmware version\n");
 		goto err_initrq;
+	}
 
 	status = ssam_ctrl_notif_d0_entry(ctrl);
-	if (status)
+	if (status) {
+		dev_err(&serdev->dev, "failed to notify EC of entry of D0\n");
 		goto err_initrq;
+	}
 
 	status = ssam_ctrl_notif_display_on(ctrl);
-	if (status)
+	if (status) {
+		dev_err(&serdev->dev, "failed to notify EC of display on\n");
 		goto err_initrq;
+	}
 
 	status = sysfs_create_group(&serdev->dev.kobj, &ssam_sam_group);
 	if (status)
@@ -695,8 +707,10 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 
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

