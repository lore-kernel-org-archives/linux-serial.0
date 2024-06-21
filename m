Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3C7581B;
	Fri, 21 Jun 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984329; cv=none; b=dfUol3TJ6kTij31cvzGEXG6PKjLbDgQ0ZO+hnGSyku3hGlEx3MZJH8wWXauBGaOlHyJf6L3o+OTDzfos3Npfcdzrlg7qFRnFMLyiHXiP1xGz3EV2yZIx1VQp+snx0qMlKpbsF0a3DuZVRxJxbWUwjN+hZpWt3yQl/T56Bi7/Kzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984329; c=relaxed/simple;
	bh=kCl/MMZVsBt2uE6AgyIV3XMIFogLKH0WHMvLYmRV4mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCFZUqNL/g4aK0iI1hhjcr1R01e9T/W5xEdkqAxPY1UctuH9oB/1wEQkC28eJK2oXg0zlH3DCtcSw+eQt7Vb+mWRsbGK3/1x7sb0xUKej/qieXWQk/PMtEUEqBMxkGqP6PM1gAegxERhmxTEGzu3n65M5SweAxeXiNMhXj27OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqHrmq45; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqHrmq45"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421d32fda86so24259155e9.0;
        Fri, 21 Jun 2024 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718984326; x=1719589126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOPm3vCa0hebn5PQU85PCCbT9jGBNVDgsMo+2JVto90=;
        b=lqHrmq45B4vETz/kT0U9oG9X6u4iYu+zhv6rxU+we8G48zxFvuegh3dI2WoC0kBn6M
         /raNL2o1xfIr1TegSCbug3HFsqaPfS/+ZyF8IZMmsq+tzZFGUIrJHF1dF97YSmACCnVh
         NGDgoYFWXabQIZVW7R8Ha5+YWC9Ivc0v6aAv6zXE/k518aK1RZ6W9Pre5Kn+NxABPlB+
         21aTO+t0OelV5/84eLbo1LRdFH+DV7pmcHOWZYBt4cmY2TZbUQTvKHQ9rXS7aRCipfyb
         ipEAGjf2SNyHHBa16DhavySyYR2AGRBIuUeI6azKCYl9H+AeLpPFbNg2KJR9472hJnng
         qOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984326; x=1719589126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOPm3vCa0hebn5PQU85PCCbT9jGBNVDgsMo+2JVto90=;
        b=VD7tTelYcNSHMOrCQSVG/pd1euCweCUnZXOdEWw3As4+UR3arUg4G9+w3hJ3hfr0ui
         oDM0M/F1w+S32QfTnMVuwsYLVPOzjn17mNbbwln0LyAxBZN/aCqdnX8r//KBL8yPXQCf
         W/21teQJuIw7sbZhgW6WDVA3rT3Q4n5sc2k19xLjeYMOIPvNHBrXZPL8q/Pds9jsPIRg
         IKF9zv3VNq8RFPVOemQ6nuSupi/W27SBynzBGbPikyXm3V+YAy+7YpD9svF9TNNJpEMF
         sqbyYIgSkPfJ4q8ZBBS37U31QJX369Bwt/CONu77mcZgdp3R24GC5fmi5PzLkfc2lhiA
         dkuw==
X-Forwarded-Encrypted: i=1; AJvYcCVMLHOwajc85EOJjXJpHAufAqeX3Zu7ZVTkoleY199+FUJnHPMszbg+NpPiEvCnyhCMWC/ZPKS3cFuVNJm2u0EqL3LwvhhzEvTYK7dz
X-Gm-Message-State: AOJu0Yy76uJ1p8vIF0Dt0Vvohfi5GldkY/EzEgEr+gLhyqDLL6tceUH3
	ooqsjQ5sjvP8lBJUU5yhwdK6vMAu3IQE/spUlELVEXYE2Ic+q8DG
X-Google-Smtp-Source: AGHT+IHuPmxHPN0gA69T7fWEolN/fR1P/BeIEUc2ajvI/YlolQuTbQvkvhMs5isoyekjPRiuDRSXow==
X-Received: by 2002:a05:600c:314a:b0:424:82eb:7270 with SMTP id 5b1f17b1804b1-42482eb739dmr22422585e9.32.1718984325542;
        Fri, 21 Jun 2024 08:38:45 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:b162:502a:9bd1:4c8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d21226asm69793115e9.47.2024.06.21.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:38:45 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	l.sanfilippo@kunbus.com,
	cniedermaier@dh-electronics.com,
	john.ogness@linutronix.de,
	esben@geanix.com,
	rickaran@axis.com,
	tglx@linutronix.de,
	stefan@agner.ch,
	francesco.dolcini@toradex.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] serial: imx: set receiver level before starting uart
Date: Fri, 21 Jun 2024 17:37:49 +0200
Message-ID: <20240621153829.183780-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Set the receiver level to something > 0 before calling imx_uart_start_rx
in rs485_config. This is necessary to avoid an interrupt storm that
might prevent the system from booting. This was seen on an i.MX7 device
when the rs485-rts-active-low property was active in the device tree.

Fixes: 6d215f83e5fc ("serial: imx: warn user when using unsupported configuration")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2eb22594960f3..f4f40c9373c2f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1952,8 +1952,10 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 
 	/* Make sure Rx is enabled in case Tx is active with Rx disabled */
 	if (!(rs485conf->flags & SER_RS485_ENABLED) ||
-	    rs485conf->flags & SER_RS485_RX_DURING_TX)
+	    rs485conf->flags & SER_RS485_RX_DURING_TX) {
+		imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 		imx_uart_start_rx(port);
+	}
 
 	return 0;
 }
-- 
2.43.0

