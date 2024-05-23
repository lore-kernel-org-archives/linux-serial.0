Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1913D2B2
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451118; cv=none; b=Hy8X4ovUYKuJgUOpS5DaAUt6EDgwgPl0qimQMt7GsXUCoYrj9FUA7Sa84xBisdxvlyB3PW+BhGAMK9mPVVpRYs7/6z01POBmiVJMDlHlNqYvj5ZCgGIgCUbfAHk6MFAty2Xg6kc3YJZPqRj2tAIDbWcdM6WGfFcMAv8wteeJZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451118; c=relaxed/simple;
	bh=oY9pJCCB+gMDQTAUOCI57KbOI5M/HreuFbqNaMW9YWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBNPk6EEpQtgAWfQ/cxJPkw7v34gWa9gWjg7HwCilTrGh/gMAhnrjTCfLgNna8Fa3RFcWDCm2lDrQ/wTFtrjq8TC0t6q5+R0f9JHtssuqsanK7dTsZmSM5lP5x7/j/68DgyHeSH470+I+RNt68GcmkVgkvyuetz2Ev3PsQIUPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TK/gv9Ba; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TK/gv9Ba"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso16744175e9.0
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451114; x=1717055914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8GG0qSUKW/QwiEfb1pXJnlM6Z5iknMteP/DubTFmCA=;
        b=TK/gv9Ba/1znMN70+vHAhjN6RiQjNI7tSNplK/LWY6Q8hlaJoVjf2pzbRI8YW9NTgB
         YbQGTguSFarzIZoVVCiGHAJtm1F4bHxtBqgYK6xjx1THBrMCzLDxhReKLU0uQQJjQoRR
         urz0zaeqdkhvOLi+w5TZ/P67U+DqEIadDPw2z70YWmAJvHg6s7xQyuuhuxgZv9N1rZoz
         Ms4C5vjpWQesLQJq8k0TMNU/29ziYuXW/4F5fmkV3fLmY3bekLVb5TYKC3MZoP4eotE6
         2wlVkqOxXT+tpsVbd0IHrNflWqbd1t3NXAxnLGrUIuwu6uvn1y9vR29ssYzAGINDcGte
         +9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451114; x=1717055914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8GG0qSUKW/QwiEfb1pXJnlM6Z5iknMteP/DubTFmCA=;
        b=brArdRM27y0kKj2cfoz1vHj42680SIBo3HU1jVc49DsRPnBZo3e5CgHrIRX+vSv8om
         +j/1u2u6z7XGJ+5ICdCAWtvVL5iMEaDI11u70wC/HKAYAvbvnwHYEsP5s+gK6q1oNK6K
         2dxcYS0XnzDVFZ+TrsJnSPiglmuGyVOWPEdFO25SUARRsJVl6JUYDUmPePr8k4Uyth8l
         piHV/1xIBENEuTawr+qTHLhm0ns60WNdR4+V4SlJ9/tUdjNlr+Xbda2THTSPYuZRN2CN
         MrhlX9uxBY2wyzv+J53HhyNkkXmTCbhnZ4XugAGY67IdyWTlLJIIkhMM+zUyowyU0NOh
         +rWw==
X-Forwarded-Encrypted: i=1; AJvYcCVv0gKjv/GggsYHNlV13M/sD0uyVn3AO3RI9c8MckIY1JJbU9c5dy5TbvX3XTgJ6ubbi4q9Xsse5uygG1sQtpdIX+QZpHMaQ8DWrxg8
X-Gm-Message-State: AOJu0YzXD4PbMOIQsTaR0sAsImExrH78rjM1bAGJmacLYEvgxWuMsNeC
	nEZ/Ft0gI6Kw61HSCyUUexiW1BIjal67zFo+Mux2hp7YalYMk7SSXn8y6ngBwWU=
X-Google-Smtp-Source: AGHT+IHY1QA7e7M81Uch6zrTpW4SzcO290mENs1Q7433I/NCsVyGWKJ/Rr+g3fYyAhO+lvsDLKDNDA==
X-Received: by 2002:a05:600c:56c1:b0:41f:e56c:ef81 with SMTP id 5b1f17b1804b1-420fd2dcc03mr34490425e9.1.1716451113999;
        Thu, 23 May 2024 00:58:33 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:33 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 5/5] serial: 8250: omap: Set wakeup pinctrl on suspend
Date: Thu, 23 May 2024 09:58:19 +0200
Message-ID: <20240523075819.1285554-6-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075819.1285554-1-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable the serial driver and it's pin to be a wakeup source in
suspend to ram states, select the wakeup pinctrl state on suspend and
restore the default pinctrl state on resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 617a421a1396..61f056c4e78e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1663,6 +1663,13 @@ static int omap8250_suspend(struct device *dev)
 	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err = 0;
 
+	err = omap8250_select_wakeup_pinctrl(dev, priv);
+	if (err) {
+		dev_err(dev, "Failed to select wakeup pinctrl, aborting suspend %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
 	serial8250_suspend_port(priv->line);
 
 	err = pm_runtime_resume_and_get(dev);
@@ -1696,6 +1703,13 @@ static int omap8250_resume(struct device *dev)
 	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err;
 
+	err = pinctrl_select_default_state(dev);
+	if (err) {
+		dev_err(dev, "Failed to select default pinctrl state on resume: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
 	if (uart_console(&up->port) && console_suspend_enabled) {
 		if (console_suspend_enabled) {
 			err = pm_runtime_force_resume(dev);
-- 
2.43.0

