Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49629E0F7
	for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107283; cv=none; b=X4T6Sjt6TdF2y6V9sx/999NjFONYka7JSgRFfeOXvXAgZ89KQTdEOT5aBb+f/9SnByXOXYl9g88IdZk0t94JsxAhLa2jezH++/t5V0nH2aBQAsoS9wDPRC08uRdKpM1gKJZciBGhoraQdQWy7c/ueltLPjAb51Vo/VtPZuO90cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107283; c=relaxed/simple;
	bh=ONd4Qs9MdmtR2emzr2R9EQwalmRVkxN82kEJbRPVoKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHE+FV5oy8yZ4kd1OgNCqVs5AsYIX47zcNXagPO7e2uO0WJgfn++QgOi02+BnqPGYIYM/t9Isr5TiMHiTfmIGFmK+oQ6hiLWv5ftJZ+nTKwv2I1UdKk6hlhz/atkkqpqMzVBgdJUkeKzy2yJ7/XjHa+NpckqxTFWlh2OnPf9leQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JNF06wX6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JNF06wX6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8704cdc76so7744985a.1
        for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107280; x=1755712080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLNf+0ZsNl67A+boQNElFMCPPvbgNyj3cPEZ0b5ZYx0=;
        b=JNF06wX6gz39a09M7XuaKCZW3/otWAO4pMw9c0PAncCcsbSayAeyfWFwUmKsOnYlAG
         v3gtNyeV8KSFPs1YjW8t0Ky1f3IVP1iQ5rcvbHy/YlecSDNZebO6QsfatVp6vFJKViXh
         fSmyyXZxUOJhjs/R3cH1YwlxmtTbQa8ThKI3UHXri7lpI1mAOIch3Mhv/QkL4f3hvN76
         R+Rp5rmnr1ThB6h7iTevYKSp/MSwsd5bwBBBt9OOuvRjqYFAVUNUqU/C5DXypohSERtx
         /4uzV8DzmpfHf4M9cJLlzhvDGormIM+qeyluC6jXzuVLzpHHBdzU8hveYSKEt4htd9Gt
         naYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107280; x=1755712080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLNf+0ZsNl67A+boQNElFMCPPvbgNyj3cPEZ0b5ZYx0=;
        b=mXi0PAHGBfR7I6Tea6ksbf3iqtfH4++YtpDmLCnDW9o3vIKk2HgWexu9wxhmlZ6xLm
         qht4/PKjngOGnYHvjcAPi5hbAbioYtRwj3/7tZ1MEywTjSHIHJnwLh9eLRc0zlwKwp/F
         cwe9uHaTEWS1Lm1ilKYuKpLenCOuWXTIYJxhL7xsTDKRhCy19quUFuV53UYX781w6DYi
         bvEThrubB0tkEKEg0FuWriWePs9tmQ1FauMb9ODxcXRNF7IKbzxsIQ6SiPvYcDl5i7fK
         xNXxvxpcXonu6czmqxsKnqrEjBmuInBJNIW5fwRropO6ZUYLXqrHoUO0XjZvxHtVaWF3
         /r4A==
X-Forwarded-Encrypted: i=1; AJvYcCVC+IQX3z+q+90gytJcKp/4wDYjWVJoYyXukPXmvNJMzjx9ZkjIbmbt/m6h3EYqnigju/NbqvJJzj14hgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmztSiu6P9KFyps8nU3cf6yua258yDaaC5GCT76VQZou4A8ul
	jfXjEsLf7wipHkIZriItGZ9GdiH7ZO7987PdwPmGny5rksCz5jDJH38kPH25BKfEwXw=
X-Gm-Gg: ASbGncsBapcD+TLaDp6JU94MriEEK4zcGndIdSZV8BI8DBA3CfoFP4RMVXg4KJdV9dP
	qwpwgGVCkZOUbVb0JVHMr2DPRxzMdSmjvlQhSvXeAujpo12PY6ZnEicC1SzMari6smtp6SZdsZb
	I02A+Bu57MUGVAKZ33MJHJS6OnskVUsQ3/JUKwTFoysdhMYPcv6p0AA2b8nVQestsU6m5DpCjTX
	MUMgk90PkDkdZPiSl795E07KDHgL2SbJgY6ER90dMT8GDrGEmM21hyAFtlh75o4YDQs7Z4fJ52O
	j9JXP5/jpeJfe/rLjkXc0IjtY67MfnYgtnqRv+m8b3SxG/T0VAz47q/aCj1+vZt12l0xz+VlXkA
	Ji+9LTqTsrW6yHwgJzyLBcfgEg4B7J8SRoTi3yccsXw==
X-Google-Smtp-Source: AGHT+IG/snJ5W/RG0E/erOkIvUu/WH4PIM7qXx4xAitymXiD3NRL3HZn1ijMkWxa/MDJZoHs07TE8A==
X-Received: by 2002:a05:620a:270b:b0:7e6:9a4f:a299 with SMTP id af79cd13be357-7e87041fe25mr33631785a.16.1755107280240;
        Wed, 13 Aug 2025 10:48:00 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:59 -0700 (PDT)
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
Subject: [PATCH v9 7/9] i2c: at91: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:43 +0200
Message-ID: <20250813174720.540015-8-robert.marko@sartura.hr>
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

LAN969x uses the Atmel TWI I2C, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 070d014fdc5d..c0aea0920f61 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -414,7 +414,7 @@ config I2C_ASPEED
 
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
-- 
2.50.1

