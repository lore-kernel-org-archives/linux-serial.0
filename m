Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8721B299;
	Thu,  2 May 2024 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622605; cv=none; b=o51KvV+FKpvm1c5dxeP2eXeg1ucveUksC3J2NKuBmPBSmYtPDPtDwAmoO3WuMUfGe5u5w6/Vhu0/bZeRiirBwUgwd35h1a+FvZ7ll/4Wv7VX/9rri4/ZCZ0AK3qK6veUXGnlVzC/k+GJbQxAkdUq8gmATDzUSozMlGLIzMSKswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622605; c=relaxed/simple;
	bh=h7tE368ohDcwrOQAQzkVk1DtOFsO1SY5csh/GFh4Txo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhARSEuNdSjAtJOyb9wsJscXt+CYuGstts/EGZh6v18Wxky4Lc3aFgvs0Mmg0DXq+W2tBQwfsFaSUZwAPy+ha6Gf9YsniVtRW6pI4pN7B9nkTQbuSMta740Qko6083ushl4WK8hn/expBifK3nDSuGTw5POIFLkNwIWNpbvjr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaVzLHH0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaVzLHH0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4302187c0so377137b3a.1;
        Wed, 01 May 2024 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714622603; x=1715227403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnJuU2X/pt87elIj/zhh9UvoGxDEvntsc67nDMvs9CE=;
        b=CaVzLHH0f0kCdX5YuTIQmkaBhcVJ1K1uN+O9IoaojgzxpYOdU8fTIGQPbvSjPkXxUW
         ECoLc1BMZX+MaYVC9RGLehiKdQl8s/Rz/76KIrGygkpzfS5Uj51RmJO59075Ulwb9fv9
         F6BcvLMfswfb5oc2HIReam7gtN5GIVg7huYmHbNIHgvyHzacR58fB5tWMP3jVVCt2/xK
         l40wjfoyCvmUPSikYRfYemeykwgg5f4nB+aZsk4jAFPj1O3rpPmW03S3qYs1xqkLrpkh
         ANRqHGg75I5HHLNwXaOKav5bNlpGQztbI+E6uQaiIhQ4XZEqRVvyfTVYems6UyPxSvr4
         Uqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622603; x=1715227403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnJuU2X/pt87elIj/zhh9UvoGxDEvntsc67nDMvs9CE=;
        b=KLXp7XoD6EGaLw9UOeOcT9rIM5qIbDUiVBgmb74NH1Wx4nRGz6opkXAZmPuiZMM2q+
         xB4qNTiccmqDfzpLwoMU/wUqjHMLom5Iio1O5WqUjgCEtkozOjaCxA8Z/AB5FODTEkj0
         9uqK87uSIyGnCQMV5IFP5KFO6NQgOKC8ZKhzURnd9Noho7o6/zzjSgIGXHqXCv9uyPsy
         AWQiFTwknUCEe2pBzJ+xd6HXyGKk1Zov9p4AmKlt0ZvQzAZOHy58k1AYGn/eyp5o/HYp
         QXfJYt68EYAY1Z3hDi7OxMcz4RXQcO5dDJ6fEApMlrfZ2513LDiGWC4kI4JY03JJycNr
         STFw==
X-Forwarded-Encrypted: i=1; AJvYcCW3+Z0RhTiMfMERqm6KFwhUOEiWZ1TX26uAfQVf+tnZxAn9FfzNgaeYTeaPshjTxZ6oyPm2Mn9bFoMdF6oTwhSwItofCCcR6F8rOa7n
X-Gm-Message-State: AOJu0Yw1R2ZFefRNnq0x/HjmYi/+rUtrIm3j0tSeaGX04+ODCJ6boP5U
	Odb8trC8yGSloaYMKJnR8eI8zqeYLTkvEu3m8ryw5ggIDIgOtWR4wgfr2XprRhkyUWMw
X-Google-Smtp-Source: AGHT+IGn4j4g9u9/GacxiHFcbFD4eOStwgvsekoIUj48l2bfdkYOs3d5lIsT4GtBL9BSvtkTtIr7rA==
X-Received: by 2002:a05:6a20:2d23:b0:1a3:a821:f297 with SMTP id g35-20020a056a202d2300b001a3a821f297mr2373731pzl.2.1714622602952;
        Wed, 01 May 2024 21:03:22 -0700 (PDT)
Received: from localhost ([103.192.225.104])
        by smtp.gmail.com with ESMTPSA id g9-20020aa79dc9000000b006eae2d9298esm185842pfq.194.2024.05.01.21.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:03:22 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [RFC PATCH 1/2] platform/surface: aggregator: Defer probing when serdev is not ready
Date: Thu,  2 May 2024 12:02:46 +0800
Message-ID: <20240502040255.655957-3-weifeng.liu.z@gmail.com>
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
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 drivers/platform/surface/aggregator/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 9591a28bc38a..72a521dd729c 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -645,9 +645,20 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	/* Set up serdev device. */
 	serdev_device_set_drvdata(serdev, ctrl);
 	serdev_device_set_client_ops(serdev, &ssam_serdev_ops);
+
+	/* The following step can fail when it's called too early before the
+	 * underlying uart device is ready (in this case -ENXIO is returned).
+	 * Instead of simply giving up and losing everything, we can defer
+	 * the probing by returning -EPROBE_DEFER so that the kernel would be
+	 * able to retry later. */
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

