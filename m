Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF1264FA0
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098128; cv=none; b=H6KAgKFr3HWN/D9YV1L/TAntZo1t8d0OVnACEwzZRZZevSzfKqUQE7spodR5gidUcm0tEDW4McEmATofYvIFzrDwoEdUN+kKezMKGHzeYxuao3UjLvW+kyeVvhI6iWgGofZyG3C4XfVd+GhJ2UKAEj62or+Y8uTLCXHP0ksH1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098128; c=relaxed/simple;
	bh=RyAfIuZv3je3SBTMoF+/atj8kvwGAnbZgGzow5BZkno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOcQ/a/eQEJF+brmfzD93DD2PpRpFHZNl6tXVgRFeEF4ExT8SFaZJvaPJ82RZFBKygypsJvN+i4IV7oL/mht2jfUctADeVcr0O9w/TThgQB0qZZrSesQuaisMklZSwyFUw2BziHmyLMasUVtGKApz1nYlUn+q3w3TS5A0L0Vf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OZGVjbzu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OZGVjbzu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so45455655e9.1
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2025 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744098124; x=1744702924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sySIkoaK3IRdQx4BR3TKes9oICtr7GId9/YshM2vE9c=;
        b=OZGVjbzuzdA2VJyAuhDPv+6IOveBa0REDv3Z+i3j1Qnme1xKSygWlKtm7mujBGrgMT
         AyqZR/LbFjei0gWg2mWjA8MJtlBkXbTDRr6MBtZQORHS+RXNWtY5C3zEkttZSEx5IoeB
         jcvhLOkujjG11uq2lovheJCW//uRhgzfK7LWnTpnzXBkX+xgK2uohX/+f+dthfTjqt9q
         3tuz4UeEjUeg7l2nhl7vb0XRrYwwFs+zlSQ8KaPyGfnaQn6zC0TgpfTuAevKoUDuknA5
         bkRjWqzvg5LQgtH3p0HjB12PTucvCMBLRKwo++lEPubsDzA1BAO8Y+T5vqW9TGkNOGOq
         xssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098124; x=1744702924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sySIkoaK3IRdQx4BR3TKes9oICtr7GId9/YshM2vE9c=;
        b=v+sE+YIN+YHh3+sA0b1zBPweXzCZrf7bBuqOIHrbWQxjFJmC/dY35TzofqyyauYcg5
         xsEYaT4sEXF4kGSVjUtWQh1EEQ0JrVJeY+dUOcV0vslBFbd8CwVMXjDWEYJpDv+jBceh
         ec+ReTiJghx0NZPTLd8Tu1rDM9NhZ9ou6ix2AuIgTMqM1s1YhUCEC5POWoBOI1IiMEX8
         6ezHBvB4oHHy0wzNn4Oox+p6aaJnxkTR70CNVzykDeZE53Fj1bCSFag3alJS5HGwSzV1
         Ge+5X4bEa/IlwFHIdgatVxkg74FA4eJdnJEhhq0NltGm9a1sohVG/CAtEXHdTfmwYHPf
         HopA==
X-Forwarded-Encrypted: i=1; AJvYcCXCVsUADFBNZekrMhXdKC6dTu5uZ3lwDoz52LbYnMFuewJcwQ2uPxLjvguS3B+h3mlPyx471QAKcLUh3Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSHSf9HEUChvAPeOIYUuwO1ban08bZ1aEzgfcYmIWy+sx0VW5
	/RaXISD9vu421c3r4+VqjHsrzxE3xKEHRuiF6Coz4oRGdRDGTIc1Eg+WGhbtUu4=
X-Gm-Gg: ASbGncvVr15hUmtN0GlRy7ILr8wByH3y+Cvuu5vCvP9mkGfbcNhxBKZ96titM8aK0MS
	BJ001reY4gOXMglI6L31ViOiFg5EMPSZq8vBDx5FH2J1oPq8/WI4yZGv8DsYa2vpSfd0zLAcvbJ
	U8r2ns4cZZH3TI/vUG7sEG7W0t7a7Wcw54YvRe8fgUYnMrjsbiLEDYzI7xpoYrEvSPqjO5bejYD
	uFaBUBRLkxGO1+AYiK5FsyeLlFF8Rgj56XhaxUtWeO1cioAwdQQ3SfXh39si5plTkD5MIKxF8/B
	U46Y89FqE/wFk95POYoIyeRYZClhVBEOIfu68g==
X-Google-Smtp-Source: AGHT+IG4TGtq5Au/w2UqKHAScxhidBc80RYYVfg8sQ7D96APlwDYeYiEbrvsRIpR0Qt2Wl4Y27DqyA==
X-Received: by 2002:a05:600c:a04:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43ee06401a7mr91933215e9.14.1744098124346;
        Tue, 08 Apr 2025 00:42:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2adf:eaae:f6ea:1a73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3009644dsm13876928f8f.6.2025.04.08.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:42:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 08 Apr 2025 09:42:00 +0200
Subject: [PATCH 1/2] serial: max310x: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-gpiochip-set-rv-tty-v1-1-fb49444827d4@linaro.org>
References: <20250408-gpiochip-set-rv-tty-v1-0-fb49444827d4@linaro.org>
In-Reply-To: <20250408-gpiochip-set-rv-tty-v1-0-fb49444827d4@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=r5oSZs3f1zUsjX8zJm9fMzINl/85fLjbu6aA1pLghh8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9NNJcfc8I+UE8lWGsSD2mAUzyLlhYBjZVMKLq
 D4CZcJEGTCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/TTSQAKCRARpy6gFHHX
 cqZHD/97TfcaZqLEd6+BoImr2F6qt8m0As2dhiJpJWF/3LnCMt3kpc1q7dQb1mrpQOOHB5hyxEL
 qTdEhFy69rizvMFzFKSHvV3KqE1oaw7tGkL/DI2/mO16p/z/yimAT578lLj7dt2Dnkn+BBi2RO/
 x/xMAkrhjmvCRUvosG5tc3X+XUmfEwKNT61TiMSueBz0pE6XkwSF5G+UmQzFhGQaKisXkjEKl52
 eTJNJRci/+cPjRPYOq3OSokuZek6VpVVMIXhvkPCVT3dHYqCLwgDNawvrGnHw1GSgOvkNOcWYF3
 w3obIPOYzmdnz+wJqMrfeukc8PM1qGF6AZF9NbdrRQWyD74Oj4kX0ls1H2zBzJnO3wKkRgzd/YW
 TKpczo74KFS7mpJ8xgUdWBhql1OSAxqJQuiPJl1xfd/3ineQpIg3PdduSDfmIPM/gt4u40Zhedk
 gAafzdFblv0F04swja6Q/DAQu3ycD+OpcA9ZeXX0tRDmNRICCceV3hlWiFdkFEUUuIizDKGGO5O
 xyOFFyQp342P5TfJyB4sHEtJLx5Yv4vk727ysZ7xq3SOFIaiBhnqMNcyxxGo7uloid39NT00zgm
 g/IjOiSxBH/k8aKhTSBwWIZrz7qwCEZegwWIIrHoEu2scxmEkIeUjvStc5+sLqN/iH/vtRv3lhs
 rsb3C4Mn+ZW4zOA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/max310x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 35369a2f77b2..541c790c0109 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1189,13 +1189,16 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+static int max310x_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
 
 	max310x_port_update(port, MAX310X_GPIODATA_REG, 1 << (offset % 4),
 			    value ? 1 << (offset % 4) : 0);
+
+	return 0;
 }
 
 static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -1411,7 +1414,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
-	s->gpio.set		= max310x_gpio_set;
+	s->gpio.set_rv		= max310x_gpio_set;
 	s->gpio.set_config	= max310x_gpio_set_config;
 	s->gpio.base		= -1;
 	s->gpio.ngpio		= devtype->nr * 4;

-- 
2.45.2

