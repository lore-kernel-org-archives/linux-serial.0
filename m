Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B21B1D60;
	Mon,  9 Sep 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871386; cv=none; b=uBDRnWABTjwyH3goVylJ8JHXQ9nyHXxK/HiLhzrQFWpPUnLTwWJ7MIxmVExMc9LeWn+nURs5jdOrQHmhsas52JCbdvEbftvN42SHQAiDy5rpLNd7w4bUEO+HYIURRAIv+JDFRJ+zXmNek+veaP9gSKJkwSBIzPv5/v5LFO0HHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871386; c=relaxed/simple;
	bh=2rgcqQaxV+vaTYNa/iYGEHbrgXFhVyx5kvPK4hjbDKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSND+ga4xuNwloC9ucsGH5VQrnlT8sRg+IGzEGjjW3oAe0hZJ8dsll/HuOsIX3yzCbmNl1LQoB3+k4L5sYtWDqKsCJ6UThHF8XTLxJcYD4n1XZCkYQ5InH1agRqXKmlymoHBifAATzBgA0IRBFtwXm6l2rf+X04T+QijI/vXr8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrSOKfF1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrSOKfF1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20551e2f1f8so39290385ad.2;
        Mon, 09 Sep 2024 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725871384; x=1726476184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9iZfGPEL6q9g6QlnTdnypN7TCKR5oC3QJw/pc0I/ZU=;
        b=ZrSOKfF1AYuVxBJMoOt9qJdA0IrmZyREggr8EFPqOlywA9KBXCe6MjGK7Ju0/Y4We+
         axYMXug/Y3lnfirjRw61YRSef9prNe9Wjiaf6QsyYUJ/5H359/WGBe2lG4QDCyrC9T6x
         yxIjCAYsNzO5Vrp9smGHnpKN14QnLjOW57o4RYz44UVP+iRYfF9L0NRGyDoyUfha3hRM
         8d+0Is5xEygHxpbo/EhkB1KjKdf6qT2K+HErCeSB0AOuvgPbZGxm7otGTu0+p9Cmq/Zr
         lQHudC51k0IFqGIL+qGi6W8AYAO2AH3IQ0W1zNEdg3NwxdpHDId9jN6lfd0MZl01Hg7v
         ui7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871384; x=1726476184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9iZfGPEL6q9g6QlnTdnypN7TCKR5oC3QJw/pc0I/ZU=;
        b=TGqVdoVgs4xb4+dRbY3pFQ6ehp/WW6EVaQHsUmLai27MorqvG2CRzuQ3yN715AgxxD
         UbIsKkVB6SSA/eNsVoej6/Jp/Af7t2LenvQl5mWDX39Rzaq5Vuq28BNG705rTs+ofjNj
         jlv3pqBWrtyDMMqqfHweYkYE/1/cAyGKxD4EEuufImul8Q2DVq32gvjViXYyljjLb5C7
         lNHoDzhZYJ1c8dYWJ1CDBd6EUYNL3Xm1kPHPNKsJaBS9H5uKPxaijXUTo/cNFLfeKgI6
         pNLIkRMCaL5q3/OI124Ask2HqTAGr/XY3yhsFjusH9Q3uJSWJGrHEj1YJxI0nyOontCI
         Vj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhDctkDWjS1S8h/BoJFLwrFVVWgatGBJPr8mRV0x8so1HP0s3Do4cIeK9zit+1v6U6GsVAhS02PPAL4a0FOm27who=@vger.kernel.org, AJvYcCWm9449Terkv+iAxBcE3q07fM68umKton1i3+WpQr94XZgdD4QomtzISukVrFNvZArXJjqxAreGTvPm86w=@vger.kernel.org, AJvYcCWuXZ+m3C7rRseeH4ocSZlLmC3TTAgDQmQTs9yVyM4/qxWIR/JHXPv8Bv9sWb4cEghuWzfP8nzNqakBF9gN@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPOXqVzmvMp/Rm6N7ZmBEShG9VrR5D/M9IkoGNuIOufXgI7W8
	vX7XFLULsUBTZUGpYZzh/70TWrKcArfg3smbJ2+lWrU60tUsAKQk6Zu+wPoD
X-Google-Smtp-Source: AGHT+IETpMgE3nam9BevIeTnOC8EuIrch6KUJc3lEg8eO4UfI/iouxLpDDWq53gBkBWatisEH+7hxQ==
X-Received: by 2002:a17:902:db09:b0:205:5136:b2fb with SMTP id d9443c01a7336-206f04e9433mr97297955ad.23.1725871384339;
        Mon, 09 Sep 2024 01:43:04 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710f1d663sm29678675ad.188.2024.09.09.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:43:04 -0700 (PDT)
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
Subject: [PATCH v4 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Date: Mon,  9 Sep 2024 16:37:27 +0800
Message-ID: <20240909084222.3209-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909084222.3209-1-towinchenmi@gmail.com>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
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
index 3fdec06322ac..0d184ee2f9ce 100644
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

