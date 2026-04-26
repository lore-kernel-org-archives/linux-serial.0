Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D523E358
	for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777239784; cv=none; b=a4/PzcAqRPm42YcrdNYlZxQUsPydmWUcD/OUIiXzCZCklomwYeMLS0lkcKBqQPQ7G79y8EmB2FpjUF20+6akYzVOkgiVXOF161SaNAz3E/DW3GZYDdYHSzgtmK3Ny+T1K0kl7XokjlVQ/r7MyBs5reupL/BlXIkz4HMXZRANMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777239784; c=relaxed/simple;
	bh=+NDDl6FC/lFcy4ZJCUql720fhof7233AtLZRb2lm4Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMuRyBKNOS/wgs0Q8D+xVSZIbDKLVmE9BMzJWtMJ9zbyLB1esu/+yNvR8PxlThtp9f/dr9ovizi0kIW714XkpYX9D0VFMk54pW04XyKJwyiCPw37yuOgDfsY4RRa5m6DT3XJWkrJUkhG6dlN0WBdt9S07Ky1t6FYVq0WG8Lq7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqrDHMr8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqrDHMr8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso69310515e9.2
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777239781; x=1777844581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyO/fIf9mlptgfmwEFv0+iVbuqCap8jpTzF1uKuXdKk=;
        b=HqrDHMr8xqQVhuBmThAfihjRhrBcLyrlxFV/mgZ9sQmTNZGSvk+sBKeCETXQCPfID6
         SRo36cgrSJotI00m4ibdWzp+MZkBgLX+SKw9HJMl05f4Xk3SW3pDlLoHmKVH4e8t1BLq
         I8H9OiCMs1jwS839Ig3LObvBjk96w7+7eTgGVpiDkB+YJYRUyuuVu1zNpJmDQPDZxCu9
         DZMPwoduWFQrzSO95qMClsnZkgfO5wMofGeEiWeEo8LmLXT9IZysSOAd/E+LvPRbJIED
         u9aSAQg37Nbk7QGbyyM6+Id1QVbXExS+YU5+z+iNODrhGFEuNkDCYbYRy+wH9I9KvJSa
         J6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777239781; x=1777844581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyO/fIf9mlptgfmwEFv0+iVbuqCap8jpTzF1uKuXdKk=;
        b=VmZTQuQpUysVc0jWS4lwPW7WwyIymxIfl7rLtWhdDQ8lnNfYZBlFDSnrR3ev9H+l3s
         vdDX6SB/FL84pi6NY9qYw7KvJglF/DMGVvMF7FLlWrCmHBxl8C8zu4s6SIoOyLNm22QO
         JbmxLoieIJndClwoWDqiZzGZzqrX3TY6ty1lN5/xo5aRVu+ip+nGGQ2Lx+XSKINGMt9i
         ee05YCbrKJR8rrL00xycPrwKjQ1+O19t+j5qwT2OX6dXoCqSmIhJ5c8tfQUtv8dlVQoZ
         37QhbHREbEFJm5WvdqMHUQHdrY8PLcqtm9x6rH3723w58yFCd3lHSdOUj2qC9UmXHiuC
         qquA==
X-Forwarded-Encrypted: i=1; AFNElJ/y4T5vk/N6kMFFZDEwL0Tec1FCm3wANiwx/7uGrRu4WixGWNDrYysFSg5BZ4U5OSWebEB0hiNVeX+8xfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBsPkXcfgGNoVToPOwemOT6rVmx5OwrjjtJR41QEIC4sMZx+F
	SbFxoSei6SyD8kh6seuQiLnEIEth4evHpZeIiRvB7mbF03Yd8bdod0z/
X-Gm-Gg: AeBDievKcYWMTVkIgSJdHsxtj2UpAfjFmi2WzVEa1wpSEYJZgnqOvFy+3vbHD49nFRu
	uZN8bgoKcafWkohB3Ue9Z33rA4jfpHILBmN6Uy1nIx++ejeUnxrNR+0AGab3NnHRjkfu8lDkMIw
	b+GnbwuXGHz0YZg9+KJQix+kCQGTN8/KciGNuKoyyTRnFcjzK7zz8Fla5tajHX8ps9piMmeYwI3
	ZU05bqF0I/xkFTnB7bskYCZAQeXny7zhplCnv9qjHrH8K4XhCxdgTGmwBd5hDfgu9L4zG2dLJfe
	r+aWgHdTBaX53duwKqzk+gGaT/T2bgOJGpm8yBBzzpA61io8a5VXF+uBCyf0xVVRxaYwKsf9CmP
	EqHyIpj7mKp4nl/WrI85jju5a9xQ3A6mkbqG2mXakioTXZN+sNfaBExI8d9t2laScsUf9a3TeAL
	8E4yZS3IX9u964bR5MvtppushFod34Lw==
X-Received: by 2002:a05:600c:a31a:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-488fb785b7emr432470225e9.26.1777239781269;
        Sun, 26 Apr 2026 14:43:01 -0700 (PDT)
Received: from fedora-dev ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm782831725e9.15.2026.04.26.14.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:43:00 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH v2] serial: mxs-auart: replace hardcoded 1 with predefined macro GPIO_LINE_DIRECTION_IN
Date: Mon, 27 Apr 2026 00:42:50 +0300
Message-ID: <20260426214250.781151-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO_LINE_DIRECTION_* definitions have just recently been exposed to
gpio consumers.h by breaking them out in a separate defs.h file.

Use this to validate the gpio direction instead of the hard-coded literal.

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
Changes since v1:
  - Commit title change
  https://lore.kernel.org/all/26cd0656-ca76-4cb7-9f1e-b8c042a7e2cb@gmail.com/

 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 693b491f1e75..697318dbb146 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1520,7 +1520,7 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		gpiod = mctrl_gpio_to_gpiod(s->gpios, i);
-		if (gpiod && (gpiod_get_direction(gpiod) == 1))
+		if (gpiod && (gpiod_get_direction(gpiod) == GPIO_LINE_DIRECTION_IN))
 			s->gpio_irq[i] = gpiod_to_irq(gpiod);
 		else
 			s->gpio_irq[i] = -EINVAL;
-- 
2.53.0

