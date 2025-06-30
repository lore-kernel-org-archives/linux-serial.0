Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA91DFCE;
	Mon, 30 Jun 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286101; cv=none; b=iH47RgHczzjFqSvfxo7mYaE2lSHBobBKERJ+72NcD79SKCUgZ8WFyC8Hq7qETX5Dt0QaQllqrPDNrSyqio1I1Zqq1d8pVjsdL86IojH3l26zYYXM0O7NRzF3/+Fkz9ah5Ff1XIO7gVxK2tyCyJoEJS2IcyG8YSMebfnryMIQqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286101; c=relaxed/simple;
	bh=gUBGn6LkNrYYfc0MMtJUx1r9qQ8A9wY7woWHmYabnzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmGWvwu5DB2Xyvo1nkgrh+VleIhKlSi/TQ0bkKqXITBtcRb/4k7MsbV8/mX9V6UcZKpPpdTH3/hzh7cSC0LvEiqJgxC/zuvgwrAQeoJO+pf1LeI4vzfqz1+Wg6ep3YhiT4DzYMUGiwGJuoGCM/+Vz/rtbC6qdGwRAJTqVfN9t6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwNKtsBj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwNKtsBj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450828af36aso1447235e9.1;
        Mon, 30 Jun 2025 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751286096; x=1751890896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CG85nVM05UH8KlWyPytsUQqw/p1VMbS1nOa01h9/4vY=;
        b=UwNKtsBjdGV8s4FnYQZ5t8o3U0TKqXN9ijxOiTzkW3s3encDiccxuWDE0hubPZzruH
         n1gVXiraWYNlrkDB+IathI+VBwPhFBADf50FNI7B6htmzItAF0MQ0ApbNlQdSELJoMPJ
         LG32TKxnAYyxl+j4hn2TiAZYWFTVl7JSoibt9NRqfnAgSi1PK4koz5ynYud9Fr/e+CR9
         HOOqYONcQC2XuU4uo02mtad2nu6aBpja4dYmW8GfyVkPDZnDIB1GIbm1MbZcIFoF+5aL
         JySxYj5wA98WOJ+SL5nzZ7H0jGfrGDePWnSjIQ1vzU2JDHXyhKlpRJRSuDqCgMtEUkzW
         npDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286096; x=1751890896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CG85nVM05UH8KlWyPytsUQqw/p1VMbS1nOa01h9/4vY=;
        b=fb0pLa1YxpRFA3j9JKcCxJSJ1s7KvFLRm73JVBpsxw8hofF3TBl8mLZpFTGgsQt7qf
         vW3peBD5Wyk9KS++IYdEErwLV79DiBJC4+xveyw2V9KjrRIM9ABUdclD+i0a3LSxannF
         z4qGPX5VY4d+QPmgtjnNMYjTuLFFScckEtT+r+votangfUMmXa1Hpodr3SFXkOoZOlG0
         KW8iaRenhf1+IGvqFEoutB5FNsn+qoXRNe2a9g/wTJ55R2dmL/buL4XCbUr2xZw85DPO
         Mx6Bcgg8AA8OestwukYMjRSB8SLOA/T7VTpVfM+hvaQlEN2U8MdusO0FMkmNQVKUwin6
         rAlA==
X-Forwarded-Encrypted: i=1; AJvYcCUEEoCykQHO9pgvGydrGBqPxt0IMHDeKic1p2glWVUiaZpz9pi+G1i5LahgbisrePQI9aFQFWzS239nYRLv@vger.kernel.org, AJvYcCWLFaENRi/5LI6fBnbK3rzZLQmc5uZ1iD/SIx97izD0L1Een8OQktvnLCsE5f7VLZ847IUaHmkgQNWTYu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1lcJ2sJtpKeiVxJpoN9J6P3hVAjgyBFJJu8D9g0/ThL7TUQO
	xhoF0U7tAg3nA7L2V9zf7Y9xLjMh3qbP0erw+M8RPSK8Qtm9oXz+BFdk
X-Gm-Gg: ASbGncusyLbOmb4xgvbsAFw1/PbOdnp/37Na+Lhp4T403VTIkNnt1uaMyxn3t4qgqxb
	jjNdXZmV8Dn5uTcbsrYlHKXWG5hO/JXCHUxpj82LqWHDaF4UfkvveyBgwUFuN/xWY6N1z6o/6/D
	g3ICj3UZM9eboUkre9bPKXTKDvM4N59HUKg2YHiauMyp+GXzt3RqKasaVrMyb/LBe6FsKVvV7sP
	ZDV3Xyomo7A5GnE/rpcyXs2E/ddpkKhsVqf2anLxy3h+ciewhJjKk04Svn5RKmDpnx/eS1U8+qq
	o59YEOFjH4Rbec5SoYClgaYqOpkdl4H3D8ToTg9JoOTUFNeojJZTT0dAkaNpcOhrhVeJPg2JUY4
	7ZeiU5yi7SzFoOA==
X-Google-Smtp-Source: AGHT+IGPyiTzplS597WFAua/Opv6CmYnj9L/8QI+8mgzvqs+dsPU1U9+4dQRWDdPswPQvm+BqCZ9Hw==
X-Received: by 2002:a05:600c:681b:b0:453:8c5:95d3 with SMTP id 5b1f17b1804b1-453a017c020mr13353015e9.7.1751286095366;
        Mon, 30 Jun 2025 05:21:35 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:43e:be8c:f80c:622a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe24esm133800375e9.23.2025.06.30.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:21:35 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] pch_uart: Fix dma_sync_sg_for_device() nents value
Date: Mon, 30 Jun 2025 14:10:19 +0200
Message-ID: <20250630121021.106643-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_sync_sg_for_device() functions should be called with the same
nents as the dma_map_sg(), not the value the map function returned.

Fixes: da3564ee027e ("pch_uart: add multi-scatter processing")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/tty/serial/pch_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 508e8c6f01d4..884fefbfd5a1 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -954,7 +954,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 			__func__);
 		return 0;
 	}
-	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, nent, DMA_TO_DEVICE);
+	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, num, DMA_TO_DEVICE);
 	priv->desc_tx = desc;
 	desc->callback = pch_dma_tx_complete;
 	desc->callback_param = priv;
-- 
2.43.0

