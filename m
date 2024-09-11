Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A647580C;
	Wed, 11 Sep 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031316; cv=none; b=qXpTwidF/G/9qs5VuqLrMP9yM+i7717iMpuR4JTYFmlN23vnM2UT3CvwVt6QkyGGDw+xLXXo3nqRVEh6Wg4F5EMifZC5ybAuAjo/DgDjqVS7ZABjeqygGVwOPHc/r1B2He4vLjJMTFWH5r35znIRh+Ao4qGj9k/ykSplsl2o4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031316; c=relaxed/simple;
	bh=VbxyHgLijtvMODTxWu3V6V7t7MJUjo0WXZgNPC4BS5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+jQH72On+OgPWWfB2Tn0rk55/tD6VGMOu5cPnt4n/K9ceFFNdw6QWe89yylMfdQW+KN4+pRh5zHLGUoW3NpkTebme0JUAnTUWBBYOFkP8J8VC/EMPypKzELfRfrDMB1CtvWVShMbZC2R/pMMRFV7MHQWWHu1gJw13YuNxFI48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbL+qnB3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbL+qnB3"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso5148547a12.2;
        Tue, 10 Sep 2024 22:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726031314; x=1726636114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvwvg02SfR9k2vRdgG/Bv8ENZ6rOieWsuZ6MKBRYnn4=;
        b=JbL+qnB3uvABs67Yv1PoJBTN7IHOztIEvA+2/hTguQCqiuiKw/+McUfnpO/K01oZIl
         aubLCdSZTMn9ZYJrOjkgA0Oqn2263kUintngITFUu193z23H655+ce45XmRzXBttE4Wi
         StweptOIx/4jiXCU0nDPQxvS9uMw4yO/LsPXYF7cFcLqprfGj2C6ZhDwKJN6qkq6QK61
         UN/Z1l1VHbBx6jQDnoh3HuujED990RCCgNS7CcExzWUVLcPx1M3Aq8qDez0Oy1yVboSf
         Z23Npg4IYKygyJ8ClIFu0KvmF85Bu5WNIm7tZ+BMCD86tU4tW92T6XCS+F0Y63oHwCyz
         s4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726031314; x=1726636114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvwvg02SfR9k2vRdgG/Bv8ENZ6rOieWsuZ6MKBRYnn4=;
        b=oNoHLqKO2QolxO1zqV3oZg2f0KHTOUa+wVVtPI9OxMxHs9O8FgpSgRWp/yJJ6nTlxZ
         fSqiKQj6OE7u4JkUdROZTL8PEh2bAC9DMq1R7Np7PwVSx2J4+AytR2wH2Oh7nsDSmxuq
         Z+VXY0QKV78jD0U+sQSJKKFyp/AEeAWb8AqiGIR+MJXXSlvFwnAvJFImgQwl6jKPazAt
         cMP74VUusgxY/ZSLg5/YLc8IqoKZVxb9NoKqoNMdE8IbB2ze8XHccEdwu9Y3AJpgZHB8
         86jwDqurCL9GSMjvXMMoCS4AeSEkcvKVI09LLhcJqDqCnQQTF1DbZ/V1VJvQDKCzHSDh
         NUvA==
X-Forwarded-Encrypted: i=1; AJvYcCVo6obePlGw9D1IjP+KED1uNDyStJBJz4JvVsPUsXkHdolah8E4YwVruEaZSDWd8M0MZFNCa7zE4HQxVZZ+@vger.kernel.org, AJvYcCWev1xqUfqj8+GZVsuG8yW7AxzuiFfyDPiLYX3ll6GK4+vLFUN9QD6GbnDRoznxHkNIQ1OwIPeDowEAQfw=@vger.kernel.org, AJvYcCXWC/Xpg7o5I+Od7YdXHyG+EQqx2xvosJ8pTlqUg550dOp1hUoslhnl4MDnBKNsT46LCt2Ii9uCVkAdCViYfm1uYRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsuz8sCLJ00la3I1xHnD3PeTtlTG0xHMp9KUDcK+AZpfhXTTo6
	/5z+AU5puEUIpVj3+ZeDEUd9WkQPmiRDF3LnZcoQ1RqnhSBSAwzl
X-Google-Smtp-Source: AGHT+IFSx1pD+FrsMRBNSUqJhlhYmY2n61Rn3DDVI6qu0M2QdurlC7Tp70mR5VSk+EzWYPbRcaWNmg==
X-Received: by 2002:a05:6a21:3946:b0:1cf:3885:b9d8 with SMTP id adf61e73a8af0-1cf5e0ffd16mr4694941637.27.1726031313731;
        Tue, 10 Sep 2024 22:08:33 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-719090d11e6sm2156984b3a.205.2024.09.10.22.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:08:33 -0700 (PDT)
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
	Nick Chan <towinchenmi@gmail.com>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH v5 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Date: Wed, 11 Sep 2024 13:02:13 +0800
Message-ID: <20240911050741.14477-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911050741.14477-1-towinchenmi@gmail.com>
References: <20240911050741.14477-1-towinchenmi@gmail.com>
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

Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Neal Gompa <neal@gompa.dev>
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
index 2a934e20ca4b..102aa33d956c 100644
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
-#define APPLE_S5L_UTRSTAT_ALL_FLAGS	GENMASK(9, 4)
+#define APPLE_S5L_UTRSTAT_ALL_FLAGS	GENMASK(9, 3)
 
 #ifndef __ASSEMBLY__
 
-- 
2.46.0

