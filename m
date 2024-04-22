Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AD146012
	for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2024 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784289; cv=none; b=jAxVKkNGqc7MYh5EORNT2FyuufQVcyZmU0ni/LxhLJQUbfMS9DTfbnh5qJdq2/YyXZg4L5NkUBberGhTyt0Ova2HEocZl93QgEZbjBCV1jojDUKW9A7vuP4I1kP9zLH3ZXutpSK2gTq4n42fJjirFbmPvCoG0/U/xrtrKpLkRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784289; c=relaxed/simple;
	bh=zOXyQXhCiCAbqSzm1DmnoLf7s16Jjeeh3sXMykWQ4yA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BU8vbWuTg8mbCv6JeHbHhxGPqoUWnBDSW5DF+zVwsFbw6Izusc3BcW+4SWJqAlYdO1UHoc3YRwc9/uPD/mW9vaw+O4w1IN3Jqo85NoMVwzWaUCjzNCjHSzmd9PI4IHyV8HsSgfyic7oKQyctsXpsRndAW5l6uD1C+0ikzF2Ytqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=S8+ExHGE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="S8+ExHGE"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso9941715e9.3
        for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2024 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713784286; x=1714389086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61hzISvK/wLrrN6ibfTaJ/oIzNgbxFUNfnYIb6kt4q8=;
        b=S8+ExHGE7UZRml9wIgN7GdoCDFGbOMuYgW30fQxMX7T9XTBMF4mHX+QD01Z3ohorUe
         24/J+cQ0ikD27f716BNNq8vRm6UjEMo7eExWWjop0KXE2ITXdGfjI2LhRN3D9u3fhEO1
         biaFZA5xMkPwHgHKnMIgAhNAawvs56RxUmgkU1odYbdMjp7WRWecgP982PFC4nZI857R
         oqtGEDj2/0GCs5AF7Tgk0dFLsAsP/tx6E6WlSVC7jigB0ObK9IM3sDCRFbW98zyZqbVs
         g24C+u0rPRexxxqyNjLqAEbzNQtxyagSm0P3v1zv319lrhtHL0NRhT0jVqomQqjTkSfv
         kcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713784286; x=1714389086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61hzISvK/wLrrN6ibfTaJ/oIzNgbxFUNfnYIb6kt4q8=;
        b=OtWqok3nPZnE4K49i8E2Zm+4PGsBURoS8m1GOAhqhM7KYuauQb0m1hXEHnou/0Dghz
         wP1XaV9Ro+ToSP+Z59mm0h9I4F64+vjKmi8h1DkHvS7OGadDYGYxGMETImmfbr/0UHQ/
         2Ix8QOyt05DRc1vcDv3hoYQTJn960i4xr2FifGxM8DetNTRKsn2YTa1Bqy0OymC3N7yK
         fxJIgCXUIyPyu4b1cgUvUusqqUntq6TViXnwHG3Eb++YyxzoeIilLZ33/6RMbCM9yyHt
         HLCDmY+WFFtDAp7IlcEaeI4f3sdtpZXJHhPPz2eS22AzlY9hltDVd5LVrHwR4es60svn
         xOow==
X-Forwarded-Encrypted: i=1; AJvYcCVrL7fmbqdnLvHli7Rn/5lKF8GXCquIWAGNbPj1IYjTLXy7Kai1Krwq9AlyEPa0UiBVoyVVhyKNf9K7cmboCqMNHBYfd7N1oYp9Hapo
X-Gm-Message-State: AOJu0Ywsh5cIMXYBy5pLhLvIRfGAyfpWCc7/pTOX+NsjeozzxqvDb4lI
	TmBLZVZGfSVYpJ1Nu4yL28+B8lGqxZHrLfBWKe/k6CLEcBQL3eHttGd2GFcWLz0=
X-Google-Smtp-Source: AGHT+IGMfRYSdMcLHCdhxlRSB93POiy1y+u9GQT5dTES5qnzs1ds9F6kAbynLwEbX6sbZ/W6e01cVQ==
X-Received: by 2002:a05:600c:46c8:b0:414:d95:cc47 with SMTP id q8-20020a05600c46c800b004140d95cc47mr9334640wmo.30.1713784285915;
        Mon, 22 Apr 2024 04:11:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00418d434ae4esm16292565wmq.10.2024.04.22.04.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 04:11:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev
Subject: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial console
Date: Mon, 22 Apr 2024 14:11:23 +0300
Message-Id: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In case the SCI is used as a UART console, no_console_suspend is
available in bootargs and SCI is part of a software-controlled power
domain we need to call device_set_wakeup_path(). This lets the power
domain core code knows that this domain should not be powered off
durring system suspend. Otherwise, the SCI power domain is turned off,
nothing is printed while suspending and the suspend/resume process is
blocked. This was detected on the RZ/G3S SoC while adding support
for power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 97031db26ae4..57a7f18e16e4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3441,8 +3441,12 @@ static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (uart_console(&sport->port) && !console_suspend_enabled)
+			device_set_wakeup_path(dev);
+
 		uart_suspend_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
-- 
2.39.2

