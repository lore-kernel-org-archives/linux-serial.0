Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4032F3C01;
	Wed, 27 Aug 2025 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336272; cv=none; b=WFXVNTVR0IEeME4IdwBjuZU+cyPr8qaQz6bhtAAqhJpop83+LM/53Nhx9wzOFV4wRjAFyz5JCAGLlcq6PWpfP4MyVNWxNKcGvQB8grAvJHF9DpjtWjTfagmCPxGbiGvKrH3sJOrbcm2qEIlwRKX7oo0bRIzE2/jd61ex8g8U9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336272; c=relaxed/simple;
	bh=sV5p/8hQyYhf/F/xeYzTMNSgTTLGCoZL8gvJCvGfRpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hl/+gmEzMMjCv7sAiJaNOsX5CuGYVk7jqDvlN5IeqhUu9zWxWBeQc2ubqnL8sSJ3mkjKeqRnqpPkE/ZCw768FaDqlFcZx0WXfiwkOoH0FbS+EgTcQ7vuZTtNpICvIHrSBUogmLsIS/2JnZX93CtgL/5WIKN7o24LhMZDr2fYXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENlbXIkC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENlbXIkC"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afe84202bc2so44881066b.2;
        Wed, 27 Aug 2025 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336269; x=1756941069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2Y5rkqTkQGFZn+G33FhbclZiqRvFHI9z8Mh5cwkab0=;
        b=ENlbXIkC2tAcXdIo0fcG2SJz7MOp3lLhTqLenSnCvM6JqyN3jdg0YO1S68fHKCXzuI
         QkdJZuxn4Ix+t3q7yTjDb1gNvsb1+oa421TwKgRknlG5xHgGg/b8eFjD2v0csfP7Cs72
         ylwjzUx+YQvuE0eDt2VA5SPqepBBk0k9+YxEoIjH7SUIvcLYzzJK4zMX9Zp4CcKh2gvD
         e1ZsqJY2zedb621lkC0svYvqLZyuODiw/QFzyWGKM/JxMJST/6UHAsw5ilIX0r3FARH6
         0X7Mq4Z5VVAD42g2eOvcraxYxZH3Ewj/L07jU8ntT+jwAxltPbvePEV6bjIVhE1WOCwJ
         U5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336269; x=1756941069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2Y5rkqTkQGFZn+G33FhbclZiqRvFHI9z8Mh5cwkab0=;
        b=MMDkYFdF3QKxFBK2U9nPKDsg6NE+zZyq/cWvA7oIdg2dGTjA2BU7OB2C2hfhgOJOHA
         Han753W+GDjRcJf+6Lkzt6S1I9NAV8ydhY7TQvRbR92TKRwk/yVkt1/IUi/Wn9Y6b2t5
         LJYg32JVL4DbeKBuRUtZor3/6Ip5HkVz1o17btC7OpHZcxNFYsrebpYMEBlypDC/J8n7
         19/K64Z+EZNIAoO1EA6U2WgLN3m3mGzgEh+LKgCOO5eWWoxzWliuekl9na2k4vTYAsE9
         Xpe/j+sM4prlN7yaKVNC3qhv0aVs+H0WUWasYYg1edc379RAdsE+yhwJRxgz8pf5wpwh
         cRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGNM8NCW+HadOWPVnwIJSpZl620fzEcTgw8eH8vV93uk1a5gHSdwDoob1fRz99GmYbc8/hOHcPCeNl7Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzJKh7+RkiCo6P4e2uo9WGGW01yQVCtHFvONbBB1XrSWIPS7X
	yUy7WEtnzhNjrtlOgmr9izk6ARg5hmXU7B+27CVTEXHoReP5vecTS7Ij
X-Gm-Gg: ASbGncvp51+HLw1j8Ed500wpH9W4xc9FXYIHz7fl4u36Gkv/ONpBjH/2Cp13KlosnRC
	qhfodCSuy5MEy6eaOVDxrlyPf/AW4T63/Kyb0D9FCOlSXwUHbcJcshPKvgsoCOIPlWYTK319kg0
	FKrealneutihCvKoEOvxuveSX/YmPFzElWl35EJYJSNGgDmW6olFaliZZxX3gsVcyIZbLuMKb8H
	jea0Cy9jdeI5Odokin7jZGjWs9PnN8kd6a9yLpyXjlxi1Zquq0eYdmpr17tZogT1NTRRhlaSjNi
	rD+Mky1tdagfr1ncZkGo6dR7xeDRzIsSeF9BmOwelQzitZBKbgwjArv+DidFGtFkzaLGwGgVjbW
	rstpDysbgC4Fz+hWUx4qzbUDpZHz+pFgzCUj3fm6PgWfEOU4s7GxJQ0QmN77JYLzIO7WTXRdGF6
	B55HZm+JmP6NGHddU=
X-Google-Smtp-Source: AGHT+IGC0ek2tM1fa4TYn2jXxr/gTcFEJ29qVv+nUj3N+Ad09aJF1WitxL5+HNd2VP4bg9FWCyYi/g==
X-Received: by 2002:a17:907:9693:b0:afe:ae99:9d23 with SMTP id a640c23a62f3a-afeae999e86mr620115666b.61.1756336269319;
        Wed, 27 Aug 2025 16:11:09 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:8c2b:6018:3d63:236f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe907e14a1sm619320366b.74.2025.08.27.16.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 16:11:08 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	elder@riscstar.com,
	benjamin.larsson@genexis.eu,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] serial: 8250_of: replace kzalloc with devm_kzalloc
Date: Thu, 28 Aug 2025 01:11:05 +0200
Message-ID: <20250827231105.126378-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_kzalloc for automatic memory cleanup.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/tty/serial/8250/8250_of.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index d178b6c54ea1..4fe3b79d0e4f 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -217,14 +217,14 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	if (of_property_read_bool(ofdev->dev.of_node, "used-by-rtas"))
 		return -EBUSY;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&ofdev->dev, sizeof(*info), GFP_KERNEL);
 	if (info == NULL)
 		return -ENOMEM;
 
 	memset(&port8250, 0, sizeof(port8250));
 	ret = of_platform_serial_setup(ofdev, port_type, &port8250, info);
 	if (ret)
-		goto err_free;
+		return ret;
 
 	if (port8250.port.fifosize)
 		port8250.capabilities = UART_CAP_FIFO;
@@ -266,8 +266,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 err_dispose:
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
-err_free:
-	kfree(info);
 	return ret;
 }
 
@@ -286,7 +284,6 @@ static void of_platform_serial_remove(struct platform_device *ofdev)
 	reset_control_assert(info->rst);
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
-	kfree(info);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.43.0

