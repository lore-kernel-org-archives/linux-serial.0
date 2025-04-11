Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA9283CB9
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403918; cv=none; b=DHSlwQjqJk8+T5aHPoCfnjQCbzBbSqlpuI6b+2WHEratdz4WPM3SIZwmqq5lOa7qI3c8PgWhqEQ8ZKmxM7tTJfEYvk/O1OF6pYOlTeNwSrQx25XNQkbRBdJQSHf8/WxTeCbqSGDnh1zxZ3+ABx4scq03Oag3/dDCLmlL1340JuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403918; c=relaxed/simple;
	bh=ucvbVh/yXALhRLORxO86EDtcUDjhXV2k7FhsHq1IhHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6DxdEMxAGv9HZN/zKnBq7RHKSqg6rXokmwbuX2/9aGqIocMgVyGpV7sIJwiMHkqiVD/tdxnHJ/A/2PwtXgr6F+LcUHfw9gys3KnjtlRR4MLs/Xc1s5dhQsKGZtIY90XQBadO3ZNoumKKBxQS+3ZrFkBcxklUKEGKioSltIELW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=cXU48zgF; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="cXU48zgF"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d5ebc2459fso17574385ab.0
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744403915; x=1745008715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+No0irtswkb42oZgjOuCr5NaquvvHMgg0F5193JRX8=;
        b=cXU48zgFWzBRuyaJqPSQBeudmkNcwJzmyHVLUhiZ1tbYhSwFqkga+JDpmeJXgbUC2H
         87zLgsjwR+fwg9W162QMDCtNdGoUEH+Pxle+gYmig2qUIIB2Cn7geZ7BQ0mV2ZA64L2x
         vCbBm95xcBs7zspdNi6IKGYCZcYnIfl5XDZ7Qq2oIEk7LhoRa5yb9jf0gTc6hz//hjXd
         71Qw9mkDv5UaooqQTqSRRSOMozh3Ge+Kc+cnMkbmafAXgIx6PfThNUYbp3/+5Mbx2znY
         CQQc+0BipcYgqRWpY3otAuWEumHd8vigCbubJerkibN4+m7+Bd/4ILqqkGp3t3tcb83m
         sdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403915; x=1745008715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+No0irtswkb42oZgjOuCr5NaquvvHMgg0F5193JRX8=;
        b=OXTC5F93yX4l3pdp0dUES1abHvVTfyTF1B9TOD/QUQ+LLdv/ErPeqOQtDezGAIlEbp
         tQtC/j8geWUqBBVzIIdSwZe7SMzlkZTRN9Y3Qrp/7CVbOXxzLyjamnz/eVYcovaRi0d2
         Box1WtFkrqGPcbiB08+GKBIufd4t/M+rkmbVwbPjZx6cFxLq91Dl83ld+ZSdqdS/uoqN
         tSh2aIMSkDp8XBAahtkMHJANkkri6RJ3/PnrruP0CsQCVeB1rGBmGrCvkQ4IdWvHap1P
         C8X+dzcAnsEI3CB+vYn8fVL2U1c8MTeXU89XCbUECTkFkg2MiBPmpQJIYLupSWrVEuBX
         Xmhg==
X-Forwarded-Encrypted: i=1; AJvYcCUsbtVXV9i9IfWDSJtAk1ECNN9DrclzqildbGfR5MMXYnUAICM/JqobSNgGPYmqMLs90yr/rmpseNBjA0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iYkptFsIf7VbLc1J7KogM6H6LBYHoVtEwAY/DZ6oj9dLgVXc
	BdtCXJItF7fi8ANowd/QqoGXgSDRI7DA8cc7gI+oyLDTjKP+S/xiXm5jaTvaCEk=
X-Gm-Gg: ASbGncuCEIOzSY+brgeurSloe5c0XYaECqwJ9oYsqQmYkei+TRBrnUxBAHDg8lM4wZ2
	PWNWD9R50ADafHR7tHtBjDEiCgFTNzhAZ5LWDNiMTIfinlkpMRZBDj8FnJTIKAVVp0kzVLFCMen
	oZqmoHxjlB0B4RHkM4dy3zC4pF2OgyeUABKg8MsdPQrv0RFCpMbjUUaBDEzEQsAyzhislpOlrOk
	Xq0i3/cxEJQ/W96tCOF2MnqreLJZW6AEvGZbNbL6PMgMTTiNsFMpZoRvjIttbaepKeuQiF0fZfp
	hc8Z+Ue4Pgpu0zs/zhE4mANJjda6O94KlGaSM2EdU1QD4MTeDccs1hVUom2AbUVDF3iDT+C5Djc
	Kygshdi4IR1lvHenXlm2Rmk8D
X-Google-Smtp-Source: AGHT+IFI78Dq0uhLXGQ3VPmWnhBpX7t1jvh+2+h32uhUwjru/tDqrj+isW0Bsi4fpyNX4H8KLkVFTA==
X-Received: by 2002:a05:6e02:258d:b0:3d0:237e:c29c with SMTP id e9e14a558f8ab-3d7ec21bdfamr43241385ab.12.1744403915441;
        Fri, 11 Apr 2025 13:38:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2ea1esm1420787173.123.2025.04.11.13.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:38:35 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andy.shevchenko@gmail.com,
	dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] serial: 8250_of: add support for an optional bus clock
Date: Fri, 11 Apr 2025 15:38:26 -0500
Message-ID: <20250411203828.1491595-3-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250411203828.1491595-1-elder@riscstar.com>
References: <20250411203828.1491595-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT UART requires a bus clock to be enabled, in addition to
it's "normal" core clock.  Look up the optional bus clock by name,
and if that's found, look up the core clock using the name "core".

Supplying a bus clock is optional.  If no bus clock is needed, the
the first/only clock is used for the core clock.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/tty/serial/8250/8250_of.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 11c860ea80f60..a90a5462aa72a 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -123,7 +123,16 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	/* Get clk rate through clk driver if present */
 	if (!port->uartclk) {
-		info->clk = devm_clk_get_enabled(dev, NULL);
+		struct clk *bus_clk;
+
+		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+		if (IS_ERR(bus_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
+			goto err_pmruntime;
+		}
+
+		/* If the bus clock is required, core clock must be named */
+		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
 		if (IS_ERR(info->clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
 			goto err_pmruntime;
-- 
2.45.2

