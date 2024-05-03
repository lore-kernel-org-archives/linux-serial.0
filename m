Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1993D29E;
	Fri,  3 May 2024 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705809; cv=none; b=fcgFxem6XlUwncThQc5UaETXRseQA8n4qPP4SRD3+WUbptzKYwIoHKh8yzt9+gW4LZH/5x25X0mizaDIenRL2xW1HwxtlkpSaG/Ve3NCoUN7kEV22waRUNWXLVBKFM8iBBtbEfeW+LrHjeblsIf4KArifLCT/UvWqVsMl+nYU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705809; c=relaxed/simple;
	bh=ZFy7RV/qnZ66bkbISNuDnLepsQnte6ofUaeUDWaTynQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7Q069mO1bGTmBHLFN3PMKxohGsnYgNAJG8YOyJXA34MMUoGDHyneToQji1gGVEljbNTNLQHWwlme1fCBCwV1lWYz3SIP7hcWBUOMoGBh9bSmmJ/EOWlp8uKnQSERCmthyrGNGIF6M2tmbq2PuesdEXw3NLczNxOmGhas2McxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcQR8ny5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcQR8ny5"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so8571978b3a.2;
        Thu, 02 May 2024 20:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714705807; x=1715310607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFVpLCD9T2vg2E3o/Ee50coJimYg2ObSiJNkZ9oPXcc=;
        b=lcQR8ny5hCFf5VS8zWusikys+h4Iv2gBsSp86xFcqLZoB90pfBqG2P33wq/iJTHM0K
         ALStFXUI7YyQR28Z5Ez7HuM2fsX3GndF5ROmX7jRc11hMlCfKSyD4Jr8dhjLJdyjYDe3
         +omGIvB2Ef2ZOv2Fb9tDBAe6S552A28YMsF2RCZBIlpRwKH6ocqojtgX9pcu0yq0YSVS
         NaIzTVs9CYkIarGBf11tp2zPf9YG02dJ/5Syad5l2izdlkxlzGrNPAIwri7lQkcVZV57
         h4QCk6s6wjB/GOeK0GWaNuCbLkwlwp7vSgRFBDC7DLAPJ+A3WJaojENo1pHQAF1Pzeam
         S63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714705807; x=1715310607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFVpLCD9T2vg2E3o/Ee50coJimYg2ObSiJNkZ9oPXcc=;
        b=fB0HHtnzHeo0I3lYA09b4pOmAkHpdRzUdG1XvWgL1sien5bLNknniuo1hcRlvRznB7
         IrwQwo+fejE3HcSZqJ2Y3JLamFWvmDz4IAW/u287bQa3T2g77IUcVCQiwe8OShxjODwi
         PzxmQ8ZbizMCt9C972hXuGQdscH0rphfUw6nYP7gnBeaTV5mSjWMO75MZy+5YSnMzm0t
         9BpwJuZJvzrh4SpEoAmXaSD78T1pmCr6ELACb93vKDcfKmpZatIrCrcfxDISOG/nLCob
         zTwxvx8PpfD/V34vzBWZhYdAzI90e/NN14En+JV9L5cFwAmZeBJPAz8rBpk/zetWTX3W
         EsAg==
X-Forwarded-Encrypted: i=1; AJvYcCVX1AL1sT9tKWfgWypwhi/eytZcXQ+3EEfGC0Y12ROmXkFrHcCYo0urZN5wQvwUVX1kEIVcMnHelsKo+Npne0uDPHRMiWd5Y8eaJ3jL
X-Gm-Message-State: AOJu0Yz5kdqf7U+5wHYFdXY/fI+W3d1LcTl9zWKlC3cGlMcewL5vbQUC
	Ot6oeM+knhIRKuHgekhGqirbSancGUYrxwloyuWB0XHd8NVUaKhLA5tCLeFbp6nO9RJn
X-Google-Smtp-Source: AGHT+IGqdK8qqaQwNL0AiGoaPP3gC77Kp51AD73CK2qBJq3tnPPtvpj3b10emMVBKvO89Yg9LjByIQ==
X-Received: by 2002:a05:6a20:745:b0:1a7:549e:ab80 with SMTP id l5-20020a056a20074500b001a7549eab80mr1244874pzl.47.1714705806903;
        Thu, 02 May 2024 20:10:06 -0700 (PDT)
Received: from localhost ([103.192.225.105])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001e0bae4490fsm2116208plc.154.2024.05.02.20.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 20:10:06 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] platform/surface: aggregator: Defer probing when serdev is not ready
Date: Fri,  3 May 2024 11:08:46 +0800
Message-ID: <20240503030900.1334763-2-weifeng.liu.z@gmail.com>
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
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 drivers/platform/surface/aggregator/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 9591a28bc38a..87dea91f91fe 100644
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

