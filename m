Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2847F7E
	for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXhg3hM0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e4f692d06so9990955e9.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882079; x=1705486879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usOFTN8z9J8oP1ehPXietRPaPrvt1NPPISnLCzCNgPc=;
        b=BXhg3hM0pS7t3Tv35DtttZ38+AIVNojHF8gn+VBxCoAHG3KlCJo0TL0+m66GlsHTOW
         DdudZj8h9axgGgMVaZUD6RJUOeOrTucFDScxH4cKEB3qP7pIlIgaDzzgcmrLfT0suqgT
         pcl4lmGNDHx+K9t64mWzjLS2iWd405a5ggUY6fQ10oKstEMW+1dC8WiRs1HFjL+O24Rs
         r45KVsfyWX9FHmmHVzrDvQlxEuJ7tRk9C9BwnZcEelTLbXF82HUEJEHhuVZRee2ZB6OH
         yL2N0UNvwwQZjd657IuWULX2SrFHyVO/8LA1z2k8NqhjQlYYNFPTvZ3/Yq7CgE6fHjEt
         N0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882079; x=1705486879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usOFTN8z9J8oP1ehPXietRPaPrvt1NPPISnLCzCNgPc=;
        b=VoqjNjQ5mibC1/8FUXfhvE8hq5Qjm609k3tR7yfI0+TT27TqC7N8pPbfijQDQQF53j
         Y99NFdvIL26lVVTWLyafKSBq2Z8PUZMEp/SotN2Rw0YAR3m9O1qR+HOv2Fz4Lz6f3Aa2
         lndO1Vd9r4tcspd/+6DhH/4IEO/SD33Xo1Hh+ZWnzyA4ha/BvqPbcpLd4A3/K5kwgWPq
         8PPPa9K8sRBntzFQxoxy+yTvoHvzn8+Ak43szRv31joUeawOzAFLLzibCk1nyEFO8uXy
         MEZW9srnBRtqaRsmLqPcY28WppXcytJCapLuFXQsyT+pZVFV2fBf6Eo5eOgCpmB0Ik7Z
         kw1g==
X-Gm-Message-State: AOJu0YwmGlZY7YWi0dNBgV6RV7zf2WIq8pYoOn5g9VRGUaJHepA2ahRA
	Iy7p861+GeoQixPaV9FHTvSEQs5WuwLgJw==
X-Google-Smtp-Source: AGHT+IGDIg8QSdxKZ/9GjLkRR0mxgPFDnsnalInD3L7mu7gsQjaMvnyMWk8ZG1bGrUhDYCOjPQyiAg==
X-Received: by 2002:a7b:c855:0:b0:40d:b191:10e with SMTP id c21-20020a7bc855000000b0040db191010emr577084wml.175.1704882079484;
        Wed, 10 Jan 2024 02:21:19 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:19 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 15/18] tty: serial: samsung: change return type for s3c24xx_serial_rx_fifocnt()
Date: Wed, 10 Jan 2024 10:20:59 +0000
Message-ID: <20240110102102.61587-16-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110102102.61587-1-tudor.ambarus@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of the s3c24xx_serial_rx_fifocnt() method to
``unsigned int`` as the method only returns the fifo size and does not
handle error codes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 37c0ba2a122c..436739cf9225 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -590,8 +590,8 @@ static inline const struct s3c2410_uartcfg
 	return ourport->cfg;
 }
 
-static int s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *ourport,
-				     u32 ufstat)
+static unsigned int
+s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *ourport, u32 ufstat)
 {
 	const struct s3c24xx_uart_info *info = ourport->info;
 
-- 
2.43.0.472.g3155946c3a-goog

