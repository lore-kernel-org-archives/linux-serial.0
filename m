Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3C239E9A
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278445; cv=none; b=k0Fu1vZzzSMoGZwDE0pmTb0V+PPMweGO9Mz1Fg24GBMhqeIXZWjCn18MbzA+0r1CL5tG4e/QIz4sDNZXL2OpZbOgBpg6y6+Zxx1nr8eWMVO9kgVhk1NNdimPKjJGcF8554Bwfie5ci/eq/5Sj2mBhdySMaDMCEh+h4zRdWRYkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278445; c=relaxed/simple;
	bh=QTClQs6mmg0+2IOvek0wnn6CLbm5OoS03YkOeSOb5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGzzHrdmgIWtpScEJsX/dh13Wr/By0xLzviYklW5fltG9+GqPf2FlJZIJtevBzJAAVSM9hMiBTg+/2Xfm8P48q0elupLyNsggj+g+y9z8CoGgo54+FqShyXkWtrACLVVhrUcYEl2R0RtRZRDdEfDv+2Z3KKhU2PIoSj31/+2adM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgfbSy/N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgfbSy/N"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aae4816912so47572305ad.2
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278443; x=1776883243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QuK475K92RErA2NVtS79BUBslHILtmYa6Vn0sllo80U=;
        b=VgfbSy/N14OjPL7MYzhlnX/7++SZ7c3zbRvb+D1n2vysOJ9UjlPBswCNXyFmr+QzmC
         L1XDwQJTanqkGs0Jivjmmi7vhqDIH4m77df630eghFmZXlNqRtwCiyECHGqPLMRPb4Bx
         d5hRwYA30xcnGaKZ5YiS6EX6sdeVT3b6MSnaT4ZqQaseQaAjelinu/OKjxIG5ow5Y7W6
         yVN84FhLbiVGQQqQxVdml7qDuEV5Tv0b8bmBz+pMRSjqcJAwVuau6CK2zlRBei6uc341
         1IgwZGBR4+4/O+Kn3F5hV2kv9sYg7zE3n6S+Wpvh73Wpp6MBTXVmr/gUXiyV39LsUX+r
         abSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278443; x=1776883243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuK475K92RErA2NVtS79BUBslHILtmYa6Vn0sllo80U=;
        b=ldqDUN/jAhBNVx1+4+u+46UXAl9J9ckmrMW2tCTIzzBIo+E2TLisNqHZIsICoIyTxz
         uA47p7BoZMyKuGAxnSvQGs0Zgg2wFwFBXH4xgB3lZE4Ak1gsN4kNY6Gi1f3dV32If5d9
         pEDxQgUUsWvvYfFFi/uSx2yzAT7xEhCTexYUutUkbiHKKqMGvk8W8Mznl4bgCtzUWPAX
         slrFjnnMcmchP2xlGOcgg6VjsZSstglQs4VyQ4bpdgN9nylJhC/EwUZuUSNj8HSWKmoL
         Z0wpULUVry1+CuBKfj5huvKGYGyl+VkBIlhV9SKJnVt+0R94HAWw/R1ihGk/7/CZB/jf
         +FXA==
X-Forwarded-Encrypted: i=1; AFNElJ9CNZh5ucJXBJcjkF6h+egfadKlCChltWxtCbPztivERWM+WdPOJnbASu2lst29aupbWYy7ImlFFrFjiDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGLZmqci98r0GN2+qaipPSlgL9DtLoOGPKnxux6d9qCcnX7dd
	UZCyxWp2Qi9m43Ge29xyroTyrmwUMfEGbkZ65di7QB26HNAWupcAqmYM
X-Gm-Gg: AeBDieuH4N0Mm5qMR7jPlkDwsWWUBpJeFdN8CfpXPd8O9LmbEzq7e74uDytXpocoQzt
	N19b6B36SpXYmbf5jpukZTEFVnPb0DvnVBB0PdMDL/CNvMxmXCocy/8y82V4328njv7rezlruj3
	B8R4igY8kBBGwbt2HltCFdIyduNFC5WvKJjt4uhU6GMDVUqDWuE0hD1wuAsMZk7i+ELxqpZEe7l
	L6FpuSMKmGc/qCCC0BGDd6gup0oqNEWMDW+ybLvc8NpzsUOO4DV4g3gPzhVYDZe7o7sYIXAF+KS
	hGQKakJx2SbBDRFem6tEa+P5h2LytPO8VS1bWepYx1sS23YMHweVgNKr9t9VzDoJ5t87ui5C7iQ
	6hyrLu4ez743EIiSPMJKX4NqCw+zcEbteFBVkPPr+ks9HBwI1xdiRgHjUbzkdeUqtKKk2N39RLJ
	8Kr8+mzUC6GWDZ59tpj8PvbbxZ5/nn2azKhg8=
X-Received: by 2002:a17:903:985:b0:2b0:ac1e:973a with SMTP id d9443c01a7336-2b2d5a64770mr229004475ad.39.1776278443284;
        Wed, 15 Apr 2026 11:40:43 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef736sm38289825ad.8.2026.04.15.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:40:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Paul B Schroeder <pschroeder@uplogix.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_exar_st16c554: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:40:31 +0800
Message-ID: <20260415184032.3776292-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in exar_init(), the embedded
struct device in exar_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  exar_init()
    -> platform_device_register(&exar_device)
       -> device_initialize(&exar_device.dev)
       -> setup_pdev_dma_masks(&exar_device)
       -> platform_device_add(&exar_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: e0980dafa329d ("[PATCH] Exar quad port serial")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_exar_st16c554.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar_st16c554.c b/drivers/tty/serial/8250/8250_exar_st16c554.c
index 933811ebfaac..b2c37f0c52aa 100644
--- a/drivers/tty/serial/8250/8250_exar_st16c554.c
+++ b/drivers/tty/serial/8250/8250_exar_st16c554.c
@@ -30,7 +30,13 @@ static struct platform_device exar_device = {
 
 static int __init exar_init(void)
 {
-	return platform_device_register(&exar_device);
+	int ret;
+
+	ret = platform_device_register(&exar_device);
+	if (ret)
+		platform_device_put(&exar_device);
+
+	return ret;
 }
 
 module_init(exar_init);
-- 
2.43.0

