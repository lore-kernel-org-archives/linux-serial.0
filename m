Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24443190685
	for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051788; cv=none; b=G7AQEDAxLcxJ/WHW7tJGll0NuWOOzoCkaPWUaC6KqrWY2HJ3OikCrh52W1hyuFa6KlFdA+7mG0bWvnBg8SQGhuPBFfSyy/Y+KOkshyiSQsa8WhF9ylo/h2M/VgTLkINUhqGMOJ5yNdfQPqxokJkC5T0R1HT1C8OScq1xIrPDfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051788; c=relaxed/simple;
	bh=DcF7B55zcAap/muhL1RWLS7OTEtRY63GaX/Ehm6o9BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/aKZJI1UYs9VeOICd/i8Ovk+cahQngLuzaxNXpthkLLtn0iSCp1PhcHFs2DRCdbdjX2GWxiYRuWvQTnYx4UIHGzpDRGfKPWbUQtLmSsRwPCvz6m+g6pxvroY0qxeSf+lcA3pbNv+w6I0X+PwyyCKcdQXNhtVnc9UwdEBe+dZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=exEIgaJ3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="exEIgaJ3"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863c36a731so1078575f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 10:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737051784; x=1737656584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt3X3hJfAKuM+3Yz7HnXtTVzceebTppvDtGkvFMMHoM=;
        b=exEIgaJ38cv8OjUEyp91/WBHYbQID2WnURX1BKvpKTKyUISH+jUqZuhGDGLoOaCi07
         FBTrA6myTT69YuMYUDLKdvJkUpPKn8dRQ91VbbFCZoetOIbb2Ll3NWPQTUNIft6zbagN
         NBnpu2pxQzgb1SQfzZQDKSIa8oCIczZF+ICS84C1/7gB+izOit2tAYiBolcGdVVLcPHr
         UewVldw3W1eAyUDUAgV2x1to2CMqkSecin/mqOJNJu8ROQQwKOqFBnb4N7jf33Ueio+j
         thT5cOXhvayJMle6DJ4p9kH1wMTeIethJa3QWnj4ZN0LNuJg7SlH3tuRzGuw6xFV8yYg
         vZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051784; x=1737656584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xt3X3hJfAKuM+3Yz7HnXtTVzceebTppvDtGkvFMMHoM=;
        b=mrTRekApL7REsNdMTl6h5WrPVyKBeHj7ER5EnkpCjYt7HRgas3Ly8kXgub3Mgg1dez
         dikTr06FLplX4jGyJEsszClY5EkH1ZQfX/hKNt3FuX6JgPPLy6e7sc4NqUPplPnyl7/Q
         ROmPQ+mnAAKZSFl7AgSI8m0xKdGYo8kg9tQ3M/gU+QhhDVEmVl3ysJ61Xt6YoysFOEtC
         CgqOmZYFev+q1qSVMJ7VXn2PMod2x7TluMHCKCTyZO2KyggFS7OLYI2awO3c/NYABw0W
         DmGySwvHz5uzti6HQIfUhEumGmmFvbjReRn3oZQ0FkMkHWqNBwcKuCDdzx5Mcg1GpKnY
         KFnw==
X-Forwarded-Encrypted: i=1; AJvYcCVBXQUhoAiNQn6FKSH/Cpz95atib6UV78hl+7dRikNtI8hPSoI6FdZImDHjz7/QGnuZSWBOXs14ORClMBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2q/Lh4wkm8HDoQh2iBgBAOj0JDFoOLV3HT49glvJkzBtdck3
	vRJRvLyW25I+9qCwqSssfRjskh17IyegJAVwVPvhNiuMdYZrG1GAdm9gqJl6lUE=
X-Gm-Gg: ASbGncuBKD/qzNxWGiW0n03Mh7QvqTT9fgQZwTiH9LDwyd5E/7NysDdbI66b17DZuBO
	K5hSg6/UD0iYQOwPoRQFjizdhhXQ7Lc70kRO8JEuEBc2Kp2OxgIrAARsJbdHcPFInTwn7w2PRLi
	5hyhjI3YIX8jXndPcEvPUHScXc9BMEqPlk2xwdfr5aWjY2E740gA52sf2p/FRFKgt1oCtaYyYmi
	kRBoig7drxZzHcL4l+kwUPnKKhM2rQa5gLL+RV0Ygu946gF/ibHRTTSDUH4Dgdiv2AOfIvvyoyY
	bmcJ3hFckgI=
X-Google-Smtp-Source: AGHT+IELCx1Crvm+gMJWnRj/5W/vXDbON9DFubikSRu/WF4Y4wWdLHxE8IaPDSh+SujAoNScHaHbSw==
X-Received: by 2002:a5d:6485:0:b0:38b:eb7b:316 with SMTP id ffacd0b85a97d-38beb7b043fmr4040641f8f.47.1737051784352;
        Thu, 16 Jan 2025 10:23:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm495942f8f.48.2025.01.16.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:23:03 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/5] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Thu, 16 Jan 2025 20:22:46 +0200
Message-ID: <20250116182249.3828577-3-claudiu.beznea.uj@bp.renesas.com>
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

Relocate the runtime PM enable operation to sci_probe_single(). This change
prepares the codebase for upcoming fixes.

While at it, replace the existing logic with a direct call to
devm_pm_runtime_enable() and remove sci_cleanup_single(). The
devm_pm_runtime_enable() function automatically handles disabling runtime
PM during driver removal.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since RFT:
- collected tags
- in sci_probe_single() return directly the ret code of
  uart_add_one_port()

 drivers/tty/serial/sh-sci.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 09e69cb7d798..51382e354a2d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3056,10 +3056,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3086,11 +3082,6 @@ static int sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3260,8 +3251,6 @@ static void sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3425,6 +3414,11 @@ static int sci_probe_single(struct platform_device *dev,
 	if (ret)
 		return ret;
 
+	sciport->port.dev = &dev->dev;
+	ret = devm_pm_runtime_enable(&dev->dev);
+	if (ret)
+		return ret;
+
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
 	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
@@ -3438,13 +3432,7 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
-	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-	if (ret) {
-		sci_cleanup_single(sciport);
-		return ret;
-	}
-
-	return 0;
+	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
 static int sci_probe(struct platform_device *dev)
-- 
2.43.0

