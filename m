Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDA1E51FE
	for <linux-serial@vger.kernel.org>; Wed,  9 Apr 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226544; cv=none; b=NqqmAiH0hs+Swsw3E8+IQt1BcbWxnr5v1f8WhR9f031C/Q0pFuSizCwfV7vaDK+EWHFe9li63wmuGxK7bjNSvyaaY+gEsTlfL1r43JlpvG7+RI5SLwlyr2m5vwJYaPGjRv6GP+4aI8Zzg5g1N0Is/oBWKeYjdb/wQILP0xGRQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226544; c=relaxed/simple;
	bh=Y2ilGHMUTXCya8rzOvmKtYifGjbu9RYpGCgzY3UBtUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV/NSZvWDWjz14b4f3gho0NHWNPF77QZQTvkjQzp0A8ZyQ7apD2E94hav0r4GKayCt+pRa2itjL65FrtqS0awHmXZKgcGNq3I30SoclXbawTtJX2i1ndK3TB0bJ1nqgddZeOUOJfR1oBFHqOgBjJ+PIM0oY4gj0zEnITey6FamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=OOh8qPm+; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="OOh8qPm+"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-86135aeca58so3195339f.0
        for <linux-serial@vger.kernel.org>; Wed, 09 Apr 2025 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744226541; x=1744831341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNl26J3HRC4XsI0NsNHSQT2PLx01D+6pAV6deX3HHJI=;
        b=OOh8qPm+gkBB5ONASPmYgWUk7rIRRWcuu7szi2KIo7zL1XpyN3WXyaZzUcvPcZPU75
         /W0VEEfCaPUyFuEkD/41Z8vxA9Thh5yRhqeoC/lxCojgRMWptqrfJv4iiYVh53pcg1FC
         +hEXY8p/ji6Lrp0pH2V/4j5kxiCYwGXrATfIOVTw2MSNVPK4plgAvGB/9mUv35rqbcHJ
         4DkG5gxM9xNm5mFQApzf0Ayra1feJPARhYCVKuZr7tflKgXiZB4Qo3tldGOtf6o+vOWY
         EURl2c1IrTyS8iP4cU4eMqx3MJ2G8z+2WouZTLn+DInbQgaG6xd4u+1DuK4+9vPKsQZS
         PwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226541; x=1744831341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNl26J3HRC4XsI0NsNHSQT2PLx01D+6pAV6deX3HHJI=;
        b=DrNYdc1j6TVIiJMh/Oonup4sOj7AqENsjNuyddz92468Wory1tolfk6stoUHw+nxwe
         eB3pFd5HVTnKmaXMqGhxB223XWw6zLsrBeBCMq3JC3nOKQlkTUY90RgVQcA1cuKGz4N8
         V3IdS9keZtvPaOwK+0wb1Bv0oiE/9q2G12+5n3EDxiAV0Wedglv73VSQ6sqvG7kVaLvb
         mIuFumQzBmta27Lg3q4k7Xz+EYmRt3aHcKbPab97lYoiXoiw1BCYxpPFhSnzjy6zR0Bc
         pIMdOJZCzEb25Rv/65PnyOQdPoQzckQkZspfyMp45lBWg36Dp5UiuuvtVVs8fpHmGosr
         wdLg==
X-Forwarded-Encrypted: i=1; AJvYcCUvtNaWUkKKOVLhc1iX5FlEjI/Ho4d3NRpF+NEQTmM8pzeTMJVednFEvb23SV3HBbpV/Hp0vENAtBlgzQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2ZGpC84bWoMw08TSmJA/26Blu1+5Rcwcax67PBvI03/v19T7
	UprhSNcueGx6wfs80vD7ot4FChjz1dXcYJDVh1rL2WOy3hwIQ//9jhScAbSLCYA=
X-Gm-Gg: ASbGncsR1PIA8+nwXNx8Mntnj6/ycF9qjbTtEB/u8zCBBjDmxqHMHiKcZ/eok6TI2KL
	+w3zpzdi/Vii0wpvf1F8cxkrehVAxzZKlPafHK6j7K7NHNFabkvvatTfjwhz2yTzxJrX+GawKiL
	ODCoNYUhX5zxDOiiXNQptuJ3OZtRFpz9wIbImSEL70+091EJLfLX9BpxPEKOO113hMaQNHDv8YF
	jyMzTIQRIu3CUU4NGOP80Ups5/0l1B7ND7CHhb13h2Ahp/USb2dis/7iZyY/BU0URP/X+HgUFRg
	J8P23/o/kqVm+8NYfdwG8kz78zJCFxtIM2Yc/zDD5d1qNJ7u4UVP8weVmL5g3UbuDyrq7KlyHhM
	Ybqlze1sOFfvyhupcSTrY4Yky
X-Google-Smtp-Source: AGHT+IHad8+4ZGmSEydVvWi93B5NhjlEAMlDrR2UwaWJMa/MsGHo4UvOCZSyheMgn+3uP3r9HQq5+Q==
X-Received: by 2002:a05:6602:7210:b0:85b:4319:2a2a with SMTP id ca18e2360f4ac-8616ed25080mr12867839f.6.1744226540652;
        Wed, 09 Apr 2025 12:22:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf81bcsm373459173.10.2025.04.09.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:22:20 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] serial: 8250_of: add support for an optional bus clock
Date: Wed,  9 Apr 2025 14:22:12 -0500
Message-ID: <20250409192213.1130181-3-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250409192213.1130181-1-elder@riscstar.com>
References: <20250409192213.1130181-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT UART requires a bus clock to be enabled, in addition to
it's "normal" core clock.  Look up the optional bus clock by name,
and if that's found, look up the core clock using the name "core".

Supplying a bus clock is optional.  If no bus clock is needed, the
the first/only clock is used for the core clock.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: Update logic to more check for the optional bus clock first

 drivers/tty/serial/8250/8250_of.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 11c860ea80f60..a90a5462aa72a 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -123,7 +123,16 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	/* Get clk rate through clk driver if present */
 	if (!port->uartclk) {
-		info->clk = devm_clk_get_enabled(dev, NULL);
+		struct clk *bus_clk;
+
+		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+		if (IS_ERR(bus_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
+			goto err_pmruntime;
+		}
+
+		/* If the bus clock is required, core clock must be named */
+		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
 		if (IS_ERR(info->clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
 			goto err_pmruntime;
-- 
2.45.2

