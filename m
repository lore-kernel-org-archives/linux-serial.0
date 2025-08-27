Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D634AAE2
	for <linux-serial@vger.kernel.org>; Wed, 27 Aug 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289877; cv=none; b=qpYjmGgt3DDOpljyERsrIVmkjKgSYOGdtH6DcCWs6vR0G/7GoNS7aRxBas5h9jqRorJ/fvqN3H65mBO29iP36rpDsWwLl/pFuwREQJZRpet6ghfgWHoWMYCVB82F8P886jbMB7ORnVUWBXKhelP07qMMPmOa21MnRkg8somnOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289877; c=relaxed/simple;
	bh=XiCyzRrxnhE3NB2OuwNB4t2/v4Wcgu+fsFnAZJI/iYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUot1ZN66TmmCZqtqhZoNFIe+YVLOHcXi2CWudiKbvcO5Y3ZGDLaHU22bkEwBTgtJwUM6ThUf5ZAnd4h7UoyhZPr2GVK/2g2waExkDcJCZUL6InaiPRzK5CBmJp3+kmO50vBL1f0KQQNHjta5jZK/4BfanUF0dUKL6WsSboMruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IojxMeFl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IojxMeFl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b4d8921f2so48836295e9.2
        for <linux-serial@vger.kernel.org>; Wed, 27 Aug 2025 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289873; x=1756894673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOwtzUYNEN4Yb2Ca5f0BdtO/R5WNfpNb+21iJrIdehs=;
        b=IojxMeFl1L3EroARozf11RIX8gposU+WCvZcQ+URehodxc0Tw49KPYCdGAMykPHDnA
         N+OOvMZZKgL7XoIqvJukOmwN9/fqRq+MOSRQEL68L4ZsPHXndCdo1DzdnQDOV+OzOFvG
         QyTwQzl9xw3DDtyMn74rNzOcB5LINBUQuTDiJtpnFcyG3ssrhxUWpEGs3a6osk7CYe9Q
         Ev3Z4m48IXuMne8Zivv0VTWfEjDBnoo45lKRv5fDUeeT11/6SlgIqMRKdydbP5oRHZuq
         GnTIV4MQGdYCaKVelgSAQdgYIBpyaDih6Imse85ucf8CgQYzXjBmTNvLrsTxBrLij36U
         BZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289873; x=1756894673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOwtzUYNEN4Yb2Ca5f0BdtO/R5WNfpNb+21iJrIdehs=;
        b=HrzDrE4fEij4XFChMfUSmJwA8QizyOtxOuYjPt1uDFCRObtA24ecvaSgSREkCbUZG8
         zaLPKq3QJtS7ou8MdBvujXRzy4mBifaScvy8TLxKj5m3pJbN8aNYBcKM3I4UBr0bJzdy
         SKX+Og5xW0pSJjYHVxrewX9hTHCclZmoCQFIMd0XASJQQzqRjl+SoQ6Lz17LxNAoj5Ni
         Jhbu3UhI9nU0PKXSm7Rd+Qlm9SLyutojqvZYYoWF/jiS++cHgj69s9ECuzKotc1rqw9/
         uxAeMQbOmbpIEJ6lRv+cp0WJi4Epi7i/Q6Y8dpWdVtPE3cs7knRfVxGaaLRKAGky2wVJ
         RLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKtU0QavBkyGOcClq+TGHUjVnoar+wsn4Pn6NXT/Exuu5ri3u5pzAxjtrQ4BAVsv5Gdw2QqD/8xU225Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD1i6iExWFUm3da/VKBCJhBpNmfPGV5NdxX0CUK/IfavAq/npt
	WqrWatkOijzPgNdhuHf/7vInMayfGk5M+fHvHKaZWwyrBd+ADiwd1BGrU3CsIwdEkjY=
X-Gm-Gg: ASbGncuyQGbABp499qwpfa6Wp+118ZkQLd85rQ15ZbAOQ+A/gplhfUk2aB5wwrL4Akd
	AHpvTfB4LhEflQJ+CwuCxPCdyU1XPDVAatb5NbnLuNbRfW7Ui641EAX0OchSJQMHKVA+jbq19Bl
	/3IAHxYm4qJlKFDuVv2BvYDxeSbL6ON2D90qqCXOjQJvYkd3ueZLJCy+9ZYR2gTuzdiSygLx8QG
	jJi+Hdr0hjhFaNiKWdGS4OQaT+vBCG2cAyK3+Bm467d8gNGdDISzct4VEEu2yfRKfeeCg/mXKeV
	ylqKvAbHjRdBnGhM95TH0tOXgJ+gNfjtaXBsri8XhzvncQp6Zr+2ySjlpIBkky/HBNmdOjFfP6/
	5fFHbUQE/0uwADzS1bQXpbgy5y5F9Nju8iLNust5sVxBcgaxpibtDU7mzkcM39YojqBvT3mUOL5
	aGeSGbV/x1C3XKw0/0
X-Google-Smtp-Source: AGHT+IGgDVceGJ94gwXiT/IZjg0OTBFL6jcg8M6Oz/orNkYOgSyHMDwEfK7xO6wNc0Yvuz39hPXfyQ==
X-Received: by 2002:a05:600c:4705:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45b517d49d4mr181322775e9.24.1756289872841;
        Wed, 27 Aug 2025 03:17:52 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ccac1b892bsm2293290f8f.67.2025.08.27.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:17:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: robh@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] serdev: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:17:47 +0300
Message-ID: <20250827101747.928265-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serdev/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index d16c207a1a9b..b33e708cb245 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -399,15 +399,12 @@ static int serdev_drv_probe(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return ret;
 
-	ret = sdrv->probe(to_serdev_device(dev));
-	if (ret)
-		dev_pm_domain_detach(dev, true);
-
-	return ret;
+	return sdrv->probe(to_serdev_device(dev));
 }
 
 static void serdev_drv_remove(struct device *dev)
@@ -415,8 +412,6 @@ static void serdev_drv_remove(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	if (sdrv->remove)
 		sdrv->remove(to_serdev_device(dev));
-
-	dev_pm_domain_detach(dev, true);
 }
 
 static const struct bus_type serdev_bus_type = {
-- 
2.43.0

