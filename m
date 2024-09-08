Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1DD84E1C;
	Sun,  8 Sep 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725782395; cv=none; b=PuGSC1Elm+iVZqWBnVAqqmaPUYJOyw2Hg79ZUt1Ea3W4CIfsH5Sp5tKge5S2tgfGCMObKwGKQ+OzQv31FKyikkWFdFm8zRJuzndF0h3VuVIdyU6zCX46hhm1YxeXC06hhowKTvHlo/oP7Z7V+cukfnvbNW2SfUAsDLgo3AfNM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725782395; c=relaxed/simple;
	bh=UPTJKYpZuE+NMhy0BOghVRXFT6JoLBwVcxFYq/KQDsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmONKNKs/am2DMCKYg4RUbInT0DjODJEUgOALZEagqhBXf+kzZmoEd63jXpmJlW7i8+asfBmNW7JQ+ElACt8pgTo/xYRlh+N1lFs0DEsMqB3WDv18nSoCtilJbJgKbZuFMGntGSPeqQUs6F9+G28mGIyciH/IbC286uuyI8TC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxEFmcT6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxEFmcT6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2053f6b8201so31611115ad.2;
        Sun, 08 Sep 2024 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725782393; x=1726387193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp/lE9jsjwYr4QJVO6arIKQKvwQTHVJgAIKKrLEU4/M=;
        b=WxEFmcT6S/CYdZYFwDUAhV5QHeTD/ZPnwz34XS4I7AHlNcIsGN+1AFBBkydU4yyEvW
         6i7Z8+JfQzrMJLInqkRKM0W2Lsp+VYwLUapEDMcH1QZUD+uNZjvHq23QragcEzhmBfy6
         P/Gq9V/ZKXPEk6pfSTd5n5AC9Ufc2hDosPV8qRpp2FQ3nDZ+4ZoBANHE+OtyE62thneG
         0Cq1qslyxN3qFX6aWRyOC1iqK48Y4+zinnxiAHM5mUQAtctmCVNPgF1/rM68XtFBYyHF
         NKBrJYf9x8E6jw7RiQmn1iLXWtRUh3upV0KhCq6oRpZAdTCrPGf3P4JDsf64POvME7jW
         /Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725782393; x=1726387193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp/lE9jsjwYr4QJVO6arIKQKvwQTHVJgAIKKrLEU4/M=;
        b=YL5ZiCjYrhLx5BaxKP5lU1pt5sUks9Nrrw+wF7042yjB2m/1Xc92fGGutkDR3YqRls
         stGJIj+5O+JDCgUn+FDvEyb08FYFhUlJvWPJeRnzpdQmYjxvOHMs7bK6T1RnybvGmII7
         lJohrNGsRou6t9EycaG/56jpRh08TH25Bx8b22rNxL7ML7A5oJLHkw29Q/x9DlNT9x0I
         z/Fl7RACw1Jn0CIXdkamPw1rjlzUxGjKGowuEcReFUvkmalpKWy6Ifx/2M7fgO1GIW54
         W7BnK+3nEoatamSV83m9q+Ao+qM60TAjUaHrdybXa2V2D8f/oovr41Pagu3Lt19RNE35
         k9VA==
X-Forwarded-Encrypted: i=1; AJvYcCUu9jIOKK073ROBF29pgYZKgH1ZfBYch4Bua4THbh+wV1Sik/l1G45gtwGi/lc+lVQqYWBHdTvs+MpYmXU=@vger.kernel.org, AJvYcCWW7uQ70VbKmSmmMfkT0g531wAnF3FdzzCP3GCy2nU5pHJvqkjn9KCksviEwaWgsZu1N0N6IbEbhW+JI3l2iag6Zcg=@vger.kernel.org, AJvYcCXeDMMDGxt8Hpl2HnXyiv/DeB93ncZ4tX7uS7MyO+AwYOsq6vTUx3CImreF+lNGE9d0YXpR0OwxZPJ6Usju@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EyMl4Bu/UOWnT752xvztrTuBU0huOyil+FsrgrN0jKlUHKYb
	OrRlzNal7Q92nh2jtWYHfqdLVJLPmuzM13EqorYq3/7a3VwlJDeL
X-Google-Smtp-Source: AGHT+IGCGgxhBLnfpM1/1m1EpmPE/ZTOPIdCCK6RTEVjqefLCbamq/qcZG3kSjyvJcNn7Jo7ZJWEiA==
X-Received: by 2002:a17:902:e752:b0:206:ba20:dd49 with SMTP id d9443c01a7336-206f0552304mr128552445ad.33.1725782392935;
        Sun, 08 Sep 2024 00:59:52 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7d8255dc1c6sm2012690a12.68.2024.09.08.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 00:59:52 -0700 (PDT)
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
Subject: [PATCH 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Date: Sun,  8 Sep 2024 15:50:50 +0800
Message-ID: <20240908075904.12133-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908075904.12133-1-towinchenmi@gmail.com>
References: <20240908075904.12133-1-towinchenmi@gmail.com>
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
 drivers/tty/serial/samsung_tty.c | 17 ++++++++++++-----
 include/linux/serial_s3c.h       | 18 +++++++++++-------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7574d4176e76..f6f8645b0798 100644
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

