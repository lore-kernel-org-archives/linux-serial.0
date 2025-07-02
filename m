Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F830115F
	for <linux-serial@vger.kernel.org>; Wed,  2 Jul 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481615; cv=none; b=jgpZeMBpb0TLrsT4DnnP/iFek/V9P8uL9cpvwiuuqiAPFM/AEm80d8ARfN8E5jPgi8Jtqb9IefG5VMAYJY3HU957genUs4KsgpI4eYKeFYMEZcm8ePfDoxcCRye6d4iOeGGXkpWihb9E4qixWOcZpqNbZyGZM+p4vdcZZ1yj/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481615; c=relaxed/simple;
	bh=Cz63RwNeleL0UIjH6azz0oQ3j2RQxKtigND+2Rg8ZE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxKZEuoEyHeeaOMRnebprsD37yom9smMEPB+IHap2B5EP1fbRBr0loeI7jx5WE4vHDHFS5PkcoaKg0zlRDbK/TBxDeiHQohxoPOpwVwqAc/UCwBIab6z4f8D6BOP6zqNhHscq4v0+mXALq4Fshwpu2P6KYyx4DtlBYybQchm/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Va0YdXqd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Va0YdXqd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-237e6963f63so31389345ad.2
        for <linux-serial@vger.kernel.org>; Wed, 02 Jul 2025 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481613; x=1752086413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLgkgM2dsMzuH/fyTk3FJbcZgyqMvTqyvvSzdaeBl9c=;
        b=Va0YdXqd7Ix0e8Et2+b4uQKK8bYPewjZFS9B4xkIe/yC8TrKnqu64lE9zRKXq5IS+j
         MJC9Kre+ADc/I1UNLxUxqIwZMYx3ky0BYiQLgzPLxUrxyA1CbSmU0yEgNbjdv8HEYKiA
         UbxcgRny46t1PVx3PhdNzHQOqgLrJLdopipxzgEIadB/AjlHEa1WnOB+JUVLqldlnBnv
         b+eipirIyAbEFfkLAW1iBk75Se+7NHLsHcoXNMupYN8qzDyaMcZxuHJyxX38rmt6ozDl
         8qQFlURzt3vua6+NZNRFnI1WSMw4vAHFtVJI2ZPrUbG+v3+tzT43DxO0j8Kojtir5STe
         VtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481613; x=1752086413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLgkgM2dsMzuH/fyTk3FJbcZgyqMvTqyvvSzdaeBl9c=;
        b=LO7Qy2HqGdcm2h2yCdM+nhyP0oNS46ScEs8LhKtYxQOpoMfzJESBlG+dxt/5FmQBxh
         ORF3qkP/CfDxNQbY4iabYCQPZIfsrvL/q8cVMnN8xwWO1JpavVRLP4e6ivRQWWt1cw5L
         SiSS925GRxurvIKkC1L65FFCrjjv6jj9oZfT5PF6+pjLz1+7g2gw0U1e4VQs1KSBrB5j
         UonNwGbO2DELzval6XwvdNqiWIYDHHxCcW7B2w0OvuLLvczXudciobw6u/CFZabFibaj
         Hmt1dImB4A/1IQkvvalP+qK0k916th4Tmgh5LgxYk9+Lc0iJKwVt2LRNppbYmgxCCfkO
         mxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkC8SvuhtOtYJiG6eMYFVhziQVTkh6ZBTvAQuX/sDXSLIv/O0K2tgJSyN4bbKIwrt82rdbyJKZTeJD+fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvluzaHanSf6nuWiVblcPACQM3SEdmtoFwZ2HonSS0VvTl03zi
	ei70Ew8vPY6rcQTyajqRB45M6e/dHP8Wt6kQ1ZxDARg9pZa+So0WgnCS3K4lukIjVgQ=
X-Gm-Gg: ASbGncuNfxNRMRmZ39UTEukd17Rmnq1y08gm2zOkVo+etRwpQVYOgZ4kLYGI4XbeTUm
	UYgF0HkNMtSSDPgCMfkVMSz7jwXGrYejgOAsTW9mcVG04c9xtt9Sym1F4zqQJNnYKsMYDx9OkG5
	Vwk4rddXxw99ulXv5zWH9bbB+kUDb4vJ3fQyc9N2OBZsGp26C+7xWBixTVkh1ZUTcNUWgA6g/k3
	Z9oqLM1ag+ydByiejr040X9PElcwkvwpBUvebRGZqwqfcWCFqyEoGIDkByWnhhRmFOd0M5qzPRC
	pwEmC1WopUFYb3u2mLo1YZgA0kInAh57RITSCUr2Iw3op3is6gnhdwoB3O2IiGvKikW4RwF8tKQ
	rupUVzhelfHvxiIetfII5Td8=
X-Google-Smtp-Source: AGHT+IGIKE9F8Co83/dHlUj/BJjldce2wZ+yTKPm0xGwC9EdJvNItuAvUNQ8nezHwuOa2fWnkwRauw==
X-Received: by 2002:a17:902:da88:b0:235:880:cf8a with SMTP id d9443c01a7336-23c6e4ac48emr57113295ad.15.1751481613470;
        Wed, 02 Jul 2025 11:40:13 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:40:12 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 09/10] char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:07 +0200
Message-ID: <20250702183856.1727275-10-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel HWRNG, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index c85827843447..e316cbc5baa9 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -77,7 +77,7 @@ config HW_RANDOM_AIROHA
 
 config HW_RANDOM_ATMEL
 	tristate "Atmel Random Number Generator support"
-	depends on (ARCH_AT91 || COMPILE_TEST)
+	depends on (ARCH_MICROCHIP || COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.50.0

