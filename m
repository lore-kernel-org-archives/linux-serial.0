Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5A1E3DE4
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065043; cv=none; b=mKa9bPWn4vNwq7trPXx//fzyJN+yieY9jWlJ0aHjxN8BZLQ2XeugheCi2vUiptOW0ECIKMwADp0nVonuc4MB6QGTETe0CcykasREzkqWoG1qmrHJvpc9z42XY4sOB+IApV9quo3eDIausSKmsKAr0VUfFlPcJZqG/09rGbsQmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065043; c=relaxed/simple;
	bh=mazZoK0EC0wml2HyLSd0Y9MhLwlkOUfPfcHFdPeuX/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZrPxO1J9GqgwFjRJRajw7PZCG2509ZD8NvH+DRbGmdJeOaWlnXjHhHqyhqtAkU/isB4PT/I6JOh2UiYxeJ6FHawSOZ0YUNr0ooi/G3fQjBMJxHqt3Sh3gnZ1jzvQdOtT2/xYC/cVSWm0GnHxX7NXGW3Jv0PjnShoh7tMKKElxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Q6BlRm6K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Q6BlRm6K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so17513675e9.1
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731065040; x=1731669840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2oXJkzWtCGaIKJ5cbPKhS+LoIlQBWBf1ApP5urqLDw=;
        b=Q6BlRm6KzFVa3zBayCsgIcod/p7esmqiyeXRyfh+z4O66hscUV02jtmtDZj/UrAbtd
         KOTPcrggRtNE6H0XL755glaLRK9XSR/ZEGupCzOjmN1jPAmvlFe+Wg2W0guE020WdHUt
         189tumcLPz3EZJy2sBfXH1kalkoSc1JSPSANtz5EPItw+btjse62/C/JHJloEq/J15ON
         sj7qeb5iKuhe3DK6nI6yOX7LGyYco3vkoMyQ5Leo2tc/0Z9E7aq/Y03N8RcLFWRihNKt
         XvOl8UVHX/YFwlT5L8nftcQkZh7Z7AzH6Pv+bayvIxSIV/rMhqU6kDnkJnZJZtJtjhnC
         cWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065040; x=1731669840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2oXJkzWtCGaIKJ5cbPKhS+LoIlQBWBf1ApP5urqLDw=;
        b=BEZO0C+zxgW+fDgzYtZJslkClqp8mLdLPk5CAmxH9M7LnZ+BtrUFblV9I0AIXCtKr8
         tkZYsobe2hVqo3hAH3/+jSvhpjXUJFk6kI8MfxCYQ1T99QvyJ2PKLgadC5Q2GF53wkJJ
         6WT7bvtk1qd9C7TqIltPUFnraxr9zRlrNGbC1J3sB594tE2lvm0Tz3zxuYif667JgBIb
         yeuj4AtLN2ag9jTQNOZ1OYv1ehf+4wM6wpfz/Nb117UPh80N1ZacEZpM+IQOglFgGjnm
         jJH1Y0ef9IBr1dUuv753VfZrZ3obDAuna/0GDmUIRLYGZZcje5gOExa+/O9FKYGkUyRs
         3voA==
X-Forwarded-Encrypted: i=1; AJvYcCV0UGsBEaKBr5fip3wH4Qpy/LG/H4joltrA9wibQFK1Ru+d2c079t5i3G7vJ/yi6s5v2pHk9/6fT4YUNII=@vger.kernel.org
X-Gm-Message-State: AOJu0YygAZspDFOYzk84JmcTJPJ3mSWVQx/pImvQAcFSbChmqHyOeIF/
	GRptR0CXA92rjvMKVHRKDBpHLfN5WTP7+gc6M/2MYP4SjbBrtidVvFJZ9LytNgU=
X-Google-Smtp-Source: AGHT+IG3MD1LtAeRYq2Tgi0EQ1T2xgC9oErR/8Baw/cgSq2n2SS2IbIUneoqxr+Ubgn8WvPWUdOaKQ==
X-Received: by 2002:a05:600c:4ecc:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-432b751b68bmr20133435e9.26.1731065040128;
        Fri, 08 Nov 2024 03:24:00 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed970e18sm4281443f8f.10.2024.11.08.03.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 03:23:59 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/3] mfd: at91-usart: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 12:22:35 +0100
Message-ID: <20241108112355.20251-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108112355.20251-1-robert.marko@sartura.hr>
References: <20241108112355.20251-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the AT91 USART IP so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae23b317a64e..f280ba28d618 100644
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
2.47.0

