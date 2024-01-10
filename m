Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55240BEF
	for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYBshhb/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e43e48a16so36607835e9.2
        for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882073; x=1705486873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwqnqS/wycxZAhr2uerf+qQVYpnKiVk2U9Lnh+3LXKA=;
        b=FYBshhb/YFgpGgyC0oFjH3SM7b/iaSx6vx50RqqOq6x0orsdHw54YLi1vwuMLWub6U
         oO3oP3A1hC7RPucRt7tTtFJxBPldQr8gAnUhy1RQYE/uouf/UpIK6w5o9VjzvOSecqSI
         gGA8cbBTZ/Il8dAE//cZSq7CDB/ws5/YZ7iQu5YQX9KVkd88Bo6Ul2puSJ7ZAWAKdpOx
         kbEnCGZp+7f0Y5uyQBOo1UoAjvW9XD/NvrATBim4X6zxd2EK/kcx1T0HNkYfco/FOtDX
         F1a9M8UX8a3/acHKtLgE/Dc2oxCKZ17OU3bSPyj8maRJHMZNT/TkzVTn28vDgiTKR0PO
         Rc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882073; x=1705486873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwqnqS/wycxZAhr2uerf+qQVYpnKiVk2U9Lnh+3LXKA=;
        b=TXF/GrGor2YWeGS7sVZjTUQS8US0hamfxe5eOfmQ1UPOaq6H7npHM9Q5GKs4XRsW3P
         LSzHbml0MF+MxKNBXPO6MpFj4SKaX4xQWWMeTuuy9hTznKzDWXojg44N9ATGu76Fv8O9
         WKnHQDvESvTJ0oIRPhcNsXy9hQP4E0jbQBNA5FH6iTowM3IBK7TP89o/OAETBlQlJjCP
         2O0a0MXgbWjUehsbzaQqY8IuO3FmTez8k1d3X7zURmP4dDo91B0DqGXqs2s37g5cHCc2
         auuldgfQpHjlO+5VMOmQSIFivFmfdP9eCtq+HUneEkdSh32JnDDOKjfodSgNZwrQ2c9q
         XC3Q==
X-Gm-Message-State: AOJu0YyO51kZUTXJuHlLUpmVVETi6lXsnSK0rfmZbvwAVN0ADprjUbXr
	RArpWv/GyWAN56r4ZzlFuduJNrTVM+VHVw==
X-Google-Smtp-Source: AGHT+IGcQBbhMHK+EKOMon1hp4+KGJv3InwLXWLO1SrdmS31XEWMZkMTbvJjozVPLu3hLFnAqJN0FA==
X-Received: by 2002:a05:600c:519b:b0:40e:49b2:2c9e with SMTP id fa27-20020a05600c519b00b0040e49b22c9emr439607wmb.34.1704882073274;
        Wed, 10 Jan 2024 02:21:13 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:12 -0800 (PST)
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
Subject: [PATCH 07/18] tty: serial: samsung: remove braces on single statement block
Date: Wed, 10 Jan 2024 10:20:51 +0000
Message-ID: <20240110102102.61587-8-tudor.ambarus@linaro.org>
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

Braces {} are not necessary for single statement blocks.
Remove braces on single statement block.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d5f9bec24b8e..11ae3a1dcdc3 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2062,9 +2062,8 @@ static void s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
-	if (port) {
+	if (port)
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
-	}
 
 	uart_unregister_driver(&s3c24xx_uart_drv);
 }
-- 
2.43.0.472.g3155946c3a-goog

