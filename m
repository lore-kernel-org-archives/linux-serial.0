Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF12F6FA6
	for <linux-serial@vger.kernel.org>; Wed,  2 Jul 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481609; cv=none; b=oSUArm96xQwoQfqeE09JiUNgN4Kda/hdJok8r4aXgvaj113BkueMZZnFQiXWeJ11kdXiQEISYBMpMCscPE4VDDtUY4voHx/azs39aiFzU1wjs859QFQuWxPd+2G2eRTvxT1dWL6ykPXyiX4BNioTZHPk09H8aMY2Rg7V7Tx0zA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481609; c=relaxed/simple;
	bh=F6mJ3voGjUkQtf+0vAv2Qcihci6oK1DMUpz/FxyVtPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4RC9Sg52r+6W5aLY5uTMDDfsmNwL17OPxlrrYuTy/3TBG+1ij3ZRWwPzbIsHpTrmhyt/GliLPwS66vFlxeHmUXMmWlAIZymxehSfICzW7kXmpiK263TY69AcKKGBcuSvSEUuVmdPEwxEEQ856yrHpJTK6gK6HN5r5tDZpcCDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ecBqhTYv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ecBqhTYv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23636167afeso46193375ad.3
        for <linux-serial@vger.kernel.org>; Wed, 02 Jul 2025 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481607; x=1752086407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbC/GH7strBGwb0IdiVA7md1jfacDKOVYkS3o8tcID0=;
        b=ecBqhTYv0hRooOBvI24/4iP/zgUK2IigwYvfFYISQFRMloFFOaQHLu0va/BSmYQgA+
         1TL6cbtR7PX3ubrW0AQUqOJGN+kieja0LvdoauASfFdYsX0LXn4Ty556aEtUxiwefdOp
         2kk+nvcF0TNNB7sQgDRsnI+vAyAE75IQI4zVvR9sYCEIKRlDRZ5EE0xu4wERBZisz0JA
         axhw7QLczIqIh5aSnS/dNCpSrvzu8OKZWxg5XIRb/ix4Qsw9a1XZShq99HmWiIxbldU1
         s4uTAqhECBVgFKBmNnGrky3yiMmjH0z53yaP1B0G6n11MLChfbyGG3ZqF5vsEcIpg2ua
         AlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481607; x=1752086407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbC/GH7strBGwb0IdiVA7md1jfacDKOVYkS3o8tcID0=;
        b=do4JbKxA/GeC79xrqzn6yu79m1QGpRtyFqeLxbdDCMSKkgsbWCbIJuhx9i367WMpYI
         aEcohFBXwALrTBFTI7aVWy6qYa8e9HNhkXlFsxJn5xKBGcRQd6i6PG1Q3U+7p7sPna0L
         2T2hF2Rm+K+HF5gQ3z6JwJAu+7mVKsUfdqg9OQr3bIjSaBXbT2QAAla5tNqorth5752m
         NzDsp420A9MY0ErsZmQXGHTXmrRpt4Fzw1NQXVjKdX47UTRnuINEfzW9xRf3Sy142N1p
         TFlskGBKaPPsS6zLM5E8gnAEvdNX5aWd/HPPgnvzhiE1A/GzjWGMQfAn7hQNukV7Uo7D
         vCdw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZceKDVAzWh737Ru6CZ47upJ/3uU2auKlDERYmkXs5KsOlEfOx2pSb6KbCwa2w6o+XYu4EXwV35DWtdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbVS2UD9ubRG2J1NFzZB+tuln/RX1KKgx+/ogTZqJedOAX+Gs
	AnuO68BNscSo+obxlFLX8dLnNCSim4tQhL/VAh2Fl5pn2MNJTw2+CyW+OILJzzQXwFw=
X-Gm-Gg: ASbGnctZ3c1Zcp7o3r+Agv3oo/jDLgKxfm/n9BUjXTN/NrFVzQTUk9Fzwd9zYzxTAr8
	Tgk5pzF96QnnNOg2TBGFS6KHiwovGyi1osnB7FCPzy4juTcc3nzGa+OTeJILvq+6k4Ji2dFb5Po
	jxLOCA8UCsOPUQNfrIqzALeWiDYhWNAAWAzS+sbFL2i+v5j5t0+fvgHaMTrixEFy41GmcDd0HCQ
	AlGqttAxTvASLtANrhNvwfwgcxfXQNIhwvC2fdmLr1Nst7qRTK0Jt3pSZBL2QJwAgbWWa9Gk6iL
	LEHkCo9vx1BN08MujwEwf2QrQGw4WY9Ay6Aod+wUFOH29CTbYCGMeErW7hOSwE9i0GohJ6gAPyG
	n96sjeKPUv32xjRFMcn0v5/c=
X-Google-Smtp-Source: AGHT+IFr57CoKx0dtGw3L8LbGIOnkIEZXLju9E0LUunBcEwcIBFNROCo+7NEiDnUKvwkV1U4hmG4cA==
X-Received: by 2002:a17:903:2f8a:b0:234:dd3f:80fd with SMTP id d9443c01a7336-23c6e4dbafcmr49910685ad.2.1751481606631;
        Wed, 02 Jul 2025 11:40:06 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:40:06 -0700 (PDT)
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
Subject: [PATCH v8 08/10] dma: xdmac: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:06 +0200
Message-ID: <20250702183856.1727275-9-robert.marko@sartura.hr>
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

LAN969x uses the Atmel XDMAC, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 3bc79f320540..05c7c7d9e5a4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -110,7 +110,7 @@ config AT_HDMAC
 
 config AT_XDMAC
 	tristate "Atmel XDMA support"
-	depends on ARCH_AT91
+	depends on ARCH_MICROCHIP
 	select DMA_ENGINE
 	help
 	  Support the Atmel XDMA controller.
-- 
2.50.0

