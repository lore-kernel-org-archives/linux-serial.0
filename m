Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750841EBA00
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074343; cv=none; b=SAgY13H/Kv9js17QLtDoJMC7V+dUUaJYQmMPTmfBtm8pBO+rA20tuJMEHZWddXD0g04lNdMJt0fnNNHFpsP7nHRFAhnjO14kJWxLUtslWTxhx1U6lGtdgskMeK2Qb+Wc8lgPcjH6MOWKiI1qJJ67S4R1Dcw/QRQXXKYFO93TGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074343; c=relaxed/simple;
	bh=mAPRkq8mcGAitqZ2NJPZs4WYcWRS92IxYDvqOFLptL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P06ntmtbNu0A6sTXTCa9zNhdF1w+X1MnBTPx0zGec6b4K6+U3vm0ygApMu3wGETFzGKbhj/3AyW/wdrHgB8XZp3sD+Ka/iK7K59b4274kgOBnR+e+U4Uvpc+UvmPB+VP9u9Q/1gbMCcUmwpKaWaaWvGrKu76O376yWJ8ayeYl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=qkQu+86e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="qkQu+86e"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso19816355e9.0
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731074340; x=1731679140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=qkQu+86eglnwUU9e8q9m+yhXyGghSfSZTooQfBRXhxgUsdjODQsxDdcLCDyrBk3AeM
         3mnA0Jhj6/iFBSiVQ1E3C7XQYppjfAFuTL48w9U+H3wSqVgyu4ofF2QpzgWcFAPO3rIK
         4uR5gchkf1dB7Eciy3rD/PUCaeCZzc7aoiwvjkVitFWMbMmKDmQsrvwXiZZVq/+x+ANV
         pCqGWzUUZrJcLBV7Wi4trPZk14Kw1i93WJOgLI0ljveiKdSEaRUc6iUL3DGZj1Qhg0ml
         MxWDAcwxLFq/leG7aYfHMfRKvr1NRasFROur0x2EIqBbYVeMCzNKfuTRP5NXzAlkQH8J
         o/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074340; x=1731679140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=Jm2GQoI3n9hIQ4xB7qBp2gWRFo2pJ+VjC6PU1QG20b/lsrc7TxgHVlXAvxpELd923f
         N/qiB7m/VBwEyyHHru6YOZHgx3293VcJ4C1Ujd+m3cpb6v22jY4SbTnJ8dmL/Hg0BSsy
         Whv3652HkGBOBpW6GS4JbkxrCMAY7CBJtTBLj/VnnWTJYCu58yfTjBTwEXlgsRAeviC7
         s4EzNiYyRpCTqOK1jPauvCs/XJcFLC7UPLaF30wLaztxi+pqWQJx0SHDcitDTHdkhBJZ
         U31DuXGNftzW0f64XxLfPDSp6TOeSuocI1qG1tFzri3OkOe2Q9l+VIlUIhJzqFEqYDkz
         Yqfw==
X-Forwarded-Encrypted: i=1; AJvYcCW6p3BVnqStycbnryVIA+ww0RYNV0Iy1ssIF5ek6wdnSKBErJ2j601xZ24JoCVBN0O3Pr5AWHAQPKIUUKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7sPinP4bov+Kok1sMo4WFYzpZwdsAAChZjYAb3sX7F7DB0Ki
	P4gYlZHB+7ikXPqUNmaZ9tkAz2M5SyQB3QfA1au6OKxo2L3hDaIErWJntcN9WK4=
X-Google-Smtp-Source: AGHT+IE+nAqhwysBWUwaiDHL8021dYLt45cexYtLiP8CXTNVID4kP6yjzuHQfUBix0HKH4CQF1DrWg==
X-Received: by 2002:a5d:6d06:0:b0:37d:45ad:8394 with SMTP id ffacd0b85a97d-381f1866bb5mr2611022f8f.15.1731074339782;
        Fri, 08 Nov 2024 05:58:59 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97cd97sm4924431f8f.27.2024.11.08.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:58:59 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/4] clk: lan966x: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 14:57:32 +0100
Message-ID: <20241108135855.129116-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108135855.129116-1-robert.marko@sartura.hr>
References: <20241108135855.129116-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same LAN966x clock driver so make it selectable for
ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ef709327cba1..713573b6c86c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -270,7 +270,7 @@ config COMMON_CLK_LAN966X
 	tristate "Generic Clock Controller driver for LAN966X SoC"
 	depends on HAS_IOMEM
 	depends on OF
-	depends on SOC_LAN966 || COMPILE_TEST
+	depends on SOC_LAN966 || ARCH_LAN969X || COMPILE_TEST
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.47.0

