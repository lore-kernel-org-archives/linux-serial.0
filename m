Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7030ACF2
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216214; cv=none; b=W3u1cbN6DTnp+e/ZWtNYQvZKPQ1ev9rQy285evQXTxu11Bt/CnoKZUuV9ug/qduihrmrcKP7X0e0tt5Y4EYf+bQIu8MNr0HcmK6/n81FRzgEDS0p3rv7BslBeKPFHcun9a9mTragojD5MK3o2NgcJCwAz77ULvsVc2M7TXQ/DNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216214; c=relaxed/simple;
	bh=XZ0aa4iCUybd6QVov9sY+LCzyX4cdv1qdWS9ztcgdcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU9DuxrnMQWSszlEU29yURSYUH9Qo3mOYUL8xMXbkwSo6511Pw4mqHfftETJn5G15B+9BCQDaXN1/GZAzwEzqfPn7gHJ9LVkZ/PVVXzSP9V3JhA4RpQD2E1M3cLBB96Y45J+O3IbWk73qQmSmtUp+TjR6Q50tpIXicZOcarVjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijc52sfu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijc52sfu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b593def09e3so401927a12.2
        for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216212; x=1761821012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qYNWh7ObOQ58yx7yZwE/kCO34/ItQPE82ZLhZuHfPE=;
        b=ijc52sfurz9DvcCoSBvjQo4z14YVGiisIKM5ccSsXDT+GWY2d1ltLWtui074IiLOQV
         EebONfUrrXPJSo9genyPRxnxzBgZu5DPOeMyMirh+E0DDHTd8a+NNe3XqwH3FKVRXD2c
         SS9a/JQ5V9pcTrcOSGzNucde3/saMFRTp3UKBe+Amx+YTJZaF1F3ivDZLchNzihj1G6k
         ofVAFZgY3yQCplH19j/DuyEC4UoUGkn7eOf/hAQZoAtNlofGaINR3p76YmIkiVKLIkQB
         Z4tvX3VKs8wuZcdEl9hEBoxwB8rOr75wTdLqdY6VmOr1uFr/uIbvdhjitwyUwL+BHx3N
         v2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216212; x=1761821012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qYNWh7ObOQ58yx7yZwE/kCO34/ItQPE82ZLhZuHfPE=;
        b=HZmn9wsIKSNMZDlM1QimNOYnqEKiyJbCHnRGGH7SnbVkW8rwlZahBaSgpOcZGFvejE
         6aSF2GW0avKrp9m9zbsko3077AOJWKkk/2ly9Ecgx13D1gy5Xxuj4hTKynA8KIpo7E8c
         sMg67PVe/TwlAz8UZ5HSbL8TXOR9kjWRuSPcvPUbpAVwkkxosYsbvxvO3d7zfL9D2YdO
         GhOY15EtXQa+iCY1JkObhVj90+C598CdyeWuIDboC4nymgws5kLVE3uJzizstTxQom1V
         Cynp9cHEX2MX9EFks4SdZJbCYWNzSpJzDwonPSJEXrL4BgjG2zbOMrz3fjkWRJhNx1CU
         PkVg==
X-Forwarded-Encrypted: i=1; AJvYcCWyu63eBNxO5q0tbO/dAuTzY5XROD5Rz/eyuEmw4+Jy7mqfKkng7mHlbSYluoSaG6Md7wNXn+CC5qQkWcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyariG8NctPJ7dzhbhxbFIby+V1f+T2NzshbYDwhTWx2v1DzW7m
	FhKbPHDxaukqKFmAecGIDeXX+z9tv1wYWK7w88qFuy/cnPsUqJtLqU4r
X-Gm-Gg: ASbGncuMlFSdjd4jy21HfWQpL/nj/OHE6PQ84U0zG4MEKajv4lUT4Nh7Wn9ugtg3hpb
	q8XvT5gnV7RvQWM8enAqkCIT59fXIejiOjT1zG6dmCl6Jwa1FZzpmXmkGrMx52bFNuE0hsEaBU+
	8i5TjfS/6kQzsN6iGs5tqaX282qJ+6JQu4PZwlzflFEaQbKdpceLsRHypRun1qQBXG7/6aFzCXo
	Yie6p4Lj41Lzl+PG8MVtlnXzb2x9xPH+o28JNgosYpCmkObfRlYg7UOriRxEL4p4RmR70CdRD9y
	TWKqzw2Fzk+3xJQVNhjl+MgC4rxJBoLiddCbZn3RBuWfhieDICCXctjf+iXikHQdTiIAeeEujdT
	gL8m7CckcXFLOLU4/mUYkWLSOUekKzVMujnouBvsSdP6siYEdZjEbwswHkOkNlc6DS9hvB6P9Rp
	7QMKexKZ4ot+RMqq8x0kE=
X-Google-Smtp-Source: AGHT+IH8b5u4HtoHpKR/2HVfpSINg790zeUEcpfE3gcodr+5+Gk0kA3xe0PaMdH6w5uN7f9EIubR3g==
X-Received: by 2002:a17:902:c942:b0:264:a34c:c6d with SMTP id d9443c01a7336-290ca121a65mr282957195ad.37.1761216211772;
        Thu, 23 Oct 2025 03:43:31 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm19240945ad.34.2025.10.23.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:43:31 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] serial: sh-sci: Sort include files alphabetically
Date: Thu, 23 Oct 2025 11:43:12 +0100
Message-ID: <20251023104313.210989-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023104313.210989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251023104313.210989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sort the include lines alphabetically, no impact on code behavior.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- New patch
---
 drivers/tty/serial/sh-sci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 62bb62b82cbe..125a56d47924 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -19,11 +19,11 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/ctype.h>
 #include <linux/cpufreq.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
-#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -32,8 +32,8 @@
 #include <linux/ktime.h>
 #include <linux/major.h>
 #include <linux/minmax.h>
-#include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -50,14 +50,14 @@
 #include <linux/tty_flip.h>
 
 #ifdef CONFIG_SUPERH
-#include <asm/sh_bios.h>
 #include <asm/platform_early.h>
+#include <asm/sh_bios.h>
 #endif
 
 #include "rsci.h"
 #include "serial_mctrl_gpio.h"
-#include "sh-sci.h"
 #include "sh-sci-common.h"
+#include "sh-sci.h"
 
 #define SCIx_IRQ_IS_MUXED(port)			\
 	((port)->irqs[SCIx_ERI_IRQ] ==	\
-- 
2.43.0

