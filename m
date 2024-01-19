Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2B4D5B5
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661141; cv=none; b=CossbtKWc6ruOSqrqBFtx67RYt7CZM/jGyNyCZr8f7b/Aei8lVCGM1RH0XKmLZRPUvLKUuM/WHhUOre0P76gIZ8VshRf1NnUepwYsGTF9Buo5VYGGc8NMA0z+wCfjNfCxLHuyRpFDUPYr4xB1b4LX62SpUH8gY2tdDc/XxPyQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661141; c=relaxed/simple;
	bh=9bJVEIeoTaJjZ61pXNxm06VhyRFtHsguVO+YA5dDTxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVuaTgjBcXwUohaph/xmtSh5Kv4vDVXeB4D5N0je04SmqcqRwiXMAqe0zTvvVbBq2xEPQFT6DfV2drJinviKnQ2V0evB75rMEG8tvxHsgTK7DAm2tPE2FiU5ZiVdz0M5cWVWjHa0k6+QdolqqTxowQ8jqF5MGJj3b0WB3x+AyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UcswlJwa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcswlJwa"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33921b95dddso173651f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661138; x=1706265938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ40aSkF8Aok0dVvTVGIVu4hOfQge6DrOyhL11J8cEA=;
        b=UcswlJwaiFT3zrykl1Bu9Lwuas2/c9fMlRJaid0u9KnPLpMflbyR+YeEe9Up9d2+qY
         BbbZl2msg6jDCjMjd58e6Ef8Kdyt3bEVFEqkvdIHn268s9hGyFxfNTmpDZqrtlOADHU9
         8tWWvBGQSyFNGjGqpTdzEuuYVv8al/EIGJXQZa+rEIrbHY28UYIOl7rWTogaI8cM2ogT
         TUiydUQtVyRXbUMXy4HvyxdPF6il4m+xpsVdYENap9g6KH/KqARQYC9pJ4CD7rSEQUBZ
         jN7MvtiqcCxPzpMqZcy5iXOADdj4lJTDWijHD4QBFZxzTsnXlfJpJH5ntvAiM/AE5Ld4
         4iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661138; x=1706265938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ40aSkF8Aok0dVvTVGIVu4hOfQge6DrOyhL11J8cEA=;
        b=QU+bm9kj4kqS+RBg89ufcfvWmuAzcVdwxoZ8XoQcPGXgxQ9t5vrsQm2jKURn3+Hg75
         89N9FHM8cOUj12Tncul8BKpnOo7H78eLz2xed3eGbMC3r0KncWjU9aC6zhRiQgT0ff7i
         okdDJfrJC50cl5ZyngXwBUKpiv8ZdfgleU2ZyY4qTIZg66FAXfcungrPsfgur4r/KeLW
         A/qIdL5Vu/3ttD9SnAjDfAMXVKrhih7TLiHr8V6TPBwg2q9zLAe6dOEYA93O3eNdYXX8
         ogqLqNJszLwvSstrcMK9xab0WATes9Sv4sXV9GrBjSorX0G8i2R/bMdlX6bKJB8kYlMT
         CyHw==
X-Gm-Message-State: AOJu0YyNbe9hTlMsIULQBcsuj9wXNL53kouvsCkMtonYvwg04SoGgqhW
	ZtahfkKsJkk+8Y6EwIWwPzXG7C0QVmi2detK9a6ssN0r1UuG1PpYUTM2vR8Vixg=
X-Google-Smtp-Source: AGHT+IFB56z75wwv61vkNgNKZ52ys1BI0PMljalI5CjTRNffvDMu2NmbxLRBYtutQlkZKDjxtS4Jcg==
X-Received: by 2002:a7b:c8d3:0:b0:40e:873b:cf73 with SMTP id f19-20020a7bc8d3000000b0040e873bcf73mr452698wml.54.1705661138275;
        Fri, 19 Jan 2024 02:45:38 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:37 -0800 (PST)
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
Subject: [PATCH v2 09/19] tty: serial: samsung: remove braces on single statement block
Date: Fri, 19 Jan 2024 10:45:16 +0000
Message-ID: <20240119104526.1221243-10-tudor.ambarus@linaro.org>
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

Braces {} are not necessary for single statement blocks.
Remove braces on single statement block.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 8b396c950933..303b67498c65 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2061,9 +2061,8 @@ static void s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
-	if (port) {
+	if (port)
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
-	}
 
 	uart_unregister_driver(&s3c24xx_uart_drv);
 }
-- 
2.43.0.429.g432eaa2c6b-goog

