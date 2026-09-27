Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763B3C1D68
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541801; cv=none; b=l7TxaCX8DRmo11vVeC7XGc2mWeU7BEQQ1mzYstuTbC3wuyDC7l6twh7SOV5R+rI9t6gB6CZdy91k5DaZTaC1OQyV0iBukrl9X53BSJwTtmE3Iv1KJG2tB3NxN5PN3rB/VWHYd1yHzTq7v+XOplyvv7LkJP1N2hYCu0fkm5plt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541801; c=relaxed/simple;
	bh=cjV4NaIZQhTz58n8weFbuvPw7BYuUNcYI7Q+DnPUu54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fg2RcokGPTZblWjYlimKRO71wDBLicf9xuapACa5DkTQ3OXpT/zQW2TwSJP4MHKCXzIXM1bY/L92EjIPbYo30TMfiRC0oIHiJrdSTmS+PqudFaSY2oVZdestH2KpVh+H4vcpQljmPNoV5Ei/Lg4vhBVjPDI/+1Marb5ciatRnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMbgvzrj; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMbgvzrj"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c3304833so802535a12.3
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790541799; x=1791146599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YfUIOw0LZDaV+qpARbEy58798D+e2vA00v6oms+VU5w=;
        b=tMbgvzrjyASjoCvjCcMmnp0uGm/QCHXhSkaNYD1pOQ9kLi3J6aiOqGKgdRKaeOMLWU
         wvPzaRKOfnJCtw/UJHb8a30IBhxgBZ8bz2DuLNEJZzPVHxMCR4KeL8h5iEs/uYvG37gA
         WLFFH3nHBRLi6fs5BtOC60Gqpj22vhqt4Y5sj7ltHA1Vvbj5eMXtEriz3f97ArMbgHFM
         hEQmX1s/qToo+cBb9YeYDGfjRdjpTj4g+9QDiYIXpWJg7o6NH9bqCBUryFiywOmsFXFH
         81DQo0d3yHPp8Mg+9a9ybL5WKdXysfMp9WmbbsTVylWms6bMGgSDwC/LhAUwG8QF+/0e
         ddZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790541799; x=1791146599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfUIOw0LZDaV+qpARbEy58798D+e2vA00v6oms+VU5w=;
        b=EnkwFEIfPpaC1VI1p7XhIFKqgYHZ/c3mnpXS4NWIqGh5+DLVpsVFA4e87Dtwdglm7n
         To1d7s+LRc3WM6N3XdkjD8oRTruqqSwzP5XzLy/RxeRA0xKncPt8rq5eBRjOWyJkJoQw
         W/8wgSTB0x6WpEXIjCzngvtQRVuuk9IUER657QDraIr84Q+pGA+FaYR+Oj/DAFQE3INi
         nnFiU3KoD+/DIRRISCsKRpSvNcexziP9eC+lrRjXL5veDtPABfEHTvaCiltSlpy2C3qo
         jR303EUqinxEEowWQ0PV8QKE1hvdh1M2NhUiv4x2urhN4KCFApgfMsNPCQOmH/oZEy/3
         oF4g==
X-Gm-Message-State: AFq9FYIDnP6Ep0f550VGA4nKEFsSs0ornEgixQ4fr5SCWNfYGcks3csu
	8w0fMw6lMVmazujiMa4V/VMT2hUn1tbmnPGPMymsAX/lB/SEz9hRl2hlDdubHPRi
X-Gm-Gg: AYBFou3+Bv9dagqqzJ/NMdzuhSmOjVrfsDR62+UR5VPusvgZbsF/nDcGC6seQp0KSM/
	yn1UE8ydFGYIjJnLVvlUfW75AmuK9IxfbwO/MjcouLB9OtO5znqEj1G/IR7wIBxAuVO4OuF5imp
	J//d8uUV/GltqZEalv1r3mz7u0rRppo1pdbxVo4yuzk4ssl/RmQ5Lwsr4jLSzoQGkSqDlY7RxQX
	jMckSDrtOp9nlBC+E932EOFRZ2VyCnL7L+p81y4Wt2oIRt/jDUiner11/3MnoV8MFWkgJ/UQoWs
	tK1l1UKEjM8SswoI+VKYrAd56/YOqvfEnuDiiFmunK8Z7OQhfb1bzx8S655POmbaFqqJGzxwZyh
	X4XTfbiT+Cb/a08ogL3e7enEmDn9ZhisrDAMwIz4TO/Fx8qc1KfDFVBztoUqMqMJPU8wBKrfTRb
	plaQdGYQ6MrZSOT0ASKJAci5sjEsc2dC6z5/vGfl1IK2foGVta4c1/uJgDCMBMlnqYf2dldyisF
	zjy8qYmANFhP5ZKudsuRUVhSFsamtIJ9PVUPdR06Owbw9qbNi/ys5ovMFrp8r+HnF+wgOqm47Jl
	SmSk/gjmSu8XKJvmdbBYo/Te4sFe9l6IuHau9SiWIaUg+7Uf
X-Received: by 2002:a17:90a:d44e:b0:3a0:bfa4:b966 with SMTP id 98e67ed59e1d1-3a0bfa4e2c5mr5503688a91.61.1790541799021;
        Sun, 27 Sep 2026 13:43:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm23288711a91.14.2026.09.27.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:43:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Timur Tabi <timur@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC UART DRIVER),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH v2] serial: ucc_uart: Use platform IRQ helper
Date: Sun, 27 Sep 2026 13:43:17 -0700
Message-ID: <20260927204317.21546-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid calling irq_dispose_mapping() by letting the platform_device
machinery handle it. Also enable possibility of handling -EPROBE_DEFER
and other errors. Handle before any allocation or anything to avoid
dealing with gotos.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move platform_get_irq() earlier.
 drivers/tty/serial/ucc_uart.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6b7dcbbacd13..96e3c9534de7 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -26,7 +26,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/dma-mapping.h>
 
 #include <soc/fsl/qe/ucc_slow.h>
@@ -1238,8 +1237,13 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	struct uart_qe_port *qe_port = NULL;
 	struct resource res;
 	u32 val;
+	int irq;
 	int ret;
 
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0)
+		return irq;
+
 	/*
 	 * Determine if we need Soft-UART mode
 	 */
@@ -1338,13 +1342,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		goto out_free;
 	}
 
-	qe_port->port.irq = irq_of_parse_and_map(np, 0);
-	if (qe_port->port.irq == 0) {
-		dev_err(&ofdev->dev, "could not map IRQ for UCC%u\n",
-		       qe_port->ucc_num + 1);
-		ret = -EINVAL;
-		goto out_free;
-	}
+	qe_port->port.irq = irq;
 
 	/*
 	 * Newer device trees have an "fsl,qe" compatible property for the QE
-- 
2.55.0

