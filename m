Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A014BF90;
	Sun,  8 Sep 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786604; cv=none; b=VB/YlqbQ4BCcZup104LcZzuJjMjC3TPjZEy3jvXmIgT8BOjkF4qDPPNfXNFr/8pVDp9y0RKpB3cEhiJsjDFqmqwbbMECCe9bduWWifPPranaASNWMGu8J44OT5YsLebiAVF6qcFVd9Mcd9BXxq5iCVReJ8JgbfNmi+jPPCCzugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786604; c=relaxed/simple;
	bh=epk2xrtaofY4Pms3sf5q4kdXa2ntKR40Qb1RWwvJjgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hb8dk5dWLwo9MpLQeh8xBuRfrGtsI1A++mwXHn49Zg/DelyuKg3hXLBycgUdF1N/kMd/YbEvXSGGFvqyN6LKP5qvwsG9RPF44xPD4QqLGYTPTbU/c6wPA5VNotAzekgpUDgUhn92laB9S7iCSPnfAwHAMZVO0Al4NVQTg5mGXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TprHbn8u; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TprHbn8u"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d6ad6050so1594761b3a.0;
        Sun, 08 Sep 2024 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725786602; x=1726391402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMS8c5/u0QQ/ldqnzOaZXPb8Wd+9JvT8PF4nOfpjFOU=;
        b=TprHbn8ugExrlqDaTBasswSfKmq9RkAPX2KQvVLfPqXRoA7TMS1Rx3IzIyblrkHsnc
         TNoLzE2mkhNTRHWDI4GfjaLhVqrYsFWOM2+NjvslGTuojA9wATjfezxkPBBhKFH4KJyh
         kHXyf/fzJ7+bTPHYDRPZRZHHBdwKbgeH2pOUwiSlT5PDXOu8xQME87x35RGcatqfohUK
         XKFVFc4gsDaZ6agB2ylx0g4CMr4en2e5FYa5kMAwnSAp+QcNEtW2/lpuo5esKi3KsDJI
         mIA4zdFfepNLgpCwt5CDYY7GInLsJldVRmUts+hMf8cxvhc6cjwcDcAiwA9jJGSPn3GY
         8qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725786602; x=1726391402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMS8c5/u0QQ/ldqnzOaZXPb8Wd+9JvT8PF4nOfpjFOU=;
        b=UCTC3uRzLGXsj192jCKfUOANMoIqilp6pXLj5K9OdDkfmYdmvl0UYHyIcPBGPG8PvL
         2MDQYU2GPrAoFeJkH1RPMXglZP1TgYEYZwIA3abExPkSj192MydvbdAEihQoizHph4dy
         W8wwopb39AeCcO/kdBTSecY3G+c4e7zsHf7mDsKIPH44Z1oRjbCOwf/m/EgwrO5Sept2
         ZHlmuQsG7KgVWD8h14GxjDSLiIsk9cffK9pjVeYe50OpMoCgUUxT4MbAwm9xhAd8wWPB
         DaMttZMfnmz+h8lBboawsWq/YBW8xiRc6tvXfY8Bh7vIhWB8QAq6W25Bc0gNUiCRJRyt
         okSg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ng2dy2+n7sE+xoTNchnSg9iqn5ZbUm0x4l1cUxly1YMf0Kbj87u7xjei6HxFkPqrnXhBfiXDJdjZHIPXklEpXUc=@vger.kernel.org, AJvYcCVYk40cGcdYkzGbs2VdH/JpuXhzgPuKx+NbNBe+Juqu4IqkfyWw/7RUEQ2FOCunW18NpGqxnMx79NWTcF0=@vger.kernel.org, AJvYcCXRXU+/rqm70vczl+yfDM1F/inP3nt0SdZB1izHP2R5jJPhFiCgH3MdYTiza6vcllqzCMy1IVNtKzfWqZbD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zvKMecI8JwlSTW64LJvyHGhCE36yHtcnMnw4FZBGUfcJkZMM
	8cL+4E+CpFH5w6Wmmn8ubHOVhHESYchlm6LQIgIg3R8mkvffWjU7
X-Google-Smtp-Source: AGHT+IFNncUr20DzqhMG3l7Ouz7oZSjCzi/Oh/wY/beA6m53P8SYV12bHS7Ulb4Q9cGqXx0n13I2Tw==
X-Received: by 2002:a05:6a21:1693:b0:1cf:241d:6024 with SMTP id adf61e73a8af0-1cf241d640amr7325480637.18.1725786601729;
        Sun, 08 Sep 2024 02:10:01 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5896e10sm1821439b3a.31.2024.09.08.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 02:10:01 -0700 (PDT)
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
Subject: [PATCH v3 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Date: Sun,  8 Sep 2024 17:05:12 +0800
Message-ID: <20240908090939.2745-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908090939.2745-1-towinchenmi@gmail.com>
References: <20240908090939.2745-1-towinchenmi@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 19 +++++++++++++------
 include/linux/serial_s3c.h       | 18 +++++++++++-------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7574d4176e76..0d184ee2f9ce 100644
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
 
@@ -2822,7 +2829,7 @@ OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 						const char *opt)
 {
-	/* Apple A7-A11 require MMIO32 register accesses. */
+	/* Apple A7-A11 requires MMIO32 register accesses. */
 	device->port.iotype = UPIO_MEM32;
 
 	/* Close enough to S3C2410 for earlycon... */
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index 1e8686695487..964a4fbf2626 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -246,24 +246,28 @@
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
-#define APPLE_S5L_UCON_RXTO_ENA		9
-#define APPLE_S5L_UCON_RXTHRESH_ENA	12
-#define APPLE_S5L_UCON_TXTHRESH_ENA	13
-#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
-#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
-#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
+#define APPLE_S5L_UCON_RXTO_ENA			9
+#define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
+#define APPLE_S5L_UCON_RXTHRESH_ENA		12
+#define APPLE_S5L_UCON_TXTHRESH_ENA		13
+#define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_ENA)
+#define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_LEGACY_ENA)
+#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
+#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
 
 #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
 					 S3C2410_UCON_RXIRQMODE | \
 					 S3C2410_UCON_RXFIFO_TOI)
 #define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK | \
+					 APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK | \
 					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
 					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
 
+#define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
 #define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
 #define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
 #define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
-#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
+#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
 
 #ifndef __ASSEMBLY__
 
-- 
2.46.0

