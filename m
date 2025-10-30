Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BF374ACF
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847100; cv=none; b=s8tph9H4jyCVDcM1KkviIdK64ND7dNZUYV5NtNTgQifx67jUdmxodPKPwWkLyNqmXQjjOgMEtAKveyMR15K5tA+0TLAsVMkn4e1crGvzcCWREB7LeemhqBub+3libYQVByNpS74RPWjP76/eNuiHvMaQR7McfGKIjlALEPJzCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847100; c=relaxed/simple;
	bh=KXgzGd6gNo09gi0VZSrUZARuDuGxlTCFI7gHi/TqNjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO3KuQfftyE+0apUk1wjrOs9FNhw+tF3wB+Wf+5beOftOEHMvqaAGxKPziGfvIz1bg13KBC1VEjP5T89GoYtS2CJfvZngea/6jWNU6Q25cx9GXX5Ie2PScNSNnlQNmVQssRDo9TKKYFvpUuyxUXOfbsZu9KMjtUS3VoQdQ4rHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNewtzJo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNewtzJo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475d9de970eso9686785e9.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847096; x=1762451896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=JNewtzJotfw5LiLe2JGXAzYyGpsH7UwUG91pj2aKigmiysVtMavQWQpawJwo3XGX0L
         tMnLVe0GSNO0WDB+RqVpPANzTp1xQbYk5B+Prr3SqU9hhZ5GyV+jczXyeO7NF8sA7Tj1
         tAk30mJMsnUxaIy/m7EsDHiWP7feEjCBUCooJ8VjPrZnrAJ0xapsuqHEL4L8RPP2OLGW
         hpKVnUPIk1VuGAuOD1b4Lei/4PqbD4ZP7kp+qdLymtXmnlz4Ox4gzExymDJkAqk0xrXe
         /l1kG2Mq+5OBQJkG3CKBzQgsZA9eN0unEO20Lc6P2q2cB4cf41RMxEJo9zPYgR69mnct
         J0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847096; x=1762451896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=NPBU9xJhtYVWtKr3zFWXYbCWv52dQEakO0k2q5ABsk2wlWMdG5am9Z1LJgiUg7ElpJ
         rzqgvJk2fKcvnWpNjQisbPWZT3+3jfZre5tNJ/N5yIWL36Rr2jxHZpZOi8nzdsJ/FV0z
         ToQrU2OvR+BA+V6gsNR/mi0e27Y0v6FwZuxPI4ucIVbu9dn1nbd9sY2rpkKbwsWwQbnd
         d8EvxE4CUNNlexUGmu0Jnw74D4nJp05e3865xQtqeS2snhflx4MYa/2JmzbAiyf6bbTo
         C0MTbnXCPkmmTtztgz9XN5qP0zn+aLA1H7SDR8GNSXhKNXVy7uth151R242iTZUCyXH6
         6npw==
X-Forwarded-Encrypted: i=1; AJvYcCUEQgMMLi4UQ3oX5CzzruFyCQaEMtJaMDRh6Hh2D2KDmbxuZtBUhyxX1/x9/Ugplt58UIcsStRF8o9fcuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPrGcxsjg978slec1IbIlPG6Q/Y/DwNJUVvj3qqI8I1hHaUkC
	YbZM//lEVG1ICmkpatIdPZ77Egr912bSt8fSa/62LLYFtDBv+2yxRrym
X-Gm-Gg: ASbGnctfZniyafso7rzYl86uBa4lGovt7n0yPYizQhIbXgMDWpumUrR/nz8fu5i9cXQ
	Wv9pfBEXV//X1Eghdm68UDsmiAOe9CoYoPUOcMPLg7h54VI4P5MlPoUOJnXnoiKYrVU7QZEJira
	0ZducxdgXdivRCqZmCBJMuZjSRuVXR3dcOZxfshjMB3CHMSHE6ItZMEFp0h5eXXJ4ZE7vxwh1xS
	f+7CnG2pHnty90RwImvwd1PP9QEXTEsXfCzAl4jYLPAd+eokN+jodCl9WixI2AYcMcgPINFWvzf
	FCL7N/I0UxWwnaJ1Gppt6W9LTid9QFOyuzw+/g82T1fiIfUXchdWFHPoDzzY9CMu99udN/x+6qI
	Bd6XRYOCg4gnx0dt3D0i5qPOgU83CVupDJ5Y7EoMQn+sL0dWK0+e5RbWiQp/7BxKSmDqmmAu2FX
	kGIJXpBSNbEb5+gGq7ed4V+Mx/mrpPLdKgnk+Dao3g0rqvPXQ+yc8IZTuH8gaAkOcpekNgnFs=
X-Google-Smtp-Source: AGHT+IEauFP+H4BtsTHNnwX2RMa6g7oaZopNNZdiBz+4pgcKwzPpZyX4Q4A5C/MiMwcUg284xoHAQA==
X-Received: by 2002:a05:600c:468e:b0:475:dd59:d8d8 with SMTP id 5b1f17b1804b1-47730793c2amr7516675e9.8.1761847096132;
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 04/13] serial: rsci: Drop unused macro DCR
Date: Thu, 30 Oct 2025 17:57:52 +0000
Message-ID: <20251030175811.607137-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop unused macro DCR and its bit definition.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 504361ed5ecc..470b5701cd67 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS("SH_SCI");
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0

