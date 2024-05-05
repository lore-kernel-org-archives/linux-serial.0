Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D441865B;
	Sun,  5 May 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914526; cv=none; b=j7SVTbY5jVTYtP76aOQtWG47Cf87vGLPDE8FMdSRjNeovQe/lCiNIcHFlKtjROPXvfsjrZVE1RNWTE+MLDiKmiPvOKo5auScWQuaeqfTs9eOG9KLg9WCqaaOq2qhU8AW9DBueGaQbOTCT9J++wktbq5GWsxaep8lKIgf6ejo65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914526; c=relaxed/simple;
	bh=sVOH7kqIefk9spBKiEIryRhyEdevd4BpG5k8Xynx1kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fke8W2uFH6h09/te8KWfjUenm3dnJ7P2/FkmVPFq3dxElUaT62XodVWiCD5k2YjXIv3Wv/gXKUfrqqFKVmV5u/nwQ7aNovssdBcXQMaZo+OBiRcVk47UOxUsg0b8OZkfLxtsEMv0wx6H901tKUFKxzemzNad9ddZ5RRkQbJdol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCcAP8kq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCcAP8kq"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso1098182b3a.3;
        Sun, 05 May 2024 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714914524; x=1715519324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m19SCpad+pwGVe2Dgk1orCWukIvBUH95l2GZ5dtL9ZA=;
        b=gCcAP8kq2+RxbRjUlZpqn6aHh2Uh+i6qyqin1B9E0691Scs6rcSQqfq24NcOsKHr+K
         mjRs7gDo5CzR5JKJ3npmUiYP1t8spbzvl7g9AecvPgSIF2HIKqT6r8g2rvGJtsd+ZM6Y
         wnswxCaht5JBq+KTsoMEByih4uHBTXiiWfbc+28zDXiRO04D3M8hnMIbMKc/JztIB7x6
         hISLpqcIG9mYBDERBHSFWJUKwb04RruGxBxyxoyW3wPfTPgc8jTRhPabTUuNsn0w7Df8
         FgllHpxKy3dV8EM89TCHw83FIBH+d+3fCip4C+6VULah2OgdA7aQFjnk4w1TmgNCfkqX
         lSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714914524; x=1715519324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m19SCpad+pwGVe2Dgk1orCWukIvBUH95l2GZ5dtL9ZA=;
        b=I9OsNfJaLK6Et3+wZ+ugtmJJE7s8pZeGoHFWMSWRT8lK4e+CxuAlb2XLbIsh9iqshv
         JdbuITaKu2xqGvmprhCNmnWAFOVXzKNQzMhUXV9UtstTSL6TPb8Lzffvmu5GiiL3r4Gx
         iVVoh4+kU0JvOhmU0J9a1anylJj7KW2bKnymPXQY3I8dBoPVfSf8tBcM/VcpVeXs9/84
         K47avOVOFJd3qREhnMXD+ZOiK4gfl0+oregbG9HaHTjOlhvWnJcI+JUfr7RH+LzX6qMX
         MMNXIXivwnKJPwcvhl6p2pE+hBmv8LjfoWMkEVuByX1H4bEEh+pPttvc1DfoKOyGGQke
         BASg==
X-Forwarded-Encrypted: i=1; AJvYcCWl8dQrSGV91cG+0hnKvE64NA7Idip0Q+UioRoDtcrKesn11tSQAgGof0J8yphDffoY515RPg5ygNYTcT9MYmuK2yaBuFSM7imdBKfo
X-Gm-Message-State: AOJu0YyxIT1UPdXEWm8K9orj4TF+T8N/GFxq2Xci31r8gnknQwgHEBvE
	6ahXzMIfU0LB6lcDAYERSWNUj64WaRqoouAODiqiMSsdENU88B+xWHifGJ35lHuXUgzh
X-Google-Smtp-Source: AGHT+IH8ZJ+uUckdfqOaTzgY5D4P9m6zU5idQqNWMIlhcOt9vfsSyYL9r0iyitiOiGcr8MNV1k1NyA==
X-Received: by 2002:a05:6a20:d493:b0:1a7:aecd:997c with SMTP id im19-20020a056a20d49300b001a7aecd997cmr9768629pzb.0.1714914523785;
        Sun, 05 May 2024 06:08:43 -0700 (PDT)
Received: from localhost ([103.192.227.200])
        by smtp.gmail.com with ESMTPSA id d14-20020a63f24e000000b0060063c4be3bsm6178343pgk.14.2024.05.05.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 06:08:43 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] platform/surface: aggregator: Defer probing when serdev is not ready
Date: Sun,  5 May 2024 21:07:49 +0800
Message-ID: <20240505130800.2546640-2-weifeng.liu.z@gmail.com>
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

This is an attempt to alleviate race conditions in the SAM driver where
essential resources like serial device and GPIO pins are not ready at
the time ssam_serial_hub_probe() is called.  Instead of giving up
probing, a better way would be to defer the probing by returning
-EPROBE_DEFER, allowing the kernel try again later.

However, there is no way of identifying all such cases from other real
errors in a few days.  So let's take a gradual approach identify and
address these cases as they arise.  This commit marks the initial step
in this process.

Suggested-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 drivers/platform/surface/aggregator/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index ba550eaa06fc..7b1871eb7a6f 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -645,9 +645,22 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	/* Set up serdev device. */
 	serdev_device_set_drvdata(serdev, ctrl);
 	serdev_device_set_client_ops(serdev, &ssam_serdev_ops);
+
+	/*
+	 * The following step can fail when it's called too early before the
+	 * underlying UART device is ready (in this case -ENXIO is returned).
+	 * Instead of simply giving up and losing everything, we can defer
+	 * the probing by returning -EPROBE_DEFER so that the kernel would be
+	 * able to retry later.
+	 */
 	status = serdev_device_open(serdev);
-	if (status)
+	if (status == -ENXIO)
+		status = -EPROBE_DEFER;
+	if (status) {
+		dev_err_probe(&serdev->dev, status,
+			      "failed to open serdev device\n");
 		goto err_devopen;
+	}
 
 	astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
 	if (ACPI_FAILURE(astatus)) {
-- 
2.44.0

