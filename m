Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092D4C62C
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661149; cv=none; b=cUsNfs8Bj+0TErMhBc4GdK6a3ibRkpJcp8s/xGGnkkwEaQzGhB34hdymmJ3P0hCffXCZYmg5EKDm4Z4mYLDmH1mb5TTst8sFG/wopBByxuxXSRikYhZc5BXSSez/hb+WvNWuFd30RCo89GCL8izWBa08x/FCNAG43a6a4OCwq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661149; c=relaxed/simple;
	bh=0rvm+ZfAvB34/Bb8MmtN/eXQ/wWDxr8HdRasaolA49E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwi9zcqcXGTRGRXw+lWZz0R83BdSWkmCCkcpRysCB0PZYqGORFXRX2oMwXAVwnl+Qjbewhkt95HsLHf+FTkQE8+1fHmJBp5ltQDttkmbmSmXAVfJS1H4jprlkQ9q4bBOr7bAdoQNOiSg/uhBweF5Bw9qYSpnTikNZbolKGd1I+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=si/6tQey; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="si/6tQey"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso1969825e9.1
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661146; x=1706265946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecEUv9cB/C4rgpKZf48XubyCx93neS07LHrZaWe0W9s=;
        b=si/6tQeyPq6LIimqvEt8VzUpZuHxFU85yfnK+W3rx6Rrk3rhvxg2NQ+BWjGZhdeBHO
         foZfEoTHuad9Plp48UYuJryDZjyrAFOBLQuFL3GZrr3kv6AJyMUe9a/BWBffWOIXPWNY
         nY6XXayP0SQLe5CP6wX1wx2BJy/qrz2v8Z2XRcIxz7CrcwNWhzfWU6jFZmys/v2pPCze
         poeBzNeJjjHS5FAAoC3ekwjm2BC7EXOzyCogqj6GqqQ56R2Mq4Rzl0I1DPzZvN2Ft1Ol
         q8wd2Lg+KF8MEfixrMag5ntOAqrtcmTesf6XMBtAb10dhk+GubO4x8XWVSGWKVUNdY4x
         Pr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661146; x=1706265946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecEUv9cB/C4rgpKZf48XubyCx93neS07LHrZaWe0W9s=;
        b=KEGDDl6buMnwdc2VbiNmxPTms4mXpP/YOVSVUN0bbn2IzDNnuncBjVDBYddwL+3VZK
         f3v/IOmkSydeoTCRo49+7gdNDURPxGeYiGIDVD5n2hn9Vaz2U0ZoPP9vUsyJuslf6dKs
         6/f2AZKaOFVr0T4g6tJ80DT5E0OT0UvrNWWKN7kPPu6jSbt8Fkake1PUF1vRQYa8LxJ2
         kmvmyXxmFCD7gKszuUL9rEJY6xJOQo4YzyyXHH8fm9CPrECQtMTvG69dxbz8F6cxtOlh
         xLhMi9ska1VL9NEOUlkjktUFkGWFb1TPmAHKRp2uziDMs6g66PAtgYPwlfCBYD4WgiRB
         4CmQ==
X-Gm-Message-State: AOJu0YzffVlv3Ae//UdXrbSE2UbZLbMmtphYCyV+SrWXhyrgfS0xFXG6
	hvholYywE/zpGuTQy7uJ5W8C2ZUK6pEqOMp3WNnc3MB027UCjrBcExmFMVKUS1E=
X-Google-Smtp-Source: AGHT+IFYdU7YgMMRHC+DrUKA5MwlIsxGfbocGuG9y6jEGdz2VaUXMw579pgtjEfWCwn+GLZjJgGcDw==
X-Received: by 2002:a05:600c:6b0e:b0:40e:4ad9:90df with SMTP id jn14-20020a05600c6b0e00b0040e4ad990dfmr428957wmb.158.1705661146233;
        Fri, 19 Jan 2024 02:45:46 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:45 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 18/19] tty: serial: samsung: change has_divslot type to bool
Date: Fri, 19 Jan 2024 10:45:25 +0000
Message-ID: <20240119104526.1221243-19-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the driver was introduced the port features flags never extended.
As we don't expect more flags soon that would bypass the first
cacheline of ``struct s3c24xx_uart_info``, change the type of
``has_divslot`` to bool. Bitfields operations incur performance penalty
when set or read as compared to direct types.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c429029c0207..0a03df44211d 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -89,8 +89,7 @@ struct s3c24xx_uart_info {
 	u8			iotype;
 
 	/* uart port features */
-
-	unsigned int		has_divslot:1;
+	bool			has_divslot;
 };
 
 struct s3c24xx_serial_drv_data {
@@ -2400,7 +2399,7 @@ static const struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.port_type	= PORT_S3C6400,
 		.iotype		= UPIO_MEM,
 		.fifosize	= 64,
-		.has_divslot	= 1,
+		.has_divslot	= true,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
 		.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
@@ -2429,7 +2428,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
 		.iotype		= UPIO_MEM,
-		.has_divslot	= 1,
+		.has_divslot	= true,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
 		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
@@ -2459,7 +2458,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.type		= TYPE_S3C6400,			\
 		.port_type	= PORT_S3C6400,			\
 		.iotype		= UPIO_MEM,			\
-		.has_divslot	= 1,				\
+		.has_divslot	= true,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
 		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,	\
@@ -2498,7 +2497,7 @@ static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
 		.iotype		= UPIO_MEM32,
-		.has_divslot	= 1,
+		.has_divslot	= true,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
 		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
@@ -2569,7 +2568,7 @@ static const struct s3c24xx_serial_drv_data artpec8_serial_drv_data = {
 		.port_type	= PORT_S3C6400,
 		.iotype		= UPIO_MEM,
 		.fifosize	= 64,
-		.has_divslot	= 1,
+		.has_divslot	= true,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
 		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
-- 
2.43.0.429.g432eaa2c6b-goog

