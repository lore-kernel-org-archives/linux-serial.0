Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA615ADBC;
	Sat,  7 Sep 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707699; cv=none; b=KmQGgKDGSLD3DnrDaTn4f1AcM36KQtRPXqKVfwuQjpdvisomLT14MH3cDY9vM2dmFTlNUNadboD2PooCvx2eXPCefzBUoNtQtezSpEmenhYN3sRFN2rsPQQl0NzVs3r5QO58HUvdN5/xd6C7bd+8/pXF6z3Wgawy/eSiQtvCjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707699; c=relaxed/simple;
	bh=T/HiXdl6hf6t3nEm9u4hdP2J3V4P7+GSLb5K6ND2DVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QasnCJnw53Z0K06u7+xXcixcPy30UWYvvbWKVOOraKCzwayfmwenXez3G3OsjXPPQEORWdRwaV5seJT+ybqfzXvr+RlIDgHys9aDFZMev53yb3tPBdoCVgOueD/kd1xb1JyUaADEpk21a+a5y9pwWzNXnfgRM5/AUIIF52s3U3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRlDE477; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRlDE477"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-205659dc63aso29309665ad.1;
        Sat, 07 Sep 2024 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725707697; x=1726312497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPqQc9dU94cXkTKGKiNQsR30finHw6JtyQr2G35AmKs=;
        b=GRlDE477eAC/fATLYUldgl7ns+2XfLDkGI/mUyuaSN+Y/cs+pVJc6E+czJloRdJVSD
         DpTOvY2HHuTtfNbYPAF6qqcWelP3He0yEllTQr0MqlHFVrUkZl9vjg9UkBnOVtC0R1et
         zF4N4i9ktS7JbQo/1TDll/2mebVqT/5r0zVEaFW/XHHsNSQIJEa2envpDcSClwZBJ6Dl
         aahWDinPmbRXkGZ4N2CXs1+ErV+8QWBOQS0DMYFhhDhYt3JZLZmKQDp2DLnjjVcKx2O9
         Oihdo98pYm8l8Bz9XEbwcbbyLoZjjn+V/ErzPVTov09h1MOl8C90FoxSlmVI77E8X2O7
         CXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707697; x=1726312497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPqQc9dU94cXkTKGKiNQsR30finHw6JtyQr2G35AmKs=;
        b=xE7abvW5vdxYpOqF3tqz0Sn294EFr/oggBVt+MRzDMa0gWT4u//XvPuHc8I0uS5PFh
         lM+4vJI0Nz/2Qjru26NyuZXOA2zGLt+J9X8V/yqfQo8r7C29DWfKKbQFdEFz4VWnJwYq
         Vez2zdClHUWcQj4vjrKJhYRCdEV2g7LVY8ZKmEQA4e5lZ0dhvCcFH3Cb53QvZ++YzSN9
         e3J4X8lwN9K7rSrBnxBu4YHjfW56ccCnEx9K/CiBSBuxFFEoIbPl9CPyL/O9jaqbQR8r
         CugHH9/aX4msHcOD6hxNzPPnsbiAYyET9vMCcMQeN2YXycQCwiRa+tcLoGtq+ZH7R1Uk
         n3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVlVitMvS1Bb7vQfZM/U4EaOKz33De3CPPQZvOPPa2rG3uZmB11gglJaOnE93hEUZZtOw7sqfWH/Iulx64=@vger.kernel.org, AJvYcCW/KChGHbS1ZAWVHAD6NOjXd8Zx8hU5GUaWe8yyEaUx1bMlzpMne4O7wMkAmCzNiILouDioHLeXb7ICpItTCpoChWg=@vger.kernel.org, AJvYcCXCVt7un6//4SAL5/8gV7NfXe9CoCGfF2MWKREuScE0v9nY+/szTFzJ+TJjK8eK+kW/90E1ZxNxZ2zRuqd+@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnLO2aYUyA5ANdYJ1eRiALeDMAZqoXzXvUZ45BoJ4wzdlQVzK
	luUoj2wM500iMpsPOdToZQlpOy0FGW4pLSCJYXa/ReORXHHH87pF
X-Google-Smtp-Source: AGHT+IFhrmP7pZ9qtVgDWJs0N31YlCBvEBAjFbhWsJV2oKODyyLWeQ0Iz0TmzTN5qMflXxg6vEvsmA==
X-Received: by 2002:a17:903:22c1:b0:1fd:5eab:8c76 with SMTP id d9443c01a7336-206f05e7881mr51873005ad.41.1725707696894;
        Sat, 07 Sep 2024 04:14:56 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710e1addbsm7186955ad.58.2024.09.07.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 04:14:56 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 2/2] tty: serial: samsung: Fix serial rx on Apple A7-A9 SoCs
Date: Sat,  7 Sep 2024 19:06:45 +0800
Message-ID: <20240907111431.2970-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907111431.2970-1-towinchenmi@gmail.com>
References: <20240907111431.2970-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, which is
enabled by bit 11 in UCON.

Access these bits in addition to the original RXTO and RXTO enable bits,
to allow serial rx to function on A7-A9 SoCs. This change does not
appear to affect the A10 SoC and up.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 17 ++++++++++++-----
 include/linux/serial_s3c.h       | 18 +++++++++++-------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 27b8a50bd3e7..f57c5664c098 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -550,6 +550,7 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 		case TYPE_APPLE_S5L:
 			s3c24xx_clear_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
 			s3c24xx_clear_bit(port, APPLE_S5L_UCON_RXTO_ENA, S3C2410_UCON);
+			s3c24xx_clear_bit(port, APPLE_S5L_UCON_RXTO_LEGACY_ENA, S3C2410_UCON);
 			break;
 		default:
 			disable_irq_nosync(ourport->rx_irq);
@@ -963,9 +964,11 @@ static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 	u32 pend = rd_regl(port, S3C2410_UTRSTAT);
 	irqreturn_t ret = IRQ_NONE;
 
-	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
+	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO |
+		APPLE_S5L_UTRSTAT_RXTO_LEGACY)) {
 		wr_regl(port, S3C2410_UTRSTAT,
-			APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO);
+			APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO |
+			APPLE_S5L_UTRSTAT_RXTO_LEGACY);
 		ret = s3c24xx_serial_rx_irq(ourport);
 	}
 	if (pend & APPLE_S5L_UTRSTAT_TXTHRESH) {
@@ -1190,7 +1193,8 @@ static void apple_s5l_serial_shutdown(struct uart_port *port)
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
 		  APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
-		  APPLE_S5L_UCON_RXTO_ENA_MSK);
+		  APPLE_S5L_UCON_RXTO_ENA_MSK |
+		  APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK);
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
@@ -1287,6 +1291,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	/* Enable Rx Interrupt */
 	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
 	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTO_ENA, S3C2410_UCON);
+	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTO_LEGACY_ENA, S3C2410_UCON);
 
 	return ret;
 }
@@ -2143,13 +2148,15 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 
 			ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
 				  APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
-				  APPLE_S5L_UCON_RXTO_ENA_MSK);
+				  APPLE_S5L_UCON_RXTO_ENA_MSK |
+				  APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK);
 
 			if (ourport->tx_enabled)
 				ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
 			if (ourport->rx_enabled)
 				ucon |= APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
-					APPLE_S5L_UCON_RXTO_ENA_MSK;
+					APPLE_S5L_UCON_RXTO_ENA_MSK |
+					APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK;
 
 			wr_regl(port, S3C2410_UCON, ucon);
 
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index 1672cf0810ef..849d502d348d 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -246,24 +246,28 @@
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
-#define APPLE_S5L_UCON_RXTO_ENA		9
-#define APPLE_S5L_UCON_RXTHRESH_ENA	12
-#define APPLE_S5L_UCON_TXTHRESH_ENA	13
-#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
-#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
-#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
+#define APPLE_S5L_UCON_RXTO_ENA			9
+#define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
+#define APPLE_S5L_UCON_RXTHRESH_ENA		12
+#define APPLE_S5L_UCON_TXTHRESH_ENA		13
+#define APPLE_S5L_UCON_RXTO_ENA_MSK		(1 << APPLE_S5L_UCON_RXTO_ENA)
+#define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_LEGACY_ENA)
+#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
+#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
 
 #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
 					 S3C2410_UCON_RXIRQMODE | \
 					 S3C2410_UCON_RXFIFO_TOI)
 #define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK | \
+					 APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK | \
 					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
 					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
 
+#define APPLE_S5L_UTRSTAT_RXTO_LEGACY	(1<<3)
 #define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
 #define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
 #define APPLE_S5L_UTRSTAT_RXTO		(1<<9)
-#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
+#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
 
 #ifndef __ASSEMBLY__
 
-- 
2.46.0

