Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063934251B
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693600; cv=none; b=mpvvRVBZLkvtiGst2wYpkOpnYkATWKTvyl5F7NJdF2GcaVZ5EPqAapTkJP/KNCEdf67o9xKBq/b11C2ml07o/hLms8QB0n5ubW66dJ+qJIgkISS9uZ3sZuNJDz6ZHctQZdEbBw3egKUsfAOEGT545/qV2+OJ4xaTvtaAN1KRaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693600; c=relaxed/simple;
	bh=SrgFMyROmHNBLrFbCgp+FteKbeTypwiuhwV7d4eZYLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4N9NP9zaJTe9BY6q1Jkzyh3NOxejk4zquWl449mSi5fPm8ohnj0S55pi8+tF6r6eWqiViFIkaJcPpGkbYXEy707U3rNET8vN4YcozOyXAfb5fda9JmXKS1hE9d3Gm8TRKaDn2kePenzPnb5xbweLBJcIVQcwk0UAl5+wh3dJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz0otMsN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz0otMsN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so27271565ad.2
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693599; x=1777298399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtA7XaAsBped8tzDKGVHSMvp1WbWNwbAvXQ8vkybz/I=;
        b=Dz0otMsNBrkSCoftCpN6lgdJzZGySk2ML3Gi0iXbv4MCNDcOPEhpj+lzWWGNAlbTAI
         hL2n4lmaRlU3GmtU8jNskPwEi6F2ovaH+6OAqlm9wCNLSS9HWwbkGzzUOHvE2j9iNhsQ
         BR2EL2o/NDPHLoAax39Y6aqKBbvz7rymXPprPa4Y4gAFtnyI+VamwVwrYGzO4/Yi0O9v
         uAczbASKykuQQhrzoG024NKStsrgEOkJEUNcrMANQ7x/2PVMxLAOHKrnY/uYGW1tEnba
         B+7JrHXdFh2e6++zQpz9V54zoYVPhS1zuk73L4iSslChBoWx9nG07AJUvtONCg1LoVs3
         FfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693599; x=1777298399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtA7XaAsBped8tzDKGVHSMvp1WbWNwbAvXQ8vkybz/I=;
        b=UKexvvRLMFsz2+zlXJrT/t+Nx+zQ6RruYErUw/Sprwpv/1DDEmrUE007DYmaZ/TJWH
         T4HSVY+WiujcT4ZJs6XsfuSynuBMRurNhGJmwOGIWFoH6eI6IMLCPnP+gdkwhhHhHMnl
         VBIugo4Sy/Dp3kQ3/9LW+QSMZp9lvRpS2a1wGkBysknaQi1TYOFwQ29JYKQEet0SeGQH
         QtDBKxC6LOvRdS1IwCJ1i9LRBDR37PDaQmPCd1ag09R6KlBK1sPqfdVwgemmPTLhVv8B
         BElhtpjuL4SJlzGSEzsq4I5qQrSa/ENL1LL3HP3+JVk9UMLg97/W3FkQ8md/8iaS0ndm
         GKUw==
X-Forwarded-Encrypted: i=1; AFNElJ95LhvrcaYdfdExLbb03J/6gFcxzOAGor3xfXN40zheQXEeWw6I05NaPldphu78s92pB8Z+9Zmsr3g9VKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vYFgIOSPKb2XLjhqJpn0mU4R+pkP0LecvQvas50Ssh9pD6SP
	8K+E7cgtaeItENqzwFMWTti9YWbjbMfcbuvBHWyEIOT23NX7IQaCsyzr
X-Gm-Gg: AeBDietiUyWUWVZAmMu2J8cL38I0FOc8InkPULZnFiMTFMMvirCoSzliXvtbIDndvEx
	jbnSnidJrWcCvFKqpG3PjOb9sxMAz7tPwO8695m2Kq4ziyVw8kGBgCH18LZPE0TWqN8crzlARXN
	y8xnvla+RIC+3D2PRTvjwOrnx7sdvinJLne+X9Y0Gg8DUyMmUPw1q6GYZMII5Rk0744mWzqPcsl
	ZejhqqdwHI+FBBiPmbpZECKHqRXcjBd6htzXdSbGCbtNlAome1IZ8pJENszyoLDvrN2zeKQsA4h
	WwlikNrmAzOSrIT+27MdQTsa0M//8fwsfe1dwkM6MnyZk3oWfLW5ydalcwt/dV+wz0ozD9UZEPa
	Hisian/Vuxh2maGIaZLWfTEE4YZCS3hwDy6u8nrRIX2mT43fezxTgVy7ZQycfvsVVR9IojcPMiD
	601FGroap9kZ3fJ/4f8SilE+a1lLcgk9vdq3a9SajrUFJEIu7/AGn/GNV/nJp0c7sOlTX+VQVs
X-Received: by 2002:a17:902:ee84:b0:2b2:4697:78f4 with SMTP id d9443c01a7336-2b5f9fe094fmr113361365ad.31.1776693598648;
        Mon, 20 Apr 2026 06:59:58 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cd18sm112575965ad.45.2026.04.20.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:59:58 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: bhuvanchandra.dv@toradex.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	sherry.sun@nxp.com,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH] serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma
Date: Mon, 20 Apr 2026 19:29:03 +0530
Message-Id: <20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lpuart_start_rx_dma() allocates sport->rx_ring.buf with kzalloc() and
then maps a scatterlist via dma_map_sg().  On three subsequent error
paths the function returns directly without releasing those resources:

  - when dma_map_sg() returns 0 (-EINVAL):
      ring->buf is leaked.
  - when dmaengine_slave_config() fails:
      ring->buf and the DMA mapping are leaked.
  - when dmaengine_prep_dma_cyclic() returns NULL:
      ring->buf and the DMA mapping are leaked.

The sole cleanup path, lpuart_dma_rx_free(), is only reached when
lpuart_dma_rx_use is set, and the caller lpuart_rx_dma_startup() clears
that flag on failure of lpuart_start_rx_dma().  So these resources are
permanently leaked on every failure in this function.  Repeated port
open/close or termios changes under error conditions will slowly consume
memory and leave stale streaming DMA mappings behind.

Fix it by introducing two error labels that unmap the scatterlist and
free the ring buffer as appropriate.  While here, replace the misleading
-EFAULT (bad userspace pointer) returned when dmaengine_prep_dma_cyclic()
fails with the more accurate -ENOMEM, matching how other dmaengine users
in the tree treat this failure.

No functional change on the success path.

Fixes: 5887ad43ee02 ("tty: serial: fsl_lpuart: Use cyclic DMA for Rx")
Cc: stable@vger.kernel.org

Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/tty/serial/fsl_lpuart.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f36d50fe056f..296a096be351 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1376,7 +1376,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 
 	if (!nent) {
 		dev_err(sport->port.dev, "DMA Rx mapping error\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_buf;
 	}
 
 	dma_rx_sconfig.src_addr = lpuart_dma_datareg_addr(sport);
@@ -1388,7 +1389,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	if (ret < 0) {
 		dev_err(sport->port.dev,
 				"DMA Rx slave config failed, err = %d\n", ret);
-		return ret;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(chan,
@@ -1399,7 +1400,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 				 DMA_PREP_INTERRUPT);
 	if (!sport->dma_rx_desc) {
 		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
-		return -EFAULT;
+		ret = -ENOMEM;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
@@ -1423,6 +1425,13 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	}
 
 	return 0;
+
+err_unmap_sg:
+	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+err_free_buf:
+	kfree(ring->buf);
+	ring->buf = NULL;
+	return ret;
 }
 
 static void lpuart_dma_rx_free(struct uart_port *port)
-- 
2.25.1

