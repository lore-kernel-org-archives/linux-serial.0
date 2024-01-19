Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791C4C3A9
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661133; cv=none; b=CTeRASVoZTvdD01ZidXG4hn05Qb21eLyP6D2zsZB5L6U2YDirV+WgqWXSP/Rjhd2hJ28wsvvZifE0NMevWyW8u03lp7lZgrlIWJqX1IhF3pcmJ12vuc+SpPiBJDMEFZvjOSRDVisFmZOog8ox3OwK54MGdWMgh8L2cCx0cfXOEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661133; c=relaxed/simple;
	bh=t7gRYgG5bMRtFTVmk9IzLAC+h3lcEvsViPIBwnpUPb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+LO8paUNlnd2Bf78uzj8FjTKf4zwY1JtXj4uO0l0YV7TiQTuFUzO6Ga17dA/wIqMP7Qsr93kuAaTKkbGmY21fNjXJHHiVHK++o5+thgfz6oTxcdsM+lbnr581VxwXBHWhuHy9VWB/IyXqJYG8Qk7ZFTmWYzFos893PvwyHBqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhkE8z2L; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhkE8z2L"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so544475f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661130; x=1706265930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JVTKruPLtxL591cRzZcEtaSDrfblTI6Ru/0UXyWKbE=;
        b=WhkE8z2LZ3XLGVEFQPjgSScKrabwDOlbkk2JQB5HCq65Ztqd1w+1c3s+s1Vmu9rBv0
         Yr3Pp/2oc4eaiaZcCtySlSLf/nnqc2wqvM9uk5WCUTdlBossWZU4EvopMm0LCXt1qssq
         685FcRO0coYPFOJqGMOYbqpfpYkWLOmUjpjF6KQXoHenhB0hgdO/t2rblOt20FAyr7Lw
         mSync90pBPoUY7iB6gQibDHoCkmuhheDbpqZoalnTpTvdcYbsi1yh0uXp9I65xAnN9MG
         K5T+vA/cFnbgWnzMWIvNqvpBVg1FzoCLrURfQJez2evjbnx7CsP1Aqo30rIbMl3wLM9l
         M0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661130; x=1706265930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JVTKruPLtxL591cRzZcEtaSDrfblTI6Ru/0UXyWKbE=;
        b=SxIu05Ca7XA5imUXGqWriex5ZT3c6bcusNgObS7zwofSgGy2AcX1t7HnP2dJsIqj+/
         8n6tANc0+ruj9Z01WpzdhKTY21XVFIDlmfnFGSVil4KlPvV8K5998oe0iBc9OR3rJQmB
         C5LfbJdiBRKR6XrIAPu5Zs+clv/V37yevYq+CsoYPuNr9HECCyCINHqsffdL4egkNJgR
         Y69cr7EHMkQep6G3ocuoAqES3ElFk+wGP5UNZZo/T1PyFRy6GDWbQyMOHTfQEhfNKTrj
         nwAPLiWF3pLF9aWTB8pNy6Na9n/F8w2sa5Tb5mkJc33JjgzZwqJimAmGw1HTOAevk/Wt
         12fg==
X-Gm-Message-State: AOJu0Yw2djCFCVCszEaSlqbmjUwc/IjRWiS8ONyZynD/Ms9yiCCzasEa
	CBAAcptZj+H2a3pa7pyY5DUcykrR+L/8k81GSJFfCrXoAszaDGbmRD9gck74M7Q=
X-Google-Smtp-Source: AGHT+IF68W0CE7/RmrCIDeyTMK59Z+AGRACrkjEoAPxJPcDwNgTNmegWpv1XXTv4rh9h1rjoCKS7Hg==
X-Received: by 2002:a05:600c:5106:b0:40e:9699:141e with SMTP id o6-20020a05600c510600b0040e9699141emr932166wms.54.1705661130155;
        Fri, 19 Jan 2024 02:45:30 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:29 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 01/19] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Fri, 19 Jan 2024 10:45:08 +0000
Message-ID: <20240119104526.1221243-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core expects for tx_empty() either TIOCSER_TEMT when the tx is
empty or 0 otherwise. s3c24xx_serial_txempty_nofifo() might return
0x4, and at least uart_get_lsr_info() tries to clear exactly
TIOCSER_TEMT (BIT(1)). Fix tx_empty() to return TIOCSER_TEMT.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 71d17d804fda..6fdb32b83346 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -987,11 +987,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 		if ((ufstat & info->tx_fifomask) != 0 ||
 		    (ufstat & info->tx_fifofull))
 			return 0;
-
-		return 1;
+		return TIOCSER_TEMT;
 	}
 
-	return s3c24xx_serial_txempty_nofifo(port);
+	return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;
 }
 
 /* no modem control lines */
-- 
2.43.0.429.g432eaa2c6b-goog

