Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BB3815CB
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279236; cv=none; b=eZtgFRNGq5pprk2Aygp8NWXCrvYuuwZrbDWveTSzC+UUxa5an3PnjqX/7c0uE2206a2NKoOYVdLseieVKmpLZcadPh0bjxTZx+i2Cm/eyxdwLsQgdUzPnyBk2vOwwfldAZtrYrO4AkWpG1Zt6/MVRTAK6t0GEVSEERUqHPgTv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279236; c=relaxed/simple;
	bh=wXf+CtXMOHb6XNnOuHfGJXshs49io3F3XFjW0t392rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfQiTnUEcA7loaxHCoFdsIK7ZU9sTVI3kWni9FWrqoqXAdZNmpRPsxcuuYVhcJYcGZCOYniq7Josv8uzyJ2PO0lkUVxBHWjgG6pRLPfoJBemxVUYl0xxYG8rxzR9IT6SEbtJaHO/bvUaGPB4EvQS7ES7/D/tCrsixB5QPqipFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9os1uoC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9os1uoC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-356337f058aso4730187a91.2
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279232; x=1776884032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ic39KQsDtjbejfoaSX2BWNXeNHAHmD9Tq1YFCoyddVU=;
        b=P9os1uoC8LhzUgsGqx/OygwsJXPSu5+qwOUuCMn4qLBdcGfVEBVzG6yTM6CJO2ODMe
         jGXDJnt+koJmimMxyoJ36qw/2uO0Uwttt5+uTq5HnCiRemCeqtymQfpCdsqpGwHDCOd1
         gp4C5pNHzaFfwRVhr6bte/YS9oXjLhC91X8m5kPYfdt1vg/tLS5mrCrweW5a4IkpKZne
         95L92krvHDe9jisjuGQxFRG1ZLOkfDASqySuGfgRS8+Zti5E7uiZj8Pv/hLJ5cTxy21c
         +s9UKYNkAELvsmNshYLrLhJz33LSOKpzTDLYDxIjG9pyOUzuq1hTM9UlidYyTa9Yy5i4
         1OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279232; x=1776884032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic39KQsDtjbejfoaSX2BWNXeNHAHmD9Tq1YFCoyddVU=;
        b=QEcvIGCTVFhCmpjpk6JJfzY9XwTh71/AbVRp6tWES1CLEEgC9Rhuz4YhOiW+Q5+feT
         qA29nJOyGLvwFlGDX11tJFlJMDS1q6YfZ0YBMzliz/ne+g7t3XSRUXCvH2NYSvQ6juIz
         3MfrON2Q8IL/xc50d9YwABaZO6WZmQziX1O3cOOetFi/kOQUCb0KCCNaK93D4ZC/CSHG
         RqCBsuSzxmb2/CHlhz5Oj7tb2037GBDzTyo9G8ehBmL2yScgkBpZENS/uP52Nl7TW1XX
         uVXbEcR8ttnyhtSoyzNeipPjSJGPcPDJxB9nJfiJVjljVAWNpNuW5krZMagrwzQ/gXNe
         +nBg==
X-Forwarded-Encrypted: i=1; AFNElJ80rb4+8RbZm5OQC5u2WXS1he1x/cJXy21Y8UFwUitcbff0CiPcIhzmYkrZJS8IOOO/rW/nykZE4JR03B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKNRO9FDk15U+W2zokgncZipXYYuRWDve8Sv5gBSdHoXr7yoo
	i4Z+sGNgfiEJHHw6mnVH+Yz9mloikha++28uaFkla1kNvrcHHLTH6XSr
X-Gm-Gg: AeBDievVUhfWgS/S08EansV/ZRnKwf/BsA2E9+nKKr6isI17+RvTeANnCdSjXwV2MXI
	XinyqxfqngE5iGR93xKnUSIcwqlVnVjPvjwmxZkwqnZ1Bv1FiS3jqUWCq5a6ZB3TTG6oVpoDduE
	sujLsXQ3VOYJ2ykz250xLhrc4Cdv3KACFE5E9RfQTweQWcJCFgpz/lkcoLsvFOU2SUm8/rMO0mX
	3byikez56l/sKA/G1Rmo4mleMhJ6itFVSK4knt3Z88L/EH69CLpOl/B8bCIeRK6yKfTqzCQ91Mh
	hikrWuBhrUw/yuASl/k8Hrmfl0pSQORLuvBq2uuVUqRXZI/GTyQ23Dkn3xHUi4jxnjr2AaAFF1x
	magohuXj7Ghved/I5xLd60q+sqZTzpQyeXstwEuIr+rC0MUOCV4Gzq9KMurBuCMZolYMjP01yOQ
	44yNDAziDzUJvUUnlLMnmspKCgK6zvRDzLLZE=
X-Received: by 2002:a17:90b:3b52:b0:35f:c1cc:feee with SMTP id 98e67ed59e1d1-35fc1cd0410mr9788933a91.3.1776279232224;
        Wed, 15 Apr 2026 11:53:52 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd20d0c3bsm2834619a91.9.2026.04.15.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:53:51 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_hub6: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:53:39 +0800
Message-ID: <20260415185339.3804023-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in hub6_init(), the embedded
struct device in hub6_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  hub6_init()
    -> platform_device_register(&hub6_device)
       -> device_initialize(&hub6_device.dev)
       -> setup_pdev_dma_masks(&hub6_device)
       -> platform_device_add(&hub6_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_hub6.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index 273f59b9bca5..005dd6bec3da 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -43,9 +43,14 @@ static struct platform_device hub6_device = {
 
 static int __init hub6_init(void)
 {
-	return platform_device_register(&hub6_device);
-}
+	int ret;
+
+	ret = platform_device_register(&hub6_device);
+	if (ret)
+		platform_device_put(&hub6_device);
 
+	return ret;
+}
 module_init(hub6_init);
 
 MODULE_AUTHOR("Russell King");
-- 
2.43.0

