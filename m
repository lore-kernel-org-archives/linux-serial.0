Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E145DF69
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699202; cv=none; b=H4mXH3/5SneflRap2CE5a11Y9YzcQWfGBRcY8hEoloC7nrw4wmrURCQ+WQLxGuImn2p5wEcNvL3qgukap34GPflEL/SeJl3iu7CWeH/H4RMW50N0/466+08AbEcidjLcFiMZLRfPuT1ZZer2adFoSz8JuKkhFaoxPvjwXDHQ7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699202; c=relaxed/simple;
	bh=TQ2fAV07zoYNEgVpLO4kdUMaIC9Q2NtdaXJZiFWN6G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TljggRRGQdr2mNzUacQnM7JRDM0AZEvi+jhgqoWoMmXD6ia3FCARNrATHM1b41RzIVxNOhXltK4GEBl2K45mmgD7Bbi9VgMZJwnC/VTl3NJrT16ocYND9+MSxlcy+ZTiu7gOkpzNRULPShydktJdaTs+f0uDMqH5PON8XrvA75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cNCLbC+x; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cNCLbC+x"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-481412f1828so261494f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699199; x=1787303999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prvetDAp1SQsL701LfHd3g6Dmr8EOWFJnI5IgqjID8s=;
        b=cNCLbC+xHAvf9tRAg3IUhyghxsq6NiGaxHWcPxUlplaNEwIvIe4t4YARXcRDDk0CZ6
         YGMJhx0O3wBtsJTtEgxQG+3Dxn3n/E6ry6y0S9HOzfyNjKSmRnWfFQJei+ixYxDHiuSd
         lomGBd0mh08HNy15Gf63Qj5GrxNkxzbHvghKqGQMv1PxEHVq0H5pJ0kOd+jmC5bIwxMR
         ZrDu/XCsbTUMaSz3bK/H01+/YADeJmjQsOCsyl+ik3s5wvT3tf5CpKw/8PSx30neXnJG
         LBQrVL7AJrO4qaum7rRFaJw5MYWvlkLvtYkuV2yHFZOJdWDMyUHPzZADrx1uUKPdXAeH
         7Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699199; x=1787303999;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prvetDAp1SQsL701LfHd3g6Dmr8EOWFJnI5IgqjID8s=;
        b=YXr0pDH/uJqQGYbcoTjXKEUcnlZgsSWaXeSTWtd4AiC2MrYzwY3Ry1IlTGQI3QhY6K
         Ao3VECuG+6nSq9eluskzC+bBeiYt7+IRuwars5odRcwBCEIpDi8s8+4+08SW0/H7/UBG
         E48yjW6UmGYLuPer5qLPhq2QCusqf/nTryDyYNM9MqSyrPZf/nRTU4Bbz/7Fo/AU/Zob
         flTzgBHnam3r7TDqoJQzNy42Sw8qgKLUYeT2jdGq0zOTyjq8eP7bbOj94zR8FHIs8I6U
         FMepi+jifzTDUIJhVIcIIz0oN3Gsw6Psnav8x+ZKL3IOkbmusnnqpo5JVZyFUIxn5MQy
         fHlg==
X-Forwarded-Encrypted: i=1; AHgh+RqGMqdCyXTgcOok8Uymdnkg7JPsv+qd8vzAgJNN9fRFENzfmsqQk8UGZS5SCKHWMmw1qt/7xvq/IX0EP1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywugvf2Uy2NVYvN62gGiVp3K8a3bCyvUvRyX/5LBiGdeAx04OEG
	TFEJMF/EDuVfmn6YA/l49nKhxzHUTHWNY68ZnipMCl2KJ5G0C9jGNgt743ZTD9l1r00=
X-Gm-Gg: AR+sD101IDBoGuPI8USOtqAaXz0fUj3RybQpExVrQw/5Wy9odA8QJayxnnWO5BOxGKC
	F3jLM15S0FsmrRmhJoXAufHbxaKt2rzhdzc6l58npxYG673OEJjF1u0qTNIJ9Zg0srqRTDXREQ3
	sJ/F9NOgXEeHbNPf0ci3rhJcfPu1NEjByiYOVYfnObbCdQXqX59VO85XNHaLth7AxuxI1XCID++
	WzVzIKE43pW2NpoYnBY56oWXOBT3atcQaphf8ri8Zqo7ct4Pr/FP3Ji6GTyxy/wEEF3x9n4TXKf
	fsTfmhrkbQEecZqCuJKwytk8Pw21+hNjV0MKXE/+XVA40qM/OPdugA23AbsY65fOKp5N8XAc3ya
	fT5P3nJvYIRnizUuUaazOkt4LC3OUsXzRef627TR9jzUWOKoCronso13PLx5BA0RrpRpCdhVn99
	laZsnI+GlByu06/rqj55PP2N9zZzA9KzH+4sqSaoYOaRhE+Dsfe0OVOGgnPp+zSYR5ZrCUscIdF
	wzD+KP7unok8pHFiWmdphSV7Zizv398LRERX4gTFJPz1R5UBzYM
X-Received: by 2002:a05:600c:1906:b0:499:8467:3f2d with SMTP id 5b1f17b1804b1-499879b611dmr47497955e9.19.1786699198380;
        Fri, 14 Aug 2026 02:19:58 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49988ae8b62sm36844295e9.5.2026.08.14.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:19:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Hugo Villeneuve <hugo@hugovil.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/7] serial: 8250: Simplify serial8250_match_port()
Date: Fri, 14 Aug 2026 11:19:30 +0200
Message-ID:  <5723fc435061359f9f6206d20413276de7a659a4.1786697789.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
References: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=TQ2fAV07zoYNEgVpLO4kdUMaIC9Q2NtdaXJZiFWN6G4=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGp+3aqi3MiEBwktDey5S458qdGH55oxfyWa/ViWMpeGka8cK 4kBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJqft2qAAoJEI+A+1h9Ev5OhSQH+wWQ f2zBwDlIPJbB6qX8ngnOQxzvfbkDAm7B1CjKMqVh/4suww926Y3XK1bCRrMPASyYyTH8qAIzR0j h0zYx2hW26Ybgf6GFMZAD1aL5ysOW2EYx80Hq6Defv4MS4pidI14vyfabUdjr9TiNucXr9x2o21 pe+b7eo0jhAkD2quYVB+Y+bHCK5XtLesENTR2wjx4I0tYX//kV0e7YD0t3/mmT7rVMV/Bm0pKjc xZRgV/MS2APIa3mahvyB66nvg/zHVSJAi+ot7tsqVMGxhTcf5Nl1RZTAWBzDSwSeSiaXqAxqP3q QbtP3DjpSPqMvNi3/iGE7Pu6zBTI6dfK7dxrAzY=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For 8250 devices .iotype is never UPIO_BUS, so drop the respective if
branch.

Suggested-by: Hugo Villeneuve <hugo@hugovil.com>
Link: https://lore.kernel.org/linux-serial/20260803152228.9e3cd296a41e68304b82a22a@hugovil.com
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d8199c583830..11424fef7c08 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -692,8 +692,6 @@ static bool serial8250_match_port(const struct uart_port *port1,
 		return hub6_match_port(port1, port2);
 	else if (uart_iotype_mmio(port1->iotype))
 		return port1->mapbase == port2->mapbase;
-	else if (port1->iotype == UPIO_BUS)
-		return true;
 	else
 		return false;
 }
-- 
2.55.0.11.g153666a7d9bb

