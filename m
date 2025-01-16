Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441022D4D5
	for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051789; cv=none; b=c8DzsdpLg4DmzQaqwoYb+rVGXv5DuLxr83+75GZsKVMXI3WeCVz4Pn4vThSCZefsdmtrh1jvBD7M1AMbUE+AK5tX2Arbf8y7qD179OKvIfw9suXeM7ZO0N/9lfJQiLKqV6/lSwtrMqNNk1pjYHZD+DWix7vPsx3zbLh1L6X3dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051789; c=relaxed/simple;
	bh=HlBz3gfd8OIUkMQUN/g2FCl5sNFUwPtUBGa8hY7PvGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCAPKZL1qTiRJ+Tw458WVz7m3X5bFWpPAFuP/Luqh0WrhH6OOYsOFlSUzqPX6t00LMGKu+rUgoUNq8ySuD+gz/XK2fS//CCtycXR9uIYkeHwGkTQ1tJHUuNuS8E5kK191E5roxCR7YC70GO4DHETjbJQ0z5JpyZKu0az4BYnn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AwsU5Vk6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AwsU5Vk6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361815b96cso8197065e9.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737051786; x=1737656586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F2SV8L8hT5i2mZ7qR6sl3DjzHF148Q2UE5FnnQt0fU=;
        b=AwsU5Vk6ZcMYDRyx0o3j13MdtxG8nzDn3SRMAYezKgNB8Ndmf+YWlJb3MNW3Ws0edb
         FZTPW9rXXTGZCylDWiNOOHW0daxLTHjSWlDcOJDWHXLpyFrVoSVcwgTgjV708+SrIBKh
         JB3DxTDukhdI5tgLrEXwV3JXdNas7+xOyuce3IInAxyTrX2KLexxH03f6NA8s+oNY/V7
         1EY5ym4Yy5BLlI9YobLmfXOK8P3RYTrpK9KNoF8loKETUj+m1KRjGqYjNVc2MVRvWbFv
         QlPEAVY4LEiSXee/ch6si62+MomUKdRajAWSDzdt+ne0qFAxpZFZfc0xmpvaS1t1h0At
         wfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051786; x=1737656586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F2SV8L8hT5i2mZ7qR6sl3DjzHF148Q2UE5FnnQt0fU=;
        b=DcP6qEwERMf/6vpBhxYf79DJZIyD3Sq5j9xeKTTNuMmZlrixkozNnyFfEM8kFtpuBz
         MIct+QfE3FnD35GGdNPhKmE+WAk2uX7a3vmyCietrsO/VGSZHUQ1qTZRDs4DZg0XjzhV
         0IeTgdLiXgbPUaPoF/9kjNiZlo2Eh3ZuN7YcuOE7ZiobZFr3y9kRXWkY+8blD1FrfAob
         7CYQmKLJFSbc4TetUIdKSYHiT6CQQZ7t8+7whPf+7tXv7QImwoxaC+kGlq2MtxbRGjfd
         iifAGMyO2vnyUKCbJLVBJpPtMVuHnBbqxvw4sa9Pgod87olNK93UXnfPfLvTrZ7R7FCR
         TkQg==
X-Forwarded-Encrypted: i=1; AJvYcCVENasFMlTCGLQYZIpidindBBCzmfydzCgefJwYyo/la2k6LcN6oX/acTCR1/YNS+a+pdYELQX5SvWIUFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMB2gX8+xLh14oOT7MD8A2FGDo6KN7zUodDBmcSl2jzs2Kvsqf
	gaOq2msDWdVl0pyRxwQuY+Wy57q8KhWRFZ+GMOQux9CbhAMKVUoveIUsKgjS7yQ=
X-Gm-Gg: ASbGncvPXCZFNNlh7QkPjEjRNoRCHAKFCQiZffoaW/RiMGMJl8ZAE1xfVj/KcIwkwVV
	MHqsRhZRE+sPPgi1S5Ysn9k8dK8yV0VrvJbvXJJhBzblYR5P7F1rYyur3Ja5c7J0h+VOAvMsmlY
	zm24RjKwVigHen7kTPLbbkBDSX29t8z4mEAoX5rCj1GFaQGmLdcTqTR4zTYTfEOVkFiq+AXheb1
	f32BXg5Pv2EqJObEgUR+OzgjFH0Phkm7CmPVgHx7Bmn+GTd+RNVsuEn2jkhNrlwPuDOJFQ4Lfzw
	GYH4Tm+ZszQ=
X-Google-Smtp-Source: AGHT+IF1lBnApPaY87jL/VxiBnx84a/2Bv8/0Zi1V9RrOKuTmAxotcGlNP4QNTccsMRyPKvgBF/Ftw==
X-Received: by 2002:a05:600c:4586:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-436e26f041bmr286561865e9.23.1737051785759;
        Thu, 16 Jan 2025 10:23:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm495942f8f.48.2025.01.16.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:23:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use
Date: Thu, 16 Jan 2025 20:22:47 +0200
Message-ID: <20250116182249.3828577-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In the sh-sci driver, sci_ports[0] is used by earlycon. If the earlycon is
still active when sci_probe() is called and the new serial port is supposed
to map to sci_ports[0], return -EBUSY to prevent breaking the earlycon.

This situation should occurs in debug scenarios, and users should be
aware of the potential conflict.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Chances since RFT:
- converted the earlycon member of struct sci_port to a local variable
- added sp == &sci_ports[0] check in sci_probe() to be sure the code
  is checking against the sci_port used as earlycon
- changed res->start != sp->port.mapbase condition to
  sp->port.mapbase != res->start to use the same pattern as used in
  patch 4/5

 drivers/tty/serial/sh-sci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 51382e354a2d..b85a9d425f7e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -165,6 +165,7 @@ struct sci_port {
 static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
+static bool sci_uart_earlycon;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3438,6 +3439,7 @@ static int sci_probe_single(struct platform_device *dev,
 static int sci_probe(struct platform_device *dev)
 {
 	struct plat_sci_port *p;
+	struct resource *res;
 	struct sci_port *sp;
 	unsigned int dev_id;
 	int ret;
@@ -3467,6 +3469,26 @@ static int sci_probe(struct platform_device *dev)
 	}
 
 	sp = &sci_ports[dev_id];
+
+	/*
+	 * In case:
+	 * - the probed port alias is zero (as the one used by earlycon), and
+	 * - the earlycon is still active (e.g., "earlycon keep_bootcon" in
+	 *   bootargs)
+	 *
+	 * defer the probe of this serial. This is a debug scenario and the user
+	 * must be aware of it.
+	 *
+	 * Except when the probed port is the same as the earlycon port.
+	 */
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (sci_uart_earlycon && sp == &sci_ports[0] && sp->port.mapbase != res->start)
+		return dev_err_probe(&dev->dev, -EBUSY, "sci_port[0] is used by earlycon!\n");
+
 	platform_set_drvdata(dev, sp);
 
 	ret = sci_probe_single(dev, dev_id, p, sp);
@@ -3563,6 +3585,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_uart_earlycon = true;
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
-- 
2.43.0

