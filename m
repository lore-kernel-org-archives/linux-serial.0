Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C8244695;
	Tue,  1 Jul 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369814; cv=none; b=hK1gQUrNgrwCEcrLNuvd4GmoiZZTxgO2KeEk2XjWWx0HukSQkxxc2rrhDx2SvTFPGTZINiPhnZJZ7oYMeEi2UHRF/ONOplNQC8M7pwTzmXrbgzlSwYnKg9xRr/T7GiaXtAatuVyO0upcPZwmCy1CGNjlVwP2T7QK297Cmjz4zLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369814; c=relaxed/simple;
	bh=zIwmF8IC5QDpQEdWGzxI+Z2zWLEnRkubt4JpDQ+iYU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGgCikSN04V/OaaXA2T+FYhd5VOjroleBKjxhfDvi7UI7Er2nVuD3kui80i9Sh/NNG6y+9O7Yggj4cMiYaf4uJC1x8KMaSmwEMS1P+ICbkm86PRxvAZg/z7xo/U5YFnTZ8wRDtI76C+Wq4B9o3+jeIc4aDq6C6fPVFylqp2hO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt91GVmH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt91GVmH"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso858708f8f.2;
        Tue, 01 Jul 2025 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751369811; x=1751974611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoKs7u+y/vYoT+pBIVA9Awsc2GEH+2XOxBHoVC0v/yA=;
        b=Lt91GVmHPQ6bleyqzjI/GAfZkdU8rIvcQ9h71zhyYQ5y9H9eBx66fDHo64DE7CQHPX
         0r8o4IWiz1pt8yqqxpFuU6KmWfgHVNgA1fooXxCP6dz7xuhBtqEfAPeKxB+ChUAfblFV
         IaMbcCSw4UtCj8w/cmCDoeYJp8mSTIGxKbHNxflKfp6eIhWdatNW0GWj+HiHY9aCPONL
         QX3zSmSlDbRAHDI4n20O+l1a4dnUmYxdImEAntTuxb5UYFs9wcTm+URCRM1RZAA+y2J5
         UJQnPHbEBw0IJHziFwXHrBiCJSjQ90xKFOQ+Y4EEJyTjPBoT0O3hc3ig6fxTBurtdyqj
         Kbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751369811; x=1751974611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoKs7u+y/vYoT+pBIVA9Awsc2GEH+2XOxBHoVC0v/yA=;
        b=hOPKqYKfZMYpWfY6JujiqjCr6wB2k7IGfYwbKyY5yp38/NSw09iaIWigSoKmWmEpsL
         Du122FYfyezA11gi4ix3dASWdrRtoK0dEt1fl4qP5yirWwVHuBuMJN7a1L4P12zq/1Kg
         6/LtegwuOpQhAo3+xuI5V6BPjjrKgWd26Va7UIdL8oohAXyylPmMb0mStA6faglryxhe
         e0YaDsul11SqNFA7dLWTbtaQCzVwPEXetKhfyPrf5o+hHWlFK/ZRPf0xrdfa2mEBXlB+
         oo+eTp4wPo/r41sEK1zh4fNWGpFgPTDm81DI242tJEME0KPF/MsWHVekcctulRvob2Vw
         ixIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMVvkqpaLg++i4ydFNg1XYfNMztsrch9qgffjXFOcA0/3CNPhRqizJwsYAlTtq91KaqY80+YEdVyfLF9U=@vger.kernel.org, AJvYcCWVzXn2LXRLe3oxCdbZLBupOBh5PKbhjbdX+K/5+sczZ6fnxllICOO0w0tispZEO3c9+346rNo31HCun3yr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kDo2E/blkORSsGI2YJXnKWPx6+1Ne+/TCgpQGJJTNDJm8T9f
	9GC4TwFU10bhGU6QvNt3zQ2jrQ2il6EuMLXc94poSMU1cdB40mOXArws
X-Gm-Gg: ASbGncvIwctVNTSiF96WBYEoOEU0jyeocisZueuiOckmLKzo8p0iz0NWBBKte70MJ/I
	lCic7yR9T1aB9CEfmgSIy/6wUwZWoXP4nh/FU0sUxByVN44eWwqTOQ+0lNOzqq5u8jIaHk4Ktp/
	Z1veCLFT+iM7RTeO+drsAfOQB1E1sC02fT4bTrTQSnYVheQkTmrhxiK0CKqbxXUtYeAgRPkgaPp
	t7i9ZFx853fc90vIM9gQTf7cUBxeVWuec0UNI79hBf5ynW+ectrNWis0QMYkDTepx8zQFzyGuc6
	ec+tOkrVfqCYflKOBI+QfhDOUvcRetshxbQlqkQYy9S+c5219ucuHvhVTHoqD7tKONMy5PKufyy
	ZYfvU/OpeDx89L3Q=
X-Google-Smtp-Source: AGHT+IEUXGzqVCkn9/q0+V5Gd7PV3Ux28qnB0lnP5oyWUHZJ7yoMOCaj88wRpIdcD4Oh1oVTvhci1g==
X-Received: by 2002:a05:6000:400b:b0:3a4:eb9c:7cbc with SMTP id ffacd0b85a97d-3af26441250mr846713f8f.15.1751369810431;
        Tue, 01 Jul 2025 04:36:50 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:a723:4386:e2f6:bd22])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c7e9d1csm13194021f8f.13.2025.07.01.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:36:50 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3] pch_uart: Fix dma_sync_sg_for_device() nents value
Date: Tue,  1 Jul 2025 13:34:52 +0200
Message-ID: <20250701113452.18590-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_sync_sg_for_device() functions should be called with the same
nents as the dma_map_sg(), not the value the map function returned
according to the documentation in Documentation/core-api/dma-api.rst:450:
	With the sync_sg API, all the parameters must be the same
	as those passed into the sg mapping API.


Fixes: da3564ee027e ("pch_uart: add multi-scatter processing")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---

v2 -> v3:

- Adding reference to documentation

v1 -> v2:

- Fixing value

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

