Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CDEAD1
	for <linux-serial@vger.kernel.org>; Fri,  2 Feb 2024 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835911; cv=none; b=VHwGu7q/KXJkB8OksN80cnZkRM1sqp7roC02Eass/J4ifmyGXMy/YS501cQfv2of6MxerluYi7v8LzPV/bfxESXKoobmNXEAERHw8SWYpfRcjIpi+8ZwyNMx5AG76sKkDCtOiBilomZ758qnrxUFkYZpum4oQuELHW8nOxXFD9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835911; c=relaxed/simple;
	bh=7PGtiOLQjanCi8F2lUfCU2lTtZMSLUVGqrAhBRM1FOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=janiQmRb3ewJRKkCBt/P10CfJmXaPVJcLQNQjfWI7kX8WmsFDB/AGN9Dint+oKAgFXmV/VVgMVFGousRbt3YS5qwaH+teniMHpyS88xAyfCDup7VySTDkmDBVssZfoOJ7iB2ToEfpSypd0O5RQ7DU12yg5hjc4eVk0RkSKi9YTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uzsU+wtY; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzsU+wtY"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e11faeb125so770379a34.2
        for <linux-serial@vger.kernel.org>; Thu, 01 Feb 2024 17:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706835908; x=1707440708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SwapE9xLdXkr+1FZM2yZImYM8kfTZEX3iqcU3VUeD0=;
        b=uzsU+wtYDGGXhPKLI28SmCscN92VLwtCyhPKDVcPbgtFAROQ7WqnLTi6fxqwg6PXTq
         rCJEAvF2g9H8Oq7gPJv5LMBw/xMvW6yPijLZU3XyQtswkpSslrPefqd5o6nXMCVxA6iv
         m+u/gfVw2R7mpp2CQCnvgoLBMA+SWDo2WkuP1mFBhrsT9qN4phiHfy/UvjNU7v5aei22
         EdqT0jXYE73cRQYka9uCbyBo9Ucb0PbB9aPOI0RqxwiTjW5kH5ag5xdb1VqcFRQ/d4DS
         zRXOp6ZYUxRkqBcLalmilnbmuGPu1zVkNPq5E4dmX9LqBgvpGp1fAauxU6pQ0S5R8iIh
         wN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706835908; x=1707440708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SwapE9xLdXkr+1FZM2yZImYM8kfTZEX3iqcU3VUeD0=;
        b=GSejpUD+s6U1T6ZgjPObN8bzKBKges7bPsMP6KxS9uhL3tazmlr+13QQk9mpnsuYUY
         ETVgjyMdMyAJX/C9WyJIcNzS31FlqwaKHl7Rg9An1ssSCsrit5Faiw79KDJjCRvBl60N
         VwsukWfne4norP1sz5C3QPm1gpwh54AQ7ALjPTPO61E2mUFw0HNLq/xxsM/koChH0hbP
         /tVapzQqHPPNvXD5qTJL2iKj2vjl1uWFuGajqvCJ9sEShCxTwf8zv4dX1ar+m3qEgzMm
         PibfSOVanAGQbbLyYT7NfhlRtXmEdv18HxoJkcbLzoKsgo6lSKVes6rr6PeRWhdn4BDk
         s5NA==
X-Gm-Message-State: AOJu0YxmPKmQCXgtYytfyenG2Pp9uJk3rFopqQn0AvjUd5m+y0zB9LGC
	m/05GughtEu2SWSa+EdkMMM2TwbqQdmZyG/da7T0zHTS/vXyRhUQKXEh2jwYNsU=
X-Google-Smtp-Source: AGHT+IHHssTzP7MXolDOLkfQGC5ALneKZAZicvelx4/ifGxiL8zBzKn0w2ESMFFxOFjxQIO76cQMOQ==
X-Received: by 2002:a05:6871:4502:b0:206:c520:2811 with SMTP id nj2-20020a056871450200b00206c5202811mr4865347oab.2.1706835908098;
        Thu, 01 Feb 2024 17:05:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQDuJuCrbniDvpUfQ6lL+8xFL7Q3VSs/I+mnU+pKKO5ifo8TpBvmZ3Tk05LFi+zq4+CoiHahvPWhMb/h72W/xpxRAwgN7eEArtvHJeEwuveMGeV+dQ5oOgNNN0dn3DxT8qSvFXMduAHdj/hzWkjmPsVFw758tdJzK/PHu+hTArsZhhsvN20QmcVJo2KKHHpjA85Ky/sVVobTLcIhxlUh4v+5m16G3zfAKGl7GjUNcegid5qHpct07cIiS8i8uvVMg/b24ZzqMJz0JMqbjoxsI0liL/zUHJwYDfwZK/96pvkyZOPDiS
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id ds43-20020a0568705b2b00b00218e9960187sm229534oab.13.2024.02.01.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 17:05:07 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: samsung: Remove superfluous braces in macro
Date: Thu,  1 Feb 2024 19:05:07 -0600
Message-Id: <20240202010507.22638-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
removes parameters from EXYNOS_COMMON_SERIAL_DRV_DATA() macro, but
leaves unnecessary empty braces. Remove those to fix the style. No
functional change.

Fixes: 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index fcc675603b14..23cabdab44ff 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2452,7 +2452,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
-#define EXYNOS_COMMON_SERIAL_DRV_DATA()				\
+#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
 	.info = {						\
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
@@ -2477,17 +2477,17 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	}							\
 
 static const struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 16, 16 },
 };
 
 static const struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 64, 256, 16, 256 },
 };
 
 static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-- 
2.39.2

