Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D126FA50
	for <linux-serial@vger.kernel.org>; Mon, 27 Oct 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556871; cv=none; b=uzYAYjtiE03HZeJAcKVRVD7JwL+CgvIfF37+L0YqX8RjvZHXAOyq2xrb7yVvHMYbOlLtnEyZtV0cW1tfb+2pJq7kzhHbQ/HWEIeOhXM1dW5L8eLKZJk6OtA+/qNhGSpO4qWmxYINC4AyUfKW5NQjKBPkC+Gh69tF5higKdhSbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556871; c=relaxed/simple;
	bh=T2FiuKY307QUDrwGy2QITvUy0qfdAG9Duzl2cYto9vA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okabpmBMDYjspvFG1Jjt2/UO+l0fydTcWyhY5q+DkLQydShXvW0R5mcZnoK1CcisHJGjwxTypwX9FGPKF8u5xvNDJXnc3ew9KmFQ5c4tvyebmRqV3SZRrHaBkT1Ku2VDr1ZxLNechIHSkM8eYk91STU9rjp9w3v5McUn3vURE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz4VuvRN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz4VuvRN"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so3212577a12.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Oct 2025 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761556870; x=1762161670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/gIU/tSFOCdbD2UtPR/QSZA0FQ48iXUTaxg/wbjKYU=;
        b=gz4VuvRNEdsyV2CwQzjgnFa8e2EC1C+ncCogYY5YYBJfGvdT137LLLvEldbGt9Skdd
         piyvtiRZfVdUqmIqBH5fenhgFCzGbf8DFKT9X/Cp8/nig4/KvxBZ3doKipj7WIPxaer3
         HqFTrOLdImrd+il0+dAV2e/kj3J05gmGq8Kdnz2Zl3sisYBZ0zi7B/PnTy58EFRb36Q1
         BNoEe7EziK1UnKnYwVp0+9U/AOVTaJ4+bDgGMXr56I4rQXVSKQoGvDJcI8l8vhX9lMWO
         irnIotddwQ2cv5YYM08QuWCwX5poJxmi9J1ec66ioFsZkXi+FOCPkm2ios66KL1gPBvp
         n9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556870; x=1762161670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/gIU/tSFOCdbD2UtPR/QSZA0FQ48iXUTaxg/wbjKYU=;
        b=oBhoZ6LOlXP0OEBhi2xHWfVFOX/8N4TnYZAiMYvTR03QimKUbBFM3FXQhxGZ17Ojtn
         sHKuy0VG3OfcnTrZJ7rzACUZIrcTOC4L+NZjkzFim6V12es7NieHUYrEOv7cEDR4I6Fo
         U7tw+pbX64uogP5DQQm3e5p1yUCbavBK1FtJg9xabJ1+axUd4dFyUm+67HLRI8LX22Tm
         UT/3/XG9vvfUM1wME9iayEjscntXHdUXh1ILuSW7wUs2VmaWJ6kRyl5P1XsMRfIVHC/n
         gr6Bs+hUDJTR1V3f+y/ANMDGZVj4B+jW7TfM76CuXlNkHgOuimL1OBqQkUSuCpKZlJDu
         VtYw==
X-Forwarded-Encrypted: i=1; AJvYcCXULDndRFtkxvbepTel406lLyFgTrcC5qsDDbnq9k+Kvo2osm3evqxgG9xLaJMIMi7Cm84n2R3iUCZfHxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkySqJxrsJQzl4WWugHiF3uSLIIZoeU3pyB6m60lgi5OC8nvZD
	2VgjfMOtG2T7gVfaZ4BjV2DIWgILz0t/y5MUWI+vbLIIyndzA+ErRWi1
X-Gm-Gg: ASbGnct5tJeZg+MR+/3E235ub7YeT1vS9qIFtMm5Q0NlnB5047P51tpFyMTm+nSZaa7
	OgDQZBeCK4i4N+YJlE3fZvun1Ndo6+FObJUX2zCyXolzyWSdXp3Q8l3PxzjpUyRs03/ep7CSAHX
	rqfvnpT8Nugnvu7eRX2sv5yn4CR8t8qps01bciQY/ebGgUnrCAoPrcwwgE4At2UMkUupoTa7/ud
	4hNxb3yyUSdxC7KG22DQ02XRtjk3BNdY7Cnlib3/0qHp084ybXOj+8IAQI55KZANnkwVhJuGoyU
	C1TSniM2SawQc5Jbx7uFyYCxawPefCvUD0xSze1pLTMo4rWvSYcZNjP0uPexkVDUlINj6m5wE3d
	qbvyui1Il4A9uDwvIwUqNawz5SLmA8ulfbeCJ9wGJaassir0yDf8FNnZRsxtJw4b5YM2LV4xhpO
	EkpvLaEyKUtsbN0gYlyfILhdtnuCSxX0cy
X-Google-Smtp-Source: AGHT+IEcpagKOyJV1fsrM6dM/HwYD5VenCjDTs/rQ5hoHhvZqYSFHENXuZ7ikBTfiwnPt270HOJ/6A==
X-Received: by 2002:a17:902:e552:b0:290:ac36:2ed8 with SMTP id d9443c01a7336-290c9ce63d6mr414278245ad.24.1761556869605;
        Mon, 27 Oct 2025 02:21:09 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b712ce3a90bsm7017409a12.25.2025.10.27.02.21.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 02:21:09 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Miroslav Ondra <ondra@faster.cz>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] serial: amba-pl011: prefer dma_mapping_error() over explicit address checking
Date: Mon, 27 Oct 2025 17:20:50 +0800
Message-Id: <20251027092053.87937-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for returned DMA addresses using specialized dma_mapping_error()
helper which is generally recommended for this purpose by
Documentation/core-api/dma-api.rst:

  "In some circumstances dma_map_single(), ...
will fail to create a mapping. A driver can check for these errors
by testing the returned DMA address with dma_mapping_error()."

Found via static analysis and this is similar to commit fa0308134d26
("ALSA: memalloc: prefer dma_mapping_error() over explicit address checking")

Fixes: 58ac1b379979 ("ARM: PL011: Fix DMA support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 22939841b1de..7f17d288c807 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -628,7 +628,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	dmatx->len = count;
 	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
 				    DMA_TO_DEVICE);
-	if (dmatx->dma == DMA_MAPPING_ERROR) {
+	if (dma_mapping_error(dma_dev->dev, dmatx->dma)) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
-- 
2.39.5 (Apple Git-154)

