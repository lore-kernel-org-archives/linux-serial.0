Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C6215F46
	for <linux-serial@vger.kernel.org>; Wed,  4 Dec 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327904; cv=none; b=ohct4O0wit9oe4aOV1vAFojQW7LofSd2kBnF7lp9LY40gbxC7sr61YU6rNrTU5+LE9yAVzG/RGbvHQtRshfQd56h7SPdIksMH9oDoRnnsOIgvLTtSXZZnJQmpWrAIUHT3HeiqcGTnbPEyeldJBrhwqxoMcrjYg0kcXu9EiMQgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327904; c=relaxed/simple;
	bh=hNvsm/KT1uK/VLwkIurCBjMDay2qykQ05TtUGaANs+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/lgcNJiQCJOUltrN2DHmhPCuxG4ZhIcwQyhs6PkYizUZ9sc+a8Qz0+hLSzPSKDfsLPXoIY3q6XQQ4uSG8V3hgKRUL4K1NwTzHPcgyKIk4iwgis1vhHWlIcOQk+dRtvqnZSsEnGQ4iYr97qlaE7EgdxYNyzgyg9WqUqVGAP/nds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fiIZOhJ7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fiIZOhJ7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1833367so6813055e9.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2024 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327901; x=1733932701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msXpgYS9tLSNaLykc7vmvtR+isPm7EdibA54ABrXSEE=;
        b=fiIZOhJ7KmDtdtTA+WeVKNQVv1bsOOBhNYD1GChO0mqb6pTVjfOaPRXxiW7Hcg8q8Q
         i+zukxqcqaX0bEMOrTZRfUW1XOzhyjOPZHzzNFVe+DAmsn9LppsHGynV6EvfDQhov4vQ
         r6dzIxFbg2gQR23phrY1Ea0GDOyg5WbbMjbVPNfaXupA3Z6XIVL4arH7rrYQch4A5JP+
         iS7LHfV0Rayz0/ef2VSIEbEc19be9OdF7+auwTz8aFjXS+sI1WNor4YM//Ya7sDwfPWM
         edfxmf15ig6gmXz70C9k1BmEqWAJ2xvWzslRgdRAR7h1ntiBWbum4InWFIk7jkx3+bhy
         TngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327901; x=1733932701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msXpgYS9tLSNaLykc7vmvtR+isPm7EdibA54ABrXSEE=;
        b=Y3FoepnJzfN1EWiMFwXU/aH3RNNxHDzMOfzuVEUX3h4kHSWy6ySuqS//1NURFI33zD
         iHdSBXN+xxw5+KfZXewQjpHTkvpCJLMX+L2u2PZ4MJxSv9uder0CjvJexP520FWXJJ8/
         46kKBsAdyOeFePS0a+J5OKu7tNafy1VM94aEb6cqQUpyxL5zB3e3Sa8h7s0v+Nq4Z/Au
         b4cfC6eDDxAJlYygE/CTGMZy/n36AMEbPjQc/fPBpl7cjXaOf56hySnNGV9S8fWoWghP
         v8EUsG60VdPj8WDXiaXFOzqrv/EgjQOvkAPj1XD1Mi+V4e53FbwH00t1NyPPqP7CSxfy
         ezUw==
X-Forwarded-Encrypted: i=1; AJvYcCWJGLWK5jRGNRWxUPMHSfNyRlccjLPUviq2heuFul5apTOi1t5Z+/cquT2zmIVNjZ4StofZ1zkejly+tq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNvX0caZGMDl8Q+5+hrN/0VnV+rAphv5/RCLd45vzNy47GCPm
	9fzsFIsMDgXP6xBL0a/q9RGVBCeB04Q9P7P5aNDoieIsTUAl3JGTSwX5ufV4F4w=
X-Gm-Gg: ASbGncsfaqTswe/3ZRswwiz0JsfpSFB/svYoXF/S14r+ArtumKD+nVUVvfvS4DEyamB
	nFBMvGt35JsOu+31ufx8JFJKEEjVQueun7smSQvifE/We8yDXgViYGFGQ/L875w2hn3eq4YXPPz
	jI0bzmTPIJPDQNdwt++laX8Dj32rUsRwf/Cdvh93oV4JsbI1RiAgDJsSlIH4JOjuiH1jI5j6TRv
	PpEp0At5P9NqIaBg8YnKlCoi49R437h2soDgeHn5tIVb5OrYR9lAijZ9eA9GjZriqmcvttKzuQO
	Yirm
X-Google-Smtp-Source: AGHT+IFwVNe09WNHkBY2H/LBD9xqPexC52/hSNnEpjHiB9kAbrM0T8XCJhvLvde3Ex8EWBQKVsNWLw==
X-Received: by 2002:a05:600c:1989:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434d0cb158dmr52971695e9.0.1733327900709;
        Wed, 04 Dec 2024 07:58:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	groeck@chromium.org,
	mka@chromium.org,
	ulrich.hecht+renesas@gmail.com,
	ysato@users.sourceforge.jp
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 4/6] serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use
Date: Wed,  4 Dec 2024 17:58:04 +0200
Message-Id: <20241204155806.3781200-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/tty/serial/sh-sci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 373195995d3b..e12fbc71082a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -158,6 +158,7 @@ struct sci_port {
 	bool has_rtscts;
 	bool autorts;
 	bool tx_occurred;
+	bool earlycon;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -3443,6 +3444,7 @@ static int sci_probe_single(struct platform_device *dev,
 static int sci_probe(struct platform_device *dev)
 {
 	struct plat_sci_port *p;
+	struct resource *res;
 	struct sci_port *sp;
 	unsigned int dev_id;
 	int ret;
@@ -3472,6 +3474,26 @@ static int sci_probe(struct platform_device *dev)
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
+	if (sp->earlycon && res->start != sp->port.mapbase)
+		return dev_err_probe(&dev->dev, -EBUSY, "sci_port[0] is used by earlycon!\n");
+
 	platform_set_drvdata(dev, sp);
 
 	ret = sci_probe_single(dev, dev_id, p, sp);
@@ -3568,6 +3590,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_ports[0].earlycon = true;
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
-- 
2.39.2

