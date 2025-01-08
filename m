Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7B1FAC23
	for <linux-serial@vger.kernel.org>; Wed,  8 Jan 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341856; cv=none; b=WzyJvp2CWbetgupdzndQ8193IeJGaHNKDyABTCvGXvxkxdhNsgKRDQf0S3DBLMV41XXVtH6/SRh9Kkn5wwUCiSTSt8RWFxiOtpOkz0WNAsWTRvaVMVyOz0xGaE9OSyiochNMrHrLZUco6bYgem7bB8TZS3k6dWckGh7iCOhAde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341856; c=relaxed/simple;
	bh=wdwb5K0Nk9as3xXHyDTFyXuVgyfy5QUMEF9mKc1QTiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxcBBzGUnpxF6DG55YIQZ0r6a/pxXGqncse6ldophrErJe6bLebbUHG+tUW7jWUQjApEbeLNjnTQLRylRBtFjhSZ4qNkSoLpryHfljatxsFae+Uj3aK+zY9RA2R55KjV8Rp5PvhCCpDNmCoc9iOjt5KFxONBrLa/vn8GPONkl88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=XbHCrgx2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="XbHCrgx2"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so22629692a12.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jan 2025 05:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1736341853; x=1736946653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6vO1yS6GPlqptdbWrGJbZkPRuaiwDL4rtqMZJkGpRI=;
        b=XbHCrgx2TkpBHeWKnljiZgxXwVeKSB5BcUCBnjeL59k5/LXOtddCxMaPFnquhp0848
         ///Z67sRV07GE1UHlYDiIAsXvfFc3YE7YFotz7LS2UJTMYAIs+nufNTlVZVVppE4M42e
         aplr+ml29BWEF1nCcXhddF8KxeLm9ag97jh6FRrMsXHo0qfLpSV5ZzhdFnTLbyfbTFsL
         6B8BTwxXSIZHEX9DZMU/icHmkeRqX8rJZY0xQt9BYwxWFf4JCKaq75vou2dmhq6bJsIz
         SIJlpQmFJ9GqhHFOzQnuO5qxgrAhgpo1+Sb7D7+kXfF3rS1pyaj00/I2/nWjyR3rV4p5
         OYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736341853; x=1736946653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6vO1yS6GPlqptdbWrGJbZkPRuaiwDL4rtqMZJkGpRI=;
        b=YCGUyUbKrdrdB4hQwwjKqc+Se155Yc7YqVc0yW4XNngNZSu8/WDE8rXFxu4HTen+3Z
         E0Jh5i0XuG/dbIAGVqllODnsFHWkJmNTvbhWgffpRcOJURd5cgSdrXotbS8dUmpWe16y
         Gn3xS7O+DkrVf58LJc9LTF/v+WvOKQO1jmvs3KozT8sLdYmUXQOV+j+unobAhnEmi4td
         8bGQGye+L2+FHfsJxRviYoLMsdCwf3FlkVUvKjeNh5NOfjfyU3LV7bT/tXqxOMV2UGut
         GHsEKDPXLBchEqX/MZNRRBVuu1gTxnxVVAbpmKwJZRmeFnvNEdNv6Z2IE9ttEVfw/Gfy
         F6EA==
X-Forwarded-Encrypted: i=1; AJvYcCUc7dMi3JIGMF6tGZ23N0ZJo1UnO+7e0L1Dwx+3ClGgb1jOCbjjb29fP1/YVsqV8WMp9Nub/zHPMdoaYtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvzZMpTFH6rPl+ep9CUwrf1qTNXAfzZNh8vxSBYBrb0bOvjLf
	Qoa1rYMF/5Fhmy3DQUrenyn/ru9lTjNSXVhtrF+YyrXoudWFFzrV273BH0b3XBE=
X-Gm-Gg: ASbGnct2/gopqa4kokXeslC/DzGWFlySMp4IOJFg2yAoB9kNmZcA/xT5oKQtJdjrNWM
	KIvhsm5hTYMDrf2vcjgIh/3bw+wWy/FNCtzEyxmg1ZCFr9lWZjYGTJMvJ/ysEqqg/cNN8k8ZWom
	PLcjdmL4mzDBVfMwso2Ym5M4gsgEj0YD5XFj4oS2IVnIkFe9aMHNTyrYKFxiRZzAnq0FbB/uOeY
	wX6+Zn3cAXRtNFpv7kRRX+WTzpjzQh9havGG8j5NiOTV/C4zysviOCnZtZfrmcDShkChRdfJHag
	LQ==
X-Google-Smtp-Source: AGHT+IH01FPYKyvnpHvBBmc5ech/bov1311UfrV70T3kwaAdvQJCOLPViymPRE1YxoO4XH05S0VA5g==
X-Received: by 2002:a05:6402:2550:b0:5d3:bc03:cb7a with SMTP id 4fb4d7f45d1cf-5d972e4c9b2mr2569981a12.27.1736341853470;
        Wed, 08 Jan 2025 05:10:53 -0800 (PST)
Received: from fedora.. (d-zg2-023.globalnet.hr. [213.149.37.23])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedaebsm26159761a12.57.2025.01.08.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 05:10:51 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	lars.povlsen@microchip.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	daniel.machon@microchip.com,
	Robert Marko <robert.marko@sartura.hr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v3 2/3] mfd: at91-usart: make it selectable for ARCH_LAN969X
Date: Wed,  8 Jan 2025 14:09:27 +0100
Message-ID: <20250108131045.40642-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108131045.40642-1-robert.marko@sartura.hr>
References: <20250108131045.40642-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the AT91 USART IP so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Lee Jones <lee@kernel.org>
---
Changes in v3:
* Pickup Acked-by from Lee

Changes in v2:
* Pickup Acked-by from Nicolas

 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6b0682af6e32..ef32ac5ed75d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
 	help
 	  Select this to get support for AT91 USART IP. This is a wrapper
 	  over at91-usart-serial driver and usart-spi-driver. Only one function
-- 
2.47.1

