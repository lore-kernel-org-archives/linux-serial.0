Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B694C60E
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661143; cv=none; b=Momjqkg7GUhwr3QFo8UidZ75N/BdVs2eKG5CsqMxPu/5jGHowX1iy9ThwHvj0t67kqxXRvi4bYoQJ9mlwyA1EOEsMxidEZP7+V+/Gxi295tod2O7AZRorCH4jJp1tsbmBcYltgHEzoCOKOUncYFC1qcijC2R77kvs3OJxrgaoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661143; c=relaxed/simple;
	bh=8IodzGZ1N5vxfAuWzuMPXTBW5vzjas6eiKlra3jz4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVoptIZa8ZDv53ALqlGNSeHTxRWzoNzYedBr/aHqStpt7E3UBRFTepAQFNd4TP56Kc2DjKKkHjcACIfoMK+ax3rTpzQSaE646WKavyha2E4yUBQDdoD3fbd4wAZqUZRNgqR6/loC6VOrArUVgRQ9rV1alFDOSVZEngKUaiC3k94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZoYfnBJ9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoYfnBJ9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e490c2115so10453905e9.0
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661140; x=1706265940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk+f6DMfyT8RxC2Uq+wxFTBwK9isaqVwqfpa2TVfflc=;
        b=ZoYfnBJ9+EFpi6j/ttlHMPIZ0beXHTh8U+4yhJvsrlkj5U1UIublpUNDUNJR6mnxEl
         hUOEzAZLAYL7edebw/cYmUwGiBe6boE7iqhwEZJ/X6EkjX7BBz2WbavMr4BTqIZLvXdJ
         PWplINFEqNSpdFdI+716B2ZzP3wUZpQyJiGB166fgOZSPSr37EEtnPUoNzTjW7QlDyZh
         DMJFffVCQpoMyFhgNP7hZpvaiFmgo0YSmcz0aJnz85o/yKLZG3WEp9mUGK0qB/8/AcWN
         838gf90nyYiPWAiOggc/8l403tPxSgLFmJ76tln5rEzNTmnDVnEiyaKVC/zbhXAyCDfy
         TfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661140; x=1706265940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk+f6DMfyT8RxC2Uq+wxFTBwK9isaqVwqfpa2TVfflc=;
        b=C8nR/AEyeQRf6gurbLH9Jbe+XIf9Ax7P0fqVDXnP2XcY6qogxK/T49jBSBdFaubzbc
         Jz8luAqSP/REzdV2kdn2j7Uq+dG1s+sBaDIu3taLO2lO2G/tyN44Lp/oK+IW562Z7TIC
         8clcXC/7eE1wIEub6pQ34m8/6v1QPcNqLJnUEQjxPH7TosF2n8jdEEnWBUBtNI58ZD0B
         WdFWf0FRYp7g2ES/sxnqVlN+0x8xxd1ctB+B3mwTtVLGNE8hB/llno5Y4NjMkrku88PR
         h5mDGR4L+YqsRMtJd4PZB4M6ZR9xpDokSBOz5ebgPvPIA+fF03j5L1Hp3M0YyyZQschU
         zwqw==
X-Gm-Message-State: AOJu0YzTHc3stL6ryDYnIdRb/RU/0RdefnswMIIegBA5QY6au5ubW0Xl
	3ml3nXo9L0lv1MY1fJkjNqTo0VXTLUgdOP15HIgH94SAVIPzwvGGigjpVyp21tY=
X-Google-Smtp-Source: AGHT+IG8YnM5QzfuxMFX1zhOVACz3KiL73IJvltttYQcWx8JPktpxDFvbwhDtd+mk26mM/jTJgFwfQ==
X-Received: by 2002:a05:600c:354f:b0:40e:88fb:e8ef with SMTP id i15-20020a05600c354f00b0040e88fbe8efmr417899wmq.4.1705661139905;
        Fri, 19 Jan 2024 02:45:39 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:39 -0800 (PST)
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
Subject: [PATCH v2 11/19] tty: serial: samsung: drop superfluous comment
Date: Fri, 19 Jan 2024 10:45:18 +0000
Message-ID: <20240119104526.1221243-12-tudor.ambarus@linaro.org>
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

The comment brings no benefit as we can already see from the method's
name, ``s3c24xx_serial_pm``, that it deals with power management.
Drop the superfluous comment.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b6d34c9f46ea..4bb75b1eceef 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1295,8 +1295,6 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	return ret;
 }
 
-/* power power management control */
-
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 			      unsigned int old)
 {
-- 
2.43.0.429.g432eaa2c6b-goog

