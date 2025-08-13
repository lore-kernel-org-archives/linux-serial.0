Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51E28D8F4
	for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107263; cv=none; b=W1mLuPxiAC8lo/R0WtnIniQqqLuI/VzycARv17hZsjUOmOQQVgc8ehHY+I1YTIyail6T6Gw49zUtka7gW+yKP4kQ7yfysmirXV3WMZGVeZBRPXXNFLQXdxDnELC3YxY5afuk6eYaKgj9G9699DRpYMHlKvrD7vRv6IOfddrjpXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107263; c=relaxed/simple;
	bh=RL3Rsz0aJlOWFxlh2UakRKpVFid+fQ5BHQzpFq6zABI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iChRiQCT/OaSqY9vvKmngez5VG+z97VMpp0GQzSdxVNSWTkzB9crYiJD2xiJR9SSjZNaERbveCSzGTUzHFchOolWQwYaFs2WS3SOOjwLhuJ92j01J1msm6n6afHEBtYsXk7Pkc9X0Ux+S8wX/lfxHiWSiijKfh4r39WZoSB5epA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=fw7/ZPTF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="fw7/ZPTF"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87061d120so6218685a.2
        for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107260; x=1755712060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtMzSO7UPmjR47X20+ZqBD1uhyLdG+1s/Zrtcgs7erg=;
        b=fw7/ZPTF6jxg1uaCEZj4Aq29AqS+wxQkqaLK6z57NRPX2Jkxw6qzH8icX8ROKctnTO
         YHRR50dsGuEO1nkXZhGbWBFX5XoDqZXabtWFi7m6eKgl6a43mz5J5yHsMPvA2sRUOU2S
         tXblc2C4heR+M9IKeVxDBaljPVUYF7x/NYNpNl3HSGQISa9Xd7rVTbbMuoiGZzkI06Wr
         TEf2I0eP2jZ9CiRgIp/hmYufKsv9v/HeWlfCW27vFuPD4objIAhvi3ZJJ+LZyQKgLusb
         P2GwwiX9qeu4ZjYZrwIDEnjNb0CTR12lJr9bA+kqTfY9YJNykzYZSSe+NZPf5CDU57k8
         ctRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107260; x=1755712060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtMzSO7UPmjR47X20+ZqBD1uhyLdG+1s/Zrtcgs7erg=;
        b=p0UPSEUlggaPU0gpxnC4qsWDeOxENpmhEQ+LQW0hhMc/EtckssOcNUagt4dJHz0s3+
         hVJySK1SZ3Juw6rxhiHSwR3Y/MJlh6i0tvVJOuAEAddCodevLXgiBQpcDLgfG08lCs0d
         NiVWQaR/g2VTVXTSICro3hwz+YxrOFkpgxZX+67cmW85rdSJ2L/V1f38GQtQBPZhIhpI
         eTDeDJm9lUJeRcz+Iys+uanRphIG8rIbwrrQSrWn64znjf6Oy6Qe/ELZhu/RaY0KArKl
         xwtEkoOntKWTnOArJDbMXqgpKSUWXWnTQGiUpW323aEOmzmdxkaFoiF24aQqzV/LAeUV
         dJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWdvcm19ifoHcnVq99OmzTtx18WalIu6ZJUVTKp1LFhbVxj73pXj5CH9BAMWrJvADd38GHOCN9dP2N4i5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXE7whWw7c21XxhkULFkMJo5Il+ijX3iUoM/77nxrHerltC4OY
	nUDGVJafbCYdAR83tZNzyM1Fbd7nUEyrr6gxNqXiVJrpwzyyyqv+5WMVJiGdnbWmmuQ=
X-Gm-Gg: ASbGncv3YrZpi3C7H+yK8ecUfB/VFYYN6zMK7FnGrP6quESLPJZQLe0nxVrTUlSBSsz
	RErSs4emBpvWeQ98TbIjkdamP9YPvuECdsUMwIQ/M69FbZHvBvElwJbfhNrxn51T9MxnxqA1Xbu
	hnrW8gF0WPzNo0nmVcAgrnxOwsHgadOfgXTrgZSjL3BWgOpcNXv6WOy7qoIdAEmJ8rJRP9wU3Mc
	qjvFfqONeMu9hoYCn1xCJ+Hi4Hql6UX6/nacaMoED6HW8aM3jwFfEDQpD/lFIVrFTFAVepyxCbY
	EBv/Wxz41QPBB4mRK0gAmE749nllFYvi8oBxGIWeaBUHijCxxvBvMlhc4ryRPQJdLDivTxvj2gy
	lp/SqAjn6Tc83zz7YUfh7BAMYtLm8lqY9teLkJloMvcQ+SAhHwM3a
X-Google-Smtp-Source: AGHT+IEOA4KVOCs5eFfidLnPllBwbdP8If2rCIZC+fPOPK1dPvbgpwik/9+siLqevJw3jKgUeh5nYA==
X-Received: by 2002:a05:620a:bc3:b0:7e3:60cf:c037 with SMTP id af79cd13be357-7e870593e0amr23464085a.34.1755107260046;
        Wed, 13 Aug 2025 10:47:40 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:39 -0700 (PDT)
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
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 2/9] ARM: at91: select ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:38 +0200
Message-ID: <20250813174720.540015-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like with the ARM64 Microchip platforms, lets add a generic ARCH_MICROCHIP
symbol and select it so that drivers that are reused for multiple product
generation or lines, can just depend on it instead of adding each SoC
symbol as their dependencies.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/mach-at91/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 04bd91c72521..c5ef27e3cd8f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config ARCH_MICROCHIP
+	bool
+
 menuconfig ARCH_AT91
 	bool "AT91/Microchip SoCs"
 	depends on (CPU_LITTLE_ENDIAN && (ARCH_MULTI_V4T || ARCH_MULTI_V5)) || \
@@ -8,6 +11,7 @@ menuconfig ARCH_AT91
 	select GPIOLIB
 	select PINCTRL
 	select SOC_BUS
+	select ARCH_MICROCHIP
 
 if ARCH_AT91
 config SOC_SAMV7
-- 
2.50.1

