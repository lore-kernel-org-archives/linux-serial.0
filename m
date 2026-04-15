Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA373603E9
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278090; cv=none; b=GIxc0NC1XI1pjeJixqRFvJqpQIKnEgSNaTIutdLSXY/VDmru0bh2YOyy3LcAQqD41t1llDNxULX+coY9rHKw2gbYBbPM3IQOWPfTNbtSf7TV6h1Vkt3OkTFVdesbobCxxKIiiaacn+FfxXnYecr0qKm7dRBdtjM3ue+Yl4f4Ocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278090; c=relaxed/simple;
	bh=EdXmTvb5iJMARAAgUZi6IM1Lzl1CxlswTvTQaFCjcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEuAidYjK4PNVw1XN+bSQISXIAs5gxdGDAqcx45pJ/DhlbmjNDrcuceWB3Gqj6+8Y+SnNWmxQ/KDzqkDWORHFG/pb9jN36VSFAlNA5RxhW1KHn1Ls3rUd+HwHMPz4Igaa5uToQ8xrDbV1YI3I3tVy96V2yylki/t6XATebAtxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQET4FmE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQET4FmE"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358ed696623so3252352a91.0
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278088; x=1776882888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cipgUIxDH1EraQWdbgHFxKTYEd0SYP1EjujyQwqyAUw=;
        b=IQET4FmEX+DjZLOuxYojPfLx4fO9M6adJYho9jgrwimvkWP/bemB2lXzMPVSjT9goT
         lXor0h+GBGR8s6+Pa2Lf11eBlQrKDxNVtW6fKQOWen5Cf9gTFDRcJfsZUlUt9SDREq+Q
         oJEumszdP09k3NPlp/QGBYf/YIQYZAo9VpfDg88C/0+cHfv66WeENctbhb3yqxj6au0G
         LpFs2T8ImLuKeeJSbBSznGetYPwA1NBQOqCpbse5Ml0jEGIqPM447FOvsuBgM1rwrDMC
         BsqRf6M1ym7heBLEzC0/jmNg6Z57yGVE+B8fpiv2xlO17GebHy8fRZjBkIMKxnmzgVEG
         sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278088; x=1776882888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cipgUIxDH1EraQWdbgHFxKTYEd0SYP1EjujyQwqyAUw=;
        b=BnRwTba6jZ/mKsJ/qJE7GjaRsiYgtxW+i94Ui7Iix5blGpoVNnGqoAFbSnIZO3YO9F
         H+i9xulcAuwacRYEAXjOhSGHSs2w/JTaOQKnFVUSOIs0CtnfFewSuzJ0KOeYADP4FADu
         qPkGxpZgDvic8dFgDh4w5ts2+ug6hQHPx1BBaWFv0G8NOEFhhgLXeV/9agoYJneE/XGX
         CHCFW51HXH6h87J/+NWkBlJBkMMAzkX+K0Q1hmrSX9cwlAtLjQaeEY0+I6Zz9H36CbsX
         X/+e4739eNUzoyJtjuO0dlDCRR8m+uFb7cXFAfgVVK3pQcXWTfptuW/Ke2hSuRZg/jsV
         uZvw==
X-Forwarded-Encrypted: i=1; AFNElJ+snJLDOdJcHIShYcK/69jxhN+z7Su1l/J/4PgzQI8TKkk3LkweOCtqjx+GhML+Ne6sL02ygI6fnLmRxyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwGhj4PrI1JojEXU74Pbu0vNoaEPWJN8mKe5g8yEPNkCjHMck
	iqMB8T2fdbRPfXvQq+G96O9RHydwOWKzBN5FsXrb6GgZIyQKtT+3HGJo
X-Gm-Gg: AeBDies/eS9FWhgGJEwgcyJro4mKUuuxIv03yxlx/ySPQd1ZZRPH1csd8MzZvdqDQFn
	lFwhUErCW6HVtMGJMU0QYrUC50PxjzbBv3qnXy5onnbnnOAIKqfvGKlZWFfUYANGwjiS++4cWRJ
	9ziiNNUwXdefSewe1D5bbdX640o41JhHz/0eXYL/fUD+t3twq0lbHtWSxXrdVSzy0kG6jXASwpJ
	6HrVvmW4oJYSG9UQLWgXgSTndZd/tNLsWEST88Nazwtm2d5OaV52KDMOoeuke0ylH1ox06dpC04
	EiHFOb+mRWwyYfG+vshWlFL+znqttjz3kpfWnTc/5T6pVJm1oqrd9GMcpO31tSi0YWOpppAYUsb
	wigmrQZaRJpZvbO4hr8ZazD7vXIJAuNEJTPV19BHnFOH3ZSiP6Yl5VGPsMvtnTP1Q+7VR+7OaRf
	661sKE9XrtgtO5JatRyS9qLvDGrxbga0WX2uCckDX9Bfevdw==
X-Received: by 2002:a17:90a:d4f:b0:35f:9ab2:a5bb with SMTP id 98e67ed59e1d1-35f9ab2a834mr9337216a91.10.1776278087627;
        Wed, 15 Apr 2026 11:34:47 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fce6e8e06sm1695268a91.0.2026.04.15.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:34:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:34:36 +0800
Message-ID: <20260415183436.3763871-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in accent_init(), the embedded
struct device in accent_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  accent_init()
    -> platform_device_register(&accent_device)
       -> device_initialize(&accent_device.dev)
       -> setup_pdev_dma_masks(&accent_device)
       -> platform_device_add(&accent_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_accent.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_accent.c b/drivers/tty/serial/8250/8250_accent.c
index 1691f1a57f89..e9cf40268c0e 100644
--- a/drivers/tty/serial/8250/8250_accent.c
+++ b/drivers/tty/serial/8250/8250_accent.c
@@ -25,7 +25,13 @@ static struct platform_device accent_device = {
 
 static int __init accent_init(void)
 {
-	return platform_device_register(&accent_device);
+	int ret;
+
+	ret = platform_device_register(&accent_device);
+	if (ret)
+		platform_device_put(&accent_device);
+
+	return ret;
 }
 
 module_init(accent_init);
-- 
2.43.0

